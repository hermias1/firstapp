import SwiftUI

// MARK: - Model
struct LogicSequence: Identifiable {
    let id = UUID()
    let sequence: [String]
    let options: [String]
    let correctAnswer: String
    let type: SequenceType
    let explanation: String  // Explication de la logique

    enum SequenceType {
        case arithmetic          // +2, +3, etc.
        case arithmeticNeg       // -2, -3, etc. (décroissant)
        case geometric           // ×2, ×3, etc.
        case fibonacci           // somme des deux précédents
        case alternating         // deux patterns alternés
        case letters             // alphabet
        case squares             // carrés parfaits (1, 4, 9, 16...)
        case powersOfTwo         // puissances de 2 (2, 4, 8, 16...)
        case primes              // nombres premiers
        case multiples           // multiples (5, 10, 15...)
        case doubleStep          // +1, +2, +3, +4... (1, 2, 4, 7, 11...)
        case squarePlusOne       // n² + 1 (2, 5, 10, 17...)
    }

    static func generate() -> LogicSequence {
        let types: [SequenceType] = [
            .arithmetic, .arithmeticNeg, .geometric, .fibonacci,
            .alternating, .letters, .squares, .powersOfTwo,
            .primes, .multiples, .doubleStep, .squarePlusOne
        ]
        let type = types.randomElement()!

        switch type {
        case .arithmetic:
            return generateArithmetic()
        case .arithmeticNeg:
            return generateArithmeticNeg()
        case .geometric:
            return generateGeometric()
        case .fibonacci:
            return generateFibonacci()
        case .alternating:
            return generateAlternating()
        case .letters:
            return generateLetters()
        case .squares:
            return generateSquares()
        case .powersOfTwo:
            return generatePowersOfTwo()
        case .primes:
            return generatePrimes()
        case .multiples:
            return generateMultiples()
        case .doubleStep:
            return generateDoubleStep()
        case .squarePlusOne:
            return generateSquarePlusOne()
        }
    }

    // Suite arithmétique croissante
    private static func generateArithmetic() -> LogicSequence {
        let start = Int.random(in: 1...15)
        let step = Int.random(in: 2...8)
        let sequence = (0..<4).map { String(start + step * $0) }
        let answer = String(start + step * 4)
        let options = generateOptions(correct: answer, isNumber: true, shown: sequence)
        let explanation = "Suite arithmétique : chaque terme = précédent + \(step)"
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .arithmetic, explanation: explanation)
    }

    // Suite arithmétique décroissante
    private static func generateArithmeticNeg() -> LogicSequence {
        let start = Int.random(in: 50...90)
        let step = Int.random(in: 2...8)
        let sequence = (0..<4).map { String(start - step * $0) }
        let answer = String(start - step * 4)
        let options = generateOptions(correct: answer, isNumber: true, shown: sequence)
        let explanation = "Suite décroissante : chaque terme = précédent - \(step)"
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .arithmeticNeg, explanation: explanation)
    }

    // Suite géométrique (limitée à 99)
    private static func generateGeometric() -> LogicSequence {
        // Combinaisons dont le 5e terme reste sous 100, en évitant les
        // puissances de 2 pures, déjà couvertes par le type powersOfTwo.
        let (start, multiplier) = [(3, 2), (5, 2), (6, 2), (1, 3)].randomElement()!
        var current = start
        var sequence: [String] = []
        for _ in 0..<4 {
            sequence.append(String(current))
            current *= multiplier
        }
        let answer = String(current)
        let options = generateOptions(correct: answer, isNumber: true, shown: sequence)
        let explanation = "Suite géométrique : chaque terme = précédent × \(multiplier)"
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .geometric, explanation: explanation)
    }

    // Fibonacci
    private static func generateFibonacci() -> LogicSequence {
        while true {
            let a = Int.random(in: 1...3)
            let b = Int.random(in: 1...4)
            var seq = [a, b]
            for _ in 0..<3 {
                let next = seq[seq.count - 1] + seq[seq.count - 2]
                if next > 99 { break }
                seq.append(next)
            }
            if seq.count >= 5 {
                let sequence = seq.prefix(4).map { String($0) }
                let answer = String(seq[4])
                let options = generateOptions(correct: answer, isNumber: true, shown: sequence)
                let explanation = "Suite de Fibonacci : chaque terme = somme des 2 précédents"
                return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .fibonacci, explanation: explanation)
            }
        }
    }

    // Alternance
    private static func generateAlternating() -> LogicSequence {
        let start1 = Int.random(in: 1...8)
        let start2 = Int.random(in: 20...35)
        let step = Int.random(in: 2...5)
        let sequence = [
            String(start1),
            String(start2),
            String(start1 + step),
            String(start2 + step)
        ]
        let answer = String(start1 + step * 2)
        let options = generateOptions(correct: answer, isNumber: true, shown: sequence)
        let explanation = "Deux suites entrelacées, chacune progressant de +\(step)"
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .alternating, explanation: explanation)
    }

    // Lettres
    private static func generateLetters() -> LogicSequence {
        let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let step = Int.random(in: 1...4)
        let maxStart = 25 - step * 4
        let start = Int.random(in: 0...maxStart)
        let sequence = (0..<4).map { String(letters[start + step * $0]) }
        let answer = String(letters[start + step * 4])
        let options = generateOptions(correct: answer, isNumber: false, shown: sequence)
        let explanation = "Alphabet : saut de \(step) lettre\(step > 1 ? "s" : "")"
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .letters, explanation: explanation)
    }

    // Carrés parfaits
    private static func generateSquares() -> LogicSequence {
        let start = Int.random(in: 1...3)
        let sequence = (start..<start+4).map { String($0 * $0) }
        let answer = String((start + 4) * (start + 4))
        let options = generateOptions(correct: answer, isNumber: true, shown: sequence)
        let explanation = "Carrés parfaits : \(start)², \(start + 1)², \(start + 2)², \(start + 3)²..."
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .squares, explanation: explanation)
    }

    // Puissances de 2
    private static func generatePowersOfTwo() -> LogicSequence {
        let start = Int.random(in: 0...2)  // 2^0, 2^1, ou 2^2 comme début
        let sequence = (start..<start+4).map { String(1 << $0) }
        let answer = String(1 << (start + 4))
        let options = generateOptions(correct: answer, isNumber: true, shown: sequence)
        let explanation = "Puissances de 2 successives, à partir de 2^\(start)"
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .powersOfTwo, explanation: explanation)
    }

    // Nombres premiers
    private static func generatePrimes() -> LogicSequence {
        let primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
        let start = Int.random(in: 0...primes.count-6)
        let sequence = (0..<4).map { String(primes[start + $0]) }
        let answer = String(primes[start + 4])
        let options = generateOptions(correct: answer, isNumber: true, shown: sequence)
        let explanation = "Nombres premiers : divisibles uniquement par 1 et eux-mêmes"
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .primes, explanation: explanation)
    }

    // Multiples
    private static func generateMultiples() -> LogicSequence {
        let base = [3, 4, 5, 6, 7].randomElement()!
        let start = Int.random(in: 1...3)
        let sequence = (start..<start+4).map { String($0 * base) }
        let answer = String((start + 4) * base)
        let options = generateOptions(correct: answer, isNumber: true, shown: sequence)
        let explanation = "Multiples de \(base), à partir de \(start * base)"
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .multiples, explanation: explanation)
    }

    // Double step (1, 2, 4, 7, 11, 16... +1, +2, +3, +4, +5...)
    private static func generateDoubleStep() -> LogicSequence {
        // start = 2 produirait 2, 3, 5, 8 : une suite de Fibonacci tout aussi
        // valable, dont la réponse (13) diffère de celle attendue ici (12).
        let start = [1, 3, 4, 5, 6, 7, 8, 9].randomElement()!
        var current = start
        var sequence: [String] = [String(current)]
        var step = 1

        for _ in 0..<3 {
            current += step
            sequence.append(String(current))
            step += 1
        }

        current += step
        let answer = String(current)
        let options = generateOptions(correct: answer, isNumber: true, shown: sequence)
        let explanation = "Pas croissant : +1, +2, +3, +4..."
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .doubleStep, explanation: explanation)
    }

    // n² + 1 (2, 5, 10, 17, 26...)
    private static func generateSquarePlusOne() -> LogicSequence {
        // Deux valeurs seulement faisaient revenir la même question d'une
        // partie à l'autre ; la réponse (25 + offset) reste sous 100.
        let offset = Int.random(in: 1...9)
        let sequence = (1..<5).map { String($0 * $0 + offset) }
        let answer = String(5 * 5 + offset)
        let options = generateOptions(correct: answer, isNumber: true, shown: sequence)
        let explanation = "Formule : n² + \(offset)"
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .squarePlusOne, explanation: explanation)
    }

    private static func generateOptions(correct: String, isNumber: Bool,
                                        shown: [String] = []) -> [String] {
        var options = [correct]
        // Un distracteur déjà visible dans la série la trahit
        let interdits = Set(shown)

        if isNumber, let num = Int(correct) {
            // Générer 3 mauvaises réponses proches
            // On élargit progressivement l'écart tant que 3 distracteurs
            // valides n'ont pas été trouvés : près des bornes ou quand la
            // série occupe déjà les valeurs proches, les petits écarts
            // ne suffisent pas.
            var candidats: [String] = []
            for ecart in 1...20 {
                for signe in [-1, 1] {
                    let candidate = num + signe * ecart
                    let texte = String(candidate)
                    if candidate > 0 && candidate <= 99
                        && !options.contains(texte)
                        && !interdits.contains(texte)
                        && !candidats.contains(texte) {
                        candidats.append(texte)
                    }
                }
                if candidats.count >= 6 { break }
            }
            options.append(contentsOf: candidats.shuffled().prefix(3))
        } else {
            // Pour les lettres
            // Toute lettre de l'alphabet peut servir de distracteur,
            // sauf celles déjà visibles dans la série.
            let candidats = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                .map(String.init)
                .filter { !options.contains($0) && !interdits.contains($0) }
            options.append(contentsOf: candidats.shuffled().prefix(3))
        }

        return options.shuffled()
    }
}

// MARK: - ViewModel
@MainActor
@Observable
final class SeriesLogiquesViewModel {
    var currentSequence: LogicSequence?
    var currentQuestion: Int = 0
    var totalQuestions: Int = 15
    var timeRemaining: Int = 30
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var selectedAnswer: String?
    var showFeedback: Bool = false

    private var timerTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    // Barème: +1 bonne réponse, -1/3 mauvaise
    var finalScore: Double {
        Double(correctAnswers) - Double(wrongAnswers) / 3.0
    }

    func startGame() {
        currentQuestion = 0
        correctAnswers = 0
        wrongAnswers = 0
        isGameActive = true
        isGameOver = false
        generateQuestion()
    }

    private func generateQuestion() {
        selectedAnswer = nil
        showFeedback = false
        timeRemaining = 30
        currentSequence = LogicSequence.generate()
        startTimer()
    }

    private func startTimer() {
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: 30) { [self] restant in
            timeRemaining = Int(restant.rounded(.up))
        } onFinish: { [self] in
            handleTimeout()
        }
    }

    private func handleTimeout() {
        wrongAnswers += 1
        showFeedback = true
        moveToNext()
    }

    func selectAnswer(_ answer: String) {
        guard selectedAnswer == nil else { return }

        timerTask?.cancel()
        selectedAnswer = answer
        showFeedback = true

        if answer == currentSequence?.correctAnswer {
            correctAnswers += 1
            HapticManager.success()
        } else {
            wrongAnswers += 1
            HapticManager.error()
        }

        moveToNext()
    }

    private func moveToNext() {
        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            // Plus de temps pour lire l'explication
            try? await Task.sleep(for: .seconds(2.5))
            if Task.isCancelled { return }
            currentQuestion += 1

            if currentQuestion >= totalQuestions {
                isGameActive = false
                isGameOver = true
            } else {
                generateQuestion()
            }
        }
    }

    /// Le score du jeu applique le barème -1/3 par erreur.
    func makeResult() -> GameResult? {
        guard isGameOver else { return nil }
        return GameResult(gameType: .seriesLogiques, score: finalScore,
                          correctAnswers: correctAnswers, totalItems: totalQuestions,
                          duration: 0)
    }

    func stopGame() {
        timerTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = false
    }
}

// MARK: - View
struct SeriesLogiquesView: View {
    @State private var viewModel = SeriesLogiquesViewModel()

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isGameActive {
                gameActiveView
            } else if viewModel.isGameOver {
                gameOverView
            } else {
                startView
            }
        }
        .padding()
        .recordSession(when: viewModel.isGameOver) { viewModel.makeResult() }
        .sortieProtegee(enPartie: viewModel.isGameActive) { viewModel.stopGame() }
        .navigationTitle("Séries Logiques")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Masqué pendant la partie : empiler cette destination
                // déclenche le onDisappear de la vue, donc stopGame(),
                // ce qui effacerait la partie en cours sans prévenir.
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .seriesLogiques)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Séries Logiques",
                    rules: [
                        RuleItem(icon: "list.bullet", text: "Complète la série de 4 items"),
                        RuleItem(icon: "questionmark.circle", text: "Choisis parmi 4 réponses"),
                        RuleItem(icon: "timer", text: "30 secondes par question"),
                        RuleItem(icon: "plus.circle", text: "+1 point si correct"),
                        RuleItem(icon: "minus.circle", text: "-1/3 point si incorrect")
                    ],
                    accentColor: Theme.accentProfond,
                    isGameActive: viewModel.isGameActive
                )
            }
        }
        .onDisappear {
            viewModel.stopGame()
        }
    }

    private var startView: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "list.number")
                .font(.system(size: 80))
                .foregroundStyle(Theme.accentProfond)

            Text("Séries Logiques")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                Text("Règles du jeu")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Label("Complète la série de 4 items", systemImage: "list.bullet")
                    Label("Choisis parmi 4 réponses", systemImage: "questionmark.circle")
                    Label("30 secondes par question", systemImage: "timer")
                    Label("+1 bonne réponse, -1/3 mauvaise", systemImage: "plusminus")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("15 questions • 12 types de logiques")
                .font(.callout)
                .foregroundStyle(.secondary)

            Spacer()

            Button {
                viewModel.startGame()
            } label: {
                Text("Commencer")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.green)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var gameActiveView: some View {
        VStack(spacing: 24) {
            // Header
            HStack {
                Text("Question \(viewModel.currentQuestion + 1)/\(viewModel.totalQuestions)")
                    .font(.headline)

                Spacer()

                TimerView(timeRemaining: viewModel.timeRemaining, totalTime: 30)
            }

            // Score actuel
            HStack(spacing: 16) {
                Label("\(viewModel.correctAnswers)", systemImage: "checkmark.circle.fill")
                    .foregroundStyle(Theme.vert)
                Label("\(viewModel.wrongAnswers)", systemImage: "xmark.circle.fill")
                    .foregroundStyle(Theme.rouge)
            }
            .font(.subheadline)

            Spacer()

            // Séquence
            if let sequence = viewModel.currentSequence {
                HStack(spacing: 8) {
                    ForEach(sequence.sequence, id: \.self) { item in
                        Text(item)
                            .font(.title.weight(.bold))
                            .minimumScaleFactor(0.5)  // Adaptation automatique
                            .lineLimit(1)
                            .frame(width: 60, height: 60)
                            .background(Color(.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    Text("?")
                        .font(.title.weight(.bold))
                        .frame(width: 60, height: 60)
                        .background(Theme.accentProfond.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                // Explication de la logique (affichée après réponse)
                if viewModel.showFeedback {
                    VStack(spacing: 8) {
                        if viewModel.selectedAnswer == sequence.correctAnswer {
                            Text("✓ Correct !")
                                .font(.headline)
                                .foregroundStyle(Theme.vert)
                        } else {
                            Text("✗ Réponse : \(sequence.correctAnswer)")
                                .font(.headline)
                                .foregroundStyle(Theme.rouge)
                        }

                        Text(sequence.explanation)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                    .background(Theme.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Spacer()

                // Options
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(sequence.options, id: \.self) { option in
                        Button {
                            viewModel.selectAnswer(option)
                        } label: {
                            Text(option)
                                .font(.title2.weight(.semibold))
                                .minimumScaleFactor(0.6)  // Adaptation
                                .lineLimit(1)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(optionBackground(option, sequence: sequence))
                                .foregroundStyle(optionForeground(option, sequence: sequence))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .disabled(viewModel.selectedAnswer != nil || viewModel.showFeedback)
                    }
                }
            }

            Spacer()
        }
    }

    private func optionBackground(_ option: String, sequence: LogicSequence) -> Color {
        if viewModel.showFeedback {
            if option == sequence.correctAnswer {
                return Theme.vert
            } else if option == viewModel.selectedAnswer {
                return Theme.rouge
            }
        } else if option == viewModel.selectedAnswer {
            return Theme.vert.opacity(0.5)
        }
        return Color(.systemGray5)
    }

    private func optionForeground(_ option: String, sequence: LogicSequence) -> Color {
        if viewModel.showFeedback && (option == sequence.correctAnswer || option == viewModel.selectedAnswer) {
            return .white
        }
        return .primary
    }

    private var gameOverView: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(Theme.accentProfond)

            Text("Terminé !")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                ResultRow(label: "Bonnes réponses", value: "\(viewModel.correctAnswers)")
                ResultRow(label: "Mauvaises réponses", value: "\(viewModel.wrongAnswers)")
                Divider()
                ResultRow(label: "Score final", value: String(format: "%.1f", viewModel.finalScore))
            }
            .padding()
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("Barème: +1 correct, -1/3 incorrect")
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()

            Button {
                viewModel.startGame()
            } label: {
                Text("Rejouer")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.green)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    NavigationStack {
        SeriesLogiquesView()
    }
}

