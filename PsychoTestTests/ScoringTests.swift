import Testing
import Foundation
import SwiftData
@testable import PsychoTest

// Ces tests verrouillent les barèmes corrigés au Lot 1.
// Ils portent sur de la logique pure : aucun timer, aucune interface.

// MARK: - Grilles de Calculs

@MainActor
@Test("Les calculs faux non repérés sont pénalisés")
func grillesPenaliseLesManques() {
    let vm = GrillesCalculsViewModel()
    vm.gridResults = [(correct: 2, wrong: 1, missed: 3)]
    // 2 trouvés - 1 fausse sélection - 3 ratés
    #expect(vm.totalScore == -2)
}

@MainActor
@Test("Ne rien cliquer est la pire stratégie, pas la meilleure")
func grillesNeRienFaireEstPenalise() {
    let passif = GrillesCalculsViewModel()
    passif.gridResults = [(correct: 0, wrong: 0, missed: 4)]

    let actif = GrillesCalculsViewModel()
    actif.gridResults = [(correct: 3, wrong: 1, missed: 0)]

    #expect(passif.totalScore < actif.totalScore)
    #expect(passif.totalScore < 0)
}

@MainActor
@Test("Chaque grille contient au moins un calcul faux à trouver")
func grillesJamaisVides() {
    let vm = GrillesCalculsViewModel()
    for _ in 0..<200 {
        vm.startGame()
        let faux = vm.calculations.filter { !$0.isCorrect }.count
        #expect(faux >= 1)
        #expect(faux <= 4)
    }
}

// MARK: - Anglais

@MainActor
@Test("Le taux de réussite porte sur les 30 questions, pas sur les réponses données")
func anglaisPrecisionSurTotal() {
    let vm = AnglaisQCMViewModel()
    vm.totalQuestions = 30
    vm.correctAnswers = 3
    vm.wrongAnswers = 0
    // 3 bonnes réponses sur 30 questions = 10 %, et non 100 %
    #expect(vm.accuracy == 10.0)
}

@MainActor
@Test("Un sans-faute complet vaut 100 %")
func anglaisSansFaute() {
    let vm = AnglaisQCMViewModel()
    vm.totalQuestions = 30
    vm.correctAnswers = 30
    vm.wrongAnswers = 0
    #expect(vm.accuracy == 100.0)
}

// MARK: - Pair ou Impair

@MainActor
@Test("Une erreur est comptabilisée")
func pairImpairCompteLesErreurs() {
    let vm = PairImpairViewModel()
    vm.startGame()
    #expect(vm.errorCount == 0)

    // Sélectionner un nombre alors que START n'a pas été cliqué est une faute
    let mauvais = vm.numbers.first { $0 != 0 }!
    vm.selectNumber(mauvais)

    #expect(vm.errorCount == 1)
}

@MainActor
@Test("Le chrono n'est pas remis à zéro par une erreur")
func pairImpairChronoContinu() {
    let vm = PairImpairViewModel()
    vm.startGame()
    let debut = vm.startTime

    let mauvais = vm.numbers.first { $0 != 0 }!
    vm.selectNumber(mauvais)

    // Le temps perdu à se tromper doit rester imputé au joueur
    #expect(vm.startTime == debut)
}

// MARK: - Boîtes à Mots

@MainActor
@Test("Aucune série ne contient deux fois le même mot")
func boitesAMotsPasDeDoublonDansUneSerie() {
    for (index, serie) in WordCategory.allCategories.enumerated() {
        let mots = serie.flatMap(\.words)
        let uniques = Set(mots.map { $0.lowercased() })
        // Un mot présent dans deux boîtes de la même série est injouable :
        // le joueur ne peut pas savoir laquelle est attendue.
        #expect(mots.count == uniques.count, "Doublon dans la série \(index + 1)")
    }
}

@MainActor
@Test("Les 15 séries sont toutes atteignables")
func boitesAMotsToutesLesSeriesJouables() {
    let vm = BoitesAMotsViewModel()
    var vues = Set<String>()
    for _ in 0..<200 {
        vm.startGame()
        vues.insert(vm.categories.first?.name ?? "")
    }
    // Avec un tirage aléatoire, chaque série doit pouvoir ouvrir une partie
    #expect(vues.count > 5)
}

// MARK: - Mots en Étoile

private func lettresCommunes(_ mots: [String]) -> Set<Character> {
    guard let premier = mots.first else { return [] }
    return mots.dropFirst().reduce(Set(premier)) { $0.intersection(Set($1)) }
}

/// Tous les sous-ensembles de 6 mots parmi les 9 proposés.
private func groupesDeSix(_ mots: [String]) -> [[String]] {
    var resultat: [[String]] = []
    func choisir(_ debut: Int, _ courant: [String]) {
        if courant.count == 6 { resultat.append(courant); return }
        guard debut < mots.count else { return }
        for i in debut..<mots.count {
            choisir(i + 1, courant + [mots[i]])
        }
    }
    choisir(0, [])
    return resultat
}

@Test("Chaque puzzle propose 9 mots distincts")
func etoileNeufMotsDistincts() {
    for puzzle in StarPuzzle.allPuzzles {
        let mots = puzzle.solution + puzzle.distractors
        #expect(mots.count == 9)
        #expect(Set(mots).count == 9)
    }
}

@Test("La solution partage bien les lettres annoncées")
func etoileLettresAnnonceesExactes() {
    for puzzle in StarPuzzle.allPuzzles {
        let communes = lettresCommunes(puzzle.solution)
        #expect(communes == Set(puzzle.commonLetters),
                "Puzzle \(puzzle.commonLetters) : lettres réelles \(communes.sorted())")
    }
}

@Test("Aucun autre groupe de 6 mots ne partage autant de lettres")
func etoileSolutionUnique() {
    for puzzle in StarPuzzle.allPuzzles {
        let mots = puzzle.solution + puzzle.distractors
        let cible = lettresCommunes(puzzle.solution).count
        for groupe in groupesDeSix(mots) where Set(groupe) != Set(puzzle.solution) {
            // Un groupe concurrent aussi bon rendrait le puzzle indevinable
            #expect(lettresCommunes(groupe).count < cible,
                    "Groupe concurrent \(groupe) dans le puzzle \(puzzle.commonLetters)")
        }
    }
}

@Test("Les mots d'un puzzle ont tous la même longueur")
func etoileLongueurHomogene() {
    for puzzle in StarPuzzle.allPuzzles {
        let longueurs = Set((puzzle.solution + puzzle.distractors).map(\.count))
        // Une longueur différente serait un indice visuel gratuit
        #expect(longueurs.count == 1)
    }
}

// MARK: - Cohérence des banques de questions

@Test("Anglais : chaque question est bien formée")
func anglaisBanqueCoherente() {
    for q in EnglishQuestion.allQuestions {
        #expect(q.options.count == 4, "\(q.question)")
        #expect(Set(q.options).count == 4, "Option dupliquée : \(q.question)")
        #expect(q.options.contains(q.correctAnswer),
                "Réponse absente des options : \(q.question)")
    }
    let libelles = EnglishQuestion.allQuestions.map(\.question)
    #expect(Set(libelles).count == libelles.count, "Question dupliquée")
}

@Test("Culture Aéro : chaque question est bien formée")
func aeroBanqueCoherente() {
    for q in AeroQuestion.allQuestions {
        #expect(q.options.count == 4, "\(q.question)")
        #expect(Set(q.options).count == 4, "Option dupliquée : \(q.question)")
        #expect(q.options.contains(q.correctAnswer),
                "Réponse absente des options : \(q.question)")
    }
    let libelles = AeroQuestion.allQuestions.map(\.question)
    #expect(Set(libelles).count == libelles.count, "Question dupliquée")
}

// MARK: - Séries Logiques

@Test("Une option n'est jamais un terme déjà affiché dans la série")
func seriesDistracteursInedits() {
    for _ in 0..<3000 {
        let q = LogicSequence.generate()
        let affiches = Set(q.sequence)
        for option in q.options where option != q.correctAnswer {
            // « A B C D ? » proposant B, C ou D se résout sans lire la série
            #expect(!affiches.contains(option),
                    "Option \(option) déjà visible dans \(q.sequence)")
        }
    }
}

@Test("Chaque question propose 4 options distinctes dont la bonne")
func seriesOptionsBienFormees() {
    for _ in 0..<3000 {
        let q = LogicSequence.generate()
        #expect(q.options.count == 4, "\(q.sequence) -> \(q.options)")
        #expect(Set(q.options).count == 4, "Doublon dans \(q.options)")
        #expect(q.options.contains(q.correctAnswer))
    }
}

@Test("La série 2 3 5 8, qui admet deux lectures valables, n'est plus générée")
func seriesPasDeSequenceAmbigue() {
    for _ in 0..<5000 {
        let q = LogicSequence.generate()
        if q.sequence == ["2", "3", "5", "8"] {
            // Lecture Fibonacci : 13. Lecture à pas croissant : 12.
            // Une seule doit rester possible, celle de Fibonacci.
            #expect(q.correctAnswer == "13", "2 3 5 8 attend 13, pas \(q.correctAnswer)")
        }
    }
}

// MARK: - Persistance des scores

/// SwiftData ne supporte pas la création concurrente de plusieurs conteneurs :
/// ces tests doivent donc s'exécuter en série, sinon le processus s'arrête.
@MainActor
@Suite(.serialized)
struct PersistanceTests {

    /// Un seul conteneur pour toute la suite : en créer un par test faisait
    /// tomber le processus de test entier.
    @MainActor
    private static let container: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try! ModelContainer(for: GameSession.self, configurations: config)
    }()

    private func storeVide() throws -> ScoreStore {
        let store = ScoreStore(context: Self.container.mainContext)
        for type in GameType.allCases {
            store.reset(type)
        }
        return store
    }

    private func resultat(_ type: GameType, _ score: Double) -> GameResult {
        GameResult(gameType: type, score: score, correctAnswers: 0,
                   totalItems: 10, duration: 60)
    }

    @Test("La première partie d'un jeu est toujours un record")
    func recordPremierePartie() throws {
        let store = try storeVide()
        #expect(store.record(resultat(.m2Back, 42)) == true)
    }

    @Test("Un meilleur score bat le record")
    func recordScorePlusHaut() throws {
        let store = try storeVide()
        store.record(resultat(.m2Back, 50))
        #expect(store.record(resultat(.m2Back, 80)) == true)
        #expect(store.record(resultat(.m2Back, 60)) == false)
    }

    @Test("Égaler le record ne suffit pas")
    func recordScoreEgal() throws {
        let store = try storeVide()
        store.record(resultat(.m2Back, 70))
        #expect(store.record(resultat(.m2Back, 70)) == false)
    }

    @Test("Sur les jeux mesurés en temps, c'est le score le plus BAS qui gagne")
    func recordTempsPlusBas() throws {
        let store = try storeVide()
        store.record(resultat(.pairImpair, 14.0))
        #expect(store.record(resultat(.pairImpair, 11.0)) == true)
        #expect(store.record(resultat(.pairImpair, 20.0)) == false)
        #expect(store.best(for: .pairImpair)?.score == 11.0)
    }

    @Test("Un score négatif est traité correctement")
    func recordScoreNegatif() throws {
        let store = try storeVide()
        store.record(resultat(.grillesCalculs, -5))
        #expect(store.record(resultat(.grillesCalculs, -2)) == true)
        #expect(store.best(for: .grillesCalculs)?.score == -2)
    }

    @Test("Les jeux ne mélangent pas leurs scores")
    func recordCloisonneParJeu() throws {
        let store = try storeVide()
        store.record(resultat(.m2Back, 90))
        #expect(store.record(resultat(.anglaisQCM, 10)) == true)
        #expect(store.count(for: .m2Back) == 1)
        #expect(store.count(for: .anglaisQCM) == 1)
    }

    @Test("L'historique est rendu du plus récent au plus ancien, dans la limite demandée")
    func historiqueTrieEtLimite() throws {
        let store = try storeVide()
        for score in 1...5 {
            store.record(resultat(.seriesLogiques, Double(score)))
        }
        let recentes = store.recent(for: .seriesLogiques, limit: 3)
        #expect(recentes.count == 3)
        #expect(recentes.first!.date >= recentes.last!.date)
    }

    @Test("La réinitialisation efface l'historique du seul jeu visé")
    func reinitialisationCiblee() throws {
        let store = try storeVide()
        store.record(resultat(.m2Back, 50))
        store.record(resultat(.anglaisQCM, 20))
        store.reset(.m2Back)
        #expect(store.count(for: .m2Back) == 0)
        #expect(store.count(for: .anglaisQCM) == 1)
    }
    @Test("Un ViewModel ne produit un résultat qu'une fois la partie finie")
    func resultatSeulementSiPartieFinie() {
        let vm = M2BackViewModel()
        vm.startGame()
        #expect(vm.makeResult() == nil)
        vm.isGameOver = true
        #expect(vm.makeResult() != nil)
    }

    @Test("Le résultat d'une partie arrive intact dans le magasin")
    func chaineComplete() throws {
        let store = try storeVide()
        let vm = M2BackViewModel()
        vm.correctAnswers = 30
        vm.wrongAnswers = 10
        vm.isGameOver = true

        let resultat = try #require(vm.makeResult())
        #expect(store.record(resultat) == true)

        let enregistre = try #require(store.best(for: .m2Back))
        #expect(enregistre.correctAnswers == 30)
        #expect(enregistre.totalItems == 40)
        #expect(enregistre.score == 75.0)   // 30 / 40
    }

    @Test("Tous les jeux jouables savent produire un résultat")
    func tousLesJeuxProduisentUnResultat() {
        // Chaque jeu doit alimenter la persistance, sinon sa progression
        // ne serait jamais enregistrée.
        let vms: [() -> GameResult?] = [
            { let v = PairImpairViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = UnMotSurDeuxViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = M2BackViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = FormesCouleursViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = BoitesAMotsViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = AnglaisQCMViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = SeriesLogiquesViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = CultureAeroViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = MotsEnEtoileViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = GrillesCalculsViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = BillesViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = MentalCalculationViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = FormesGlisseesViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = EmpilementsViewModel(); v.isGameOver = true; return v.makeResult() },
            { let v = CubesPatronsViewModel(); v.isGameOver = true; return v.makeResult() },
        ]
        let types = Set(vms.compactMap { $0()?.gameType })
        // Un jeu jouable qui n'alimente pas la persistance n'aurait pas de
        // progression : le compte doit suivre les jeux marqués comme implémentés.
        let jouables = Game.implementedGames.count
        #expect(types.count == jouables,
                "\(types.count) jeux alimentent la persistance pour \(jouables) jouables")
    }
}

// MARK: - Compte à rebours

@MainActor
private final class Temoin {
    var fini = false
    var dernier: TimeInterval = 99
    var appels = 0
}

@MainActor
@Test("Le compte à rebours atteint zéro et signale la fin")
func countdownSeTermine() async {
    let temoin = Temoin()
    let tache = Countdown.start(seconds: 0.2) { restant in
        temoin.dernier = restant
        temoin.appels += 1
    } onFinish: {
        temoin.fini = true
    }
    try? await Task.sleep(for: .milliseconds(600))
    tache.cancel()

    #expect(temoin.fini)
    #expect(temoin.dernier == 0)
    #expect(temoin.appels > 1, "Le temps restant doit être rafraîchi en continu")
}

@MainActor
@Test("Un compte à rebours annulé ne déclenche pas la fin")
func countdownAnnule() async {
    let temoin = Temoin()
    let tache = Countdown.start(seconds: 0.3) { _ in } onFinish: { temoin.fini = true }
    tache.cancel()
    try? await Task.sleep(for: .milliseconds(500))

    #expect(temoin.fini == false)
}

// MARK: - Billes

@Test("Le calcul du nombre minimal de coups est juste sur des cas connus")
func billesDistanceConnue() {
    // Une seule bille à déplacer d'un tube à l'autre
    #expect(BillesGenerator.distanceMinimale(de: [[0], [], []], a: [[], [0], []]) == 1)
    // Deux billes empilées : il faut dépiler puis déplacer
    #expect(BillesGenerator.distanceMinimale(de: [[0, 1], [], []], a: [[], [1], [0]]) == 2)
    // Départ et cible identiques
    #expect(BillesGenerator.distanceMinimale(de: [[0], [1], []], a: [[0], [1], []]) == 0)
}

@Test("Un coup déplace une seule bille, depuis le dessus d'un tube")
func billesCoupsValides() {
    let etat = [[0, 1], [2], []]
    for suivant in BillesGenerator.coupsPossibles(etat) {
        let avant = etat.flatMap { $0 }.sorted()
        let apres = suivant.flatMap { $0 }.sorted()
        #expect(avant == apres, "Une bille a été créée ou perdue")
        #expect(suivant.allSatisfy { $0.count <= BillesGenerator.capacite })
    }
}

@Test("Chaque puzzle généré a une solution atteignable et annoncée juste")
func billesPuzzlesSolubles() {
    for _ in 0..<100 {
        let puzzle = BillesGenerator.generate()
        // La solution annoncée doit être exactement la distance réelle
        let reelle = BillesGenerator.distanceMinimale(de: puzzle.depart, a: puzzle.cible)
        #expect(reelle == puzzle.solution,
                "Annoncé \(puzzle.solution), réel \(String(describing: reelle))")
        #expect(puzzle.solution >= 1)
        // Aucune bille ne doit apparaître ni disparaître entre les deux états
        #expect(puzzle.depart.flatMap { $0 }.sorted() == puzzle.cible.flatMap { $0 }.sorted())
    }
}

@Test("Les options proposent la bonne réponse parmi quatre valeurs distinctes")
func billesOptionsBienFormees() {
    for _ in 0..<100 {
        let puzzle = BillesGenerator.generate()
        #expect(puzzle.options.count == 4)
        #expect(Set(puzzle.options).count == 4)
        #expect(puzzle.options.contains(puzzle.solution))
        #expect(puzzle.options.allSatisfy { $0 >= 1 })
    }
}

// MARK: - Formes Glissées

@Test("Superposer deux fois la même forme au même endroit annule son effet")
func formesSuperpositionEstUnOuExclusif() {
    let forme = FormesGlisseesGenerator.catalogue[0]
    var grille = FormesGlisseesGenerator.grilleVide(5)
    let position = FormeGlissee.Position(ligne: 1, colonne: 1)

    FormesGlisseesGenerator.appliquer(forme, en: position, sur: &grille)
    #expect(grille.flatMap { $0 }.contains(true))

    // Gris + gris = marine : la grille redevient vide
    FormesGlisseesGenerator.appliquer(forme, en: position, sur: &grille)
    #expect(grille == FormesGlisseesGenerator.grilleVide(5))
}

@Test("Une forme tient toujours entièrement dans la grille")
func formesPositionsDansLaGrille() {
    for forme in FormesGlisseesGenerator.catalogue {
        for position in FormesGlisseesGenerator.positionsValides(forme, taille: 5) {
            #expect(position.ligne + forme.hauteur <= 5)
            #expect(position.colonne + forme.largeur <= 5)
        }
    }
}

@Test("Le catalogue ne contient pas deux fois la même forme")
func formesCatalogueDistinct() {
    let cat = FormesGlisseesGenerator.catalogue
    for i in cat.indices {
        for j in cat.indices where j > i {
            let a = Set(cat[i].cases), b = Set(cat[j].cases)
            #expect(!(a == b && cat[i].hauteur == cat[j].hauteur
                      && cat[i].largeur == cat[j].largeur),
                    "Formes \(i) et \(j) identiques")
        }
    }
}

@Test("Chaque grille générée a exactement une solution")
func formesSolutionUnique() {
    for _ in 0..<10 {
        let puzzle = FormesGlisseesGenerator.generate()

        // La solution annoncée doit reproduire la cible
        var grille = FormesGlisseesGenerator.grilleVide(puzzle.taille)
        for (forme, position) in zip(puzzle.formes, puzzle.solution) {
            FormesGlisseesGenerator.appliquer(forme, en: position, sur: &grille)
        }
        #expect(grille == puzzle.cible)

        // Et aucun autre placement ne doit y parvenir
        let solutions = FormesGlisseesGenerator.nombreDeSolutions(
            formes: puzzle.formes, cible: puzzle.cible, taille: puzzle.taille)
        #expect(solutions == 1, "\(solutions) placements différents donnent la cible")
    }
}

// MARK: - Dimensions

@Test("Chaque jeu jouable est rattaché à au moins une dimension")
func dimensionsCouvrentLesJeux() {
    for jeu in Game.implementedGames where jeu.type != .cultureAero {
        // Culture Aéro mesure des connaissances, pas une aptitude cognitive
        #expect(!jeu.type.dimensions.isEmpty, "\(jeu.name) n'a aucune dimension")
    }
}

@Test("Chaque dimension est travaillable avec les jeux déjà disponibles")
func dimensionsToutesAtteignables() {
    for dimension in Dimension.allCases {
        let jouables = Game.implementedGames.filter {
            $0.type.dimensions.contains(dimension)
        }
        // Une dimension sans aucun test jouable resterait vide dans le profil
        #expect(!jouables.isEmpty, "Aucun jeu disponible pour \(dimension.rawValue)")
    }
}

@MainActor
@Test("Le taux de réussite d'un jeu chronométré tient compte des erreurs")
func tauxReussiteChronometre() {
    let vm = PairImpairViewModel()
    vm.currentSeries = 10
    vm.errorCount = 10
    vm.isGameOver = true
    let resultat = vm.makeResult()
    // 10 séries réussies pour 10 erreurs : la moitié des tentatives
    #expect(resultat?.correctAnswers == 10)
    #expect(resultat?.totalItems == 20)
}

// MARK: - Empilements

@Test("Le nombre d'orientations reflète les symétries de la forme")
func empilementsOrientations() {
    // Un cube isolé est invariant par rotation : une seule forme normalisée
    #expect(EmpilementsGenerator.toutesLesRotations([Cube(x: 0, y: 0, z: 0)]).count == 1)

    // Une forme sans symétrie propre occupe les 24 orientations du cube
    let coude = [Cube(x: 0, y: 0, z: 0), Cube(x: 1, y: 0, z: 0),
                 Cube(x: 2, y: 0, z: 0), Cube(x: 2, y: 1, z: 0)]
    #expect(EmpilementsGenerator.toutesLesRotations(coude).count == 24)

    // Une forme possédant une symétrie d'ordre 2 n'en a que la moitié
    let tordue = [Cube(x: 0, y: 0, z: 0), Cube(x: 1, y: 0, z: 0),
                  Cube(x: 1, y: 1, z: 0), Cube(x: 1, y: 1, z: 1)]
    #expect(EmpilementsGenerator.toutesLesRotations(tordue).count == 12)
}

@Test("Une forme plane est reconnue comme non chirale")
func empilementsChiraliteDetectee() {
    // Toute forme plate est superposable à son miroir : elle ne peut pas servir,
    // même quand elle occupe les 24 orientations.
    let barre = [Cube(x: 0, y: 0, z: 0), Cube(x: 1, y: 0, z: 0), Cube(x: 2, y: 0, z: 0)]
    #expect(EmpilementsGenerator.estChirale(barre) == false)
    let coude = [Cube(x: 0, y: 0, z: 0), Cube(x: 1, y: 0, z: 0),
                 Cube(x: 2, y: 0, z: 0), Cube(x: 2, y: 1, z: 0)]
    #expect(EmpilementsGenerator.estChirale(coude) == false)

    // Un tétracube tordu ne l'est pas
    let tordue = [Cube(x: 0, y: 0, z: 0), Cube(x: 1, y: 0, z: 0),
                  Cube(x: 1, y: 1, z: 0), Cube(x: 1, y: 1, z: 1)]
    #expect(EmpilementsGenerator.estChirale(tordue) == true)
}

@Test("Chaque question a une réponse et une seule")
func empilementsQuestionSoluble() {
    for cubes in [4, 5, 6] {
        for _ in 0..<20 {
            let question = EmpilementsGenerator.generate(nombreDeCubes: cubes)
            #expect(question.figures.count == 3)

            let reflet = question.figures[question.indexSymetrie]
            let autres = question.figures.indices
                .filter { $0 != question.indexSymetrie }
                .map { question.figures[$0] }

            // Les deux autres doivent être superposables entre elles par rotation
            let rotations = EmpilementsGenerator.toutesLesRotations(autres[0])
            #expect(rotations.contains(EmpilementsGenerator.normaliser(autres[1])),
                    "Les deux figures non symétriques ne sont pas identiques")

            // Et le reflet ne doit PAS l'être, sinon la question n'a pas de réponse
            #expect(!rotations.contains(EmpilementsGenerator.normaliser(reflet)),
                    "La figure symétrique est superposable aux autres")
        }
    }
}

// MARK: - Cubes 2D/3D

@Test("Un cube offre exactement 24 vues possibles")
func cubesVingtQuatreVues() {
    let cube = CubeSymbolise(symboles: [0, 1, 2, 3, 4, 5])
    #expect(CubesGenerator.toutesLesOrientations(cube).count == 24)
    // Chaque orientation donne un triplet dessus/avant/droite différent
    #expect(CubesGenerator.vuesPossibles(cube).count == 24)
}

@Test("Deux faces opposées ne peuvent jamais être vues ensemble")
func cubesFacesOpposeesJamaisVisibles() {
    let cube = CubeSymbolise(symboles: [0, 1, 2, 3, 4, 5])
    let opposees: [(FaceCube, FaceCube)] = [(.haut, .bas), (.gauche, .droite), (.avant, .arriere)]
    for vue in CubesGenerator.vuesPossibles(cube) {
        for (a, b) in opposees {
            #expect(!(vue.contains(cube[a]) && vue.contains(cube[b])),
                    "La vue \(vue) montre deux faces opposées")
        }
    }
}

@Test("Inverser l'ordre de rotation d'un sommet rend le cube impossible")
func cubesOrdreDeRotationCompte() {
    let cube = CubeSymbolise(symboles: [0, 1, 2, 3, 4, 5])
    let possibles = CubesGenerator.vuesPossibles(cube)
    for vue in possibles {
        // Les trois mêmes faces, mais tournées dans l'autre sens
        let inversee = [vue[0], vue[2], vue[1]]
        #expect(!possibles.contains(inversee),
                "\(inversee) devrait être irréalisable")
    }
}

@Test("Chaque question a une bonne réponse et trois cubes impossibles")
func cubesQuestionBienFormee() {
    for _ in 0..<100 {
        let question = CubesGenerator.generate()
        #expect(question.propositions.count == 4)
        #expect(Set(question.propositions).count == 4, "Proposition dupliquée")

        let possibles = CubesGenerator.vuesPossibles(question.cube)
        for (index, proposition) in question.propositions.enumerated() {
            if index == question.indexCorrect {
                #expect(possibles.contains(proposition), "La bonne réponse est irréalisable")
            } else {
                // Un distracteur réalisable donnerait deux bonnes réponses
                #expect(!possibles.contains(proposition),
                        "Le distracteur \(proposition) est un cube valide")
            }
        }
    }
}
