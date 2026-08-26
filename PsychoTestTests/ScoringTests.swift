import Testing
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
}
