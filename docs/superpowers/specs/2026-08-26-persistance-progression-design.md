# Persistance des scores et progression

**Date :** 26 août 2026
**Statut :** design validé, prêt pour plan d'implémentation

## Problème

L'application ne conserve rien. `Models/Score.swift` définit une structure `Score`
mais elle n'est instanciée nulle part, et le projet ne contient aucun appel à
`UserDefaults`, `SwiftData` ou `@AppStorage`.

Conséquence : une partie terminée disparaît dès que l'utilisateur quitte l'écran.
Aucun record, aucun historique, aucune progression visible. Pour une application
d'entraînement, c'est ce qui empêche l'utilisateur de revenir : rien ne mesure
ses progrès d'une session à l'autre.

## Objectif

Chaque partie terminée est enregistrée durablement. L'utilisateur voit son
meilleur score par jeu et l'évolution de ses dernières parties.

### Critères de succès

1. Une partie terminée survit à la fermeture complète de l'application.
2. Le meilleur score de chaque jeu apparaît sur sa carte dans le menu.
3. Un bandeau « Nouveau record ! » s'affiche en fin de partie quand le score dépasse le précédent record.
4. Un écran par jeu affiche le record, le nombre de parties et la courbe des 20 dernières.
5. Une partie donnée n'est enregistrée qu'une seule fois, même si la vue réapparaît.
6. Le record est correct pour les jeux où un score plus bas est meilleur.

### Hors périmètre

Synchronisation iCloud, série de jours consécutifs (streak), badges, analytics,
classement en ligne, export de données. Ces sujets sont volontairement exclus et
feront l'objet de décisions séparées.

## Architecture

### 1. Identité stable des jeux

`Game.id` est un `UUID()` régénéré à chaque lancement : il ne peut pas servir de
clé de persistance. L'énumération `GameType` existe déjà dans `Models/Game.swift`
avec ses 17 cas mais n'est reliée à rien.

`Game` reçoit donc un champ `let type: GameType`, et `type.rawValue` devient la
clé de persistance.

Effet de bord voulu : `MainMenuView` route aujourd'hui par comparaison de chaînes
(`switch game.name { case "Pair ou Impair": … }`), ce qui casse silencieusement la
navigation au moindre renommage. Le routage passe à `switch game.type`, exhaustif
et vérifié par le compilateur.

### 2. Modèle stocké

```swift
@Model
final class GameSession {
    var gameType: String        // GameType.rawValue
    var date: Date
    var score: Double           // métrique principale du jeu
    var correctAnswers: Int
    var totalItems: Int
    var duration: TimeInterval
}
```

Le conteneur est déclaré dans `PsychoTestApp` via
`.modelContainer(for: GameSession.self)`.

Les classes `@Model` ne sont pas `Sendable`. Tous les accès passent donc par le
`mainContext` sur `@MainActor`, ce qui est suffisant : les écritures sont rares
(une par partie) et les lectures alimentent directement l'interface.

### 3. Comparaison de scores hétérogènes

Les jeux ne se mesurent pas dans la même unité : 90 % de bonnes réponses en
anglais, 12,4 s de moyenne à Pair ou Impair, 28 points à Culture Aéro. Aucun score
universel n'est inventé — il serait arbitraire et trompeur. Chaque `GameType`
déclare comment se lire :

```swift
extension GameType {
    var lowerIsBetter: Bool     // true pour pairImpair et unMotSurDeux
    var scoreUnit: ScoreUnit    // .percent, .points, .seconds
}
```

Métriques retenues, relevées dans le code existant :

| Jeu | `score` | Unité | Sens | `totalItems` |
|---|---|---|---|---|
| Pair ou Impair | `averageTime` | secondes | **plus bas = mieux** | 10 séries |
| Un Mot sur Deux | `averageTime` | secondes | **plus bas = mieux** | 10 séries |
| M2 Back | `accuracy` (déjà en %) | % | plus haut = mieux | `correct + wrong` |
| Formes et Couleurs | `accuracy` (déjà en %) | % | plus haut = mieux | `correct + wrong` |
| Boîtes à Mots | `accuracy` (déjà en %) | % | plus haut = mieux | `correct + wrong` |
| Anglais | `correctAnswers` | points | plus haut = mieux | 30 |
| Séries Logiques | `correctAnswers` | points | plus haut = mieux | 15 |
| Mots en Étoile | `correctAnswers` | points | plus haut = mieux | 10 |
| Culture Aéro | `score` (avec malus) | points | plus haut = mieux | 30 |
| Grilles de Calculs | `totalScore` (`correct - wrong`) | points | plus haut = mieux | 10 grilles |

Deux jeux se mesurent en temps et deux scores peuvent être négatifs (Grilles de
Calculs et Culture Aéro appliquent des malus). Le calcul du record et le
formatage d'affichage doivent traiter ces deux cas.

### 4. Les ViewModels ne connaissent pas SwiftData

Les 10 ViewModels restent des objets purs. Chacun expose une méthode sans effet
de bord :

```swift
func makeResult() -> GameResult? {
    guard isGameOver else { return nil }
    return GameResult(gameType: .m2Back, score: accuracy,
                      correctAnswers: correctAnswers,
                      totalItems: correctAnswers + wrongAnswers,
                      duration: elapsed)
}
```

Deux pièges relevés dans le code existant :

- `accuracy` renvoie **déjà** un pourcentage entre 0 et 100 (`… / total * 100`)
  dans M2 Back, Anglais, Formes et Couleurs et Boîtes à Mots. Aucune
  multiplication supplémentaire ne doit être appliquée.
- `accuracy` se calcule sur `correctAnswers + wrongAnswers`, et non sur le nombre
  total d'items du jeu. Les items expirés sans réponse en sont donc absents. Pour
  rester cohérent avec le pourcentage affiché, `totalItems` reprend la même somme
  plutôt que le nombre nominal d'items.

`GameResult` est une `struct` de valeurs, indépendante de SwiftData. Toute la
logique de scoring devient donc testable sans base de données, sans simulateur et
sans interface.

### 5. Le pont vue / stockage

Un `ViewModifier` unique, écrit une fois et appliqué en une ligne par jeu :

```swift
.recordSession(when: viewModel.isGameOver) { viewModel.makeResult() }
```

Il lit le `modelContext` de l'environnement et enregistre la partie.

Il embarque une garde contre la double écriture : `isGameOver` peut rebasculer et
la vue peut réapparaître dans la pile de navigation. Sans garde, une même partie
serait comptée deux fois — et fausserait à la fois le nombre de parties et le
record. Le flag de garde est remis à zéro quand `isGameOver` repasse à `false`,
c'est-à-dire au démarrage de la partie suivante.

### 6. Le store

```swift
@MainActor
struct ScoreStore {
    let context: ModelContext
    func record(_ result: GameResult) -> Bool          // true = nouveau record
    func best(for type: GameType) -> GameSession?
    func recent(for type: GameType, limit: Int) -> [GameSession]
}
```

Le booléen renvoyé par `record` alimente le bandeau « Nouveau record ! ». Il est
calculé **avant** l'insertion, en comparant au meilleur score existant, avec le
sens de comparaison propre au jeu.

Un type dédié est préféré à des `@Query` dispersés dans les vues : la logique de
record vit à un seul endroit et se teste directement.

### 7. Interface

Trois points de contact, aucun nouvel onglet :

1. **`GameCard`** — le record sous le titre du jeu, rien si jamais joué.
2. **Écran de fin de partie** — bandeau « Nouveau record ! » quand `record()` renvoie `true`.
3. **`GameStatsView`** — record, nombre de parties, courbe des 20 dernières via
   Swift Charts (natif, aucune dépendance), et bouton de réinitialisation.

`GameStatsView` s'atteint par une icône dans la barre d'outils de chaque jeu, à
côté du bouton de règles existant, et par un lien depuis l'écran de fin.

### 8. Rétention des données

Aucune purge. Une partie pèse environ 100 octets ; un utilisateur très assidu sur
deux ans produirait de l'ordre de 500 Ko. Une politique de rétention imposerait
de ne jamais supprimer la partie détenant le record — une complexité réelle pour
un problème inexistant.

Le bouton de réinitialisation de `GameStatsView` couvre le besoin de l'utilisateur
qui veut repartir de zéro.

## Gestion des erreurs

L'écriture SwiftData peut échouer (disque plein). Une partie perdue n'est pas un
incident critique : l'échec est journalisé et l'interface n'affiche pas d'erreur
bloquante. Le jeu reste jouable.

Une lecture qui ne renvoie rien (aucune partie enregistrée) est un cas normal, pas
une erreur : les cartes n'affichent alors aucun record et `GameStatsView` affiche
un état vide.

## Tests

Le projet ne contient aujourd'hui aucune cible de test. Une cible de tests
unitaires est ajoutée à `project.pbxproj`, avec Swift Testing.

Le fichier `project.pbxproj` est maintenu à la main (identifiants `A1000001` /
`B1000001`, `objectVersion = 56`, sans synchronisation automatique des dossiers) :
tout nouveau fichier doit y être déclaré explicitement, sous peine de ne pas être
compilé silencieusement.

Couverture visée, sur la logique pure :

- `record()` détecte un record quand le score est plus haut, pour un jeu normal.
- `record()` détecte un record quand le score est plus **bas**, pour Pair ou Impair et Un Mot sur Deux.
- `record()` ne signale pas de record quand le score égale le précédent.
- Un score négatif (Grilles de Calculs, Culture Aéro) est traité correctement.
- La première partie d'un jeu est toujours un record.
- La garde anti-double-écriture : deux déclenchements consécutifs n'enregistrent qu'une partie.
- `recent()` renvoie les parties triées par date décroissante et respecte la limite.
- `makeResult()` renvoie `nil` tant que la partie n'est pas terminée.

## Fichiers touchés

**Créés**

- `PsychoTest/Models/GameResult.swift`
- `PsychoTest/Models/GameSession.swift`
- `PsychoTest/Services/ScoreStore.swift`
- `PsychoTest/Views/Components/RecordSessionModifier.swift`
- `PsychoTest/Views/GameStatsView.swift`
- cible de tests unitaires et ses fichiers

**Modifiés**

- `PsychoTest/Models/Game.swift` — champ `type`, extensions `lowerIsBetter` et `scoreUnit`
- `PsychoTest/Views/MainMenuView.swift` — routage par `GameType`
- `PsychoTest/App/PsychoTestApp.swift` — déclaration du conteneur
- `PsychoTest/Views/Components/GameCard.swift` — affichage du record
- les 10 vues de jeux — une ligne de modificateur, une entrée de barre d'outils
- les 10 ViewModels — méthode `makeResult()`
- `PsychoTest.xcodeproj/project.pbxproj`

**Supprimé**

- `PsychoTest/Models/Score.swift` — remplacé par `GameSession` et `GameResult`, et déjà inutilisé

## Risques

**Édition manuelle de `project.pbxproj`.** L'ajout d'une cible de test se fait
sans interface Xcode. Vérification immédiate par `xcodebuild -list` puis
`xcodebuild test` ; en cas de corruption, `git` restaure le fichier.

**Un fichier oublié dans le projet compile sans erreur mais reste absent du
binaire.** Chaque nouveau fichier est vérifié par une compilation qui l'utilise
réellement.

**Régression de navigation.** Le passage du routage par nom au routage par
`GameType` touche l'accès aux 10 jeux. Le compilateur garantit l'exhaustivité du
`switch`, et les 10 jeux sont ouverts une fois dans le simulateur avant de
considérer l'étape terminée.
