import Testing
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
