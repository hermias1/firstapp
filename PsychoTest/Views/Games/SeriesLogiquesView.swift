import SwiftUI

// MARK: - Model
struct LogicSequence: Identifiable {
    let id = UUID()
    let sequence: [String]
    let options: [String]
    let correctAnswer: String
    let type: SequenceType

    enum SequenceType {
        case arithmetic      // +2, +3, etc.
        case geometric       // ×2, ×3, etc.
        case fibonacci       // somme des deux précédents
        case alternating     // deux patterns alternés
        case letters         // alphabet
        case custom          // pattern spécial
    }

    static func generate() -> LogicSequence {
        let types: [SequenceType] = [.arithmetic, .geometric, .fibonacci, .alternating, .letters]
        let type = types.randomElement()!

        switch type {
        case .arithmetic:
            return generateArithmetic()
        case .geometric:
            return generateGeometric()
        case .fibonacci:
            return generateFibonacci()
        case .alternating:
            return generateAlternating()
        case .letters:
            return generateLetters()
        case .custom:
            return generateArithmetic()
        }
    }

    private static func generateArithmetic() -> LogicSequence {
        let start = Int.random(in: 1...20)
        let step = Int.random(in: 2...7)
        let sequence = (0..<4).map { String(start + step * $0) }
        let answer = String(start + step * 4)
        let options = generateOptions(correct: answer, isNumber: true)
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .arithmetic)
    }

    private static func generateGeometric() -> LogicSequence {
        let start = Int.random(in: 2...4)
        let multiplier = Int.random(in: 2...3)
        var current = start
        var sequence: [String] = []
        for _ in 0..<4 {
            sequence.append(String(current))
            current *= multiplier
        }
        let answer = String(current)
        let options = generateOptions(correct: answer, isNumber: true)
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .geometric)
    }

    private static func generateFibonacci() -> LogicSequence {
        let a = Int.random(in: 1...5)
        let b = Int.random(in: 1...5)
        var seq = [a, b]
        for _ in 0..<3 {
            seq.append(seq[seq.count - 1] + seq[seq.count - 2])
        }
        let sequence = seq.prefix(4).map { String($0) }
        let answer = String(seq[4])
        let options = generateOptions(correct: answer, isNumber: true)
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .fibonacci)
    }

    private static func generateAlternating() -> LogicSequence {
        let start1 = Int.random(in: 1...10)
        let start2 = Int.random(in: 20...30)
        let step = Int.random(in: 2...4)
        let sequence = [
            String(start1),
            String(start2),
            String(start1 + step),
            String(start2 + step)
        ]
        let answer = String(start1 + step * 2)
        let options = generateOptions(correct: answer, isNumber: true)
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .alternating)
    }

    private static func generateLetters() -> LogicSequence {
        let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let start = Int.random(in: 0...15)
        let step = Int.random(in: 1...3)
        let sequence = (0..<4).map { String(letters[start + step * $0]) }
        let answer = String(letters[start + step * 4])
        let options = generateOptions(correct: answer, isNumber: false)
        return LogicSequence(sequence: sequence, options: options, correctAnswer: answer, type: .letters)
    }

    private static func generateOptions(correct: String, isNumber: Bool) -> [String] {
        var options = [correct]

        if isNumber, let num = Int(correct) {
            // Générer 3 mauvaises réponses proches
            let offsets = [-3, -2, -1, 1, 2, 3, 4, 5].shuffled().prefix(3)
            for offset in offsets {
                options.append(String(num + offset))
            }
        } else {
            // Pour les lettres
            let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
            if let index = letters.firstIndex(of: Character(correct)) {
                let offsets = [-2, -1, 1, 2].shuffled().prefix(3)
                for offset in offsets {
                    let newIndex = (Int(index) + offset + 26) % 26
                    options.append(String(letters[newIndex]))
                }
            }
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
    var score: Int = 0
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var selectedAnswer: String?
    var showFeedback: Bool = false

    private var timerTask: Task<Void, Never>?

    // Barème: +1 bonne réponse, -1/3 mauvaise
    var finalScore: Double {
        Double(correctAnswers) - Double(wrongAnswers) / 3.0
    }

    func startGame() {
        currentQuestion = 0
        score = 0
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
        timerTask = Task {
            while !Task.isCancelled && timeRemaining > 0 {
                try? await Task.sleep(for: .seconds(1))
                if !Task.isCancelled {
                    timeRemaining -= 1
                }
            }
            if !Task.isCancelled {
                handleTimeout()
            }
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
        } else {
            wrongAnswers += 1
        }

        moveToNext()
    }

    private func moveToNext() {
        Task {
            try? await Task.sleep(for: .seconds(1.5))
            currentQuestion += 1

            if currentQuestion >= totalQuestions {
                isGameActive = false
                isGameOver = true
            } else {
                generateQuestion()
            }
        }
    }

    func stopGame() {
        timerTask?.cancel()
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
        .navigationTitle("Séries Logiques")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            viewModel.stopGame()
        }
    }

    private var startView: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "list.number")
                .font(.system(size: 80))
                .foregroundStyle(.green)

            Text("Séries Logiques")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                Text("Règles du jeu")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Label("Complète la série de 4-5 items", systemImage: "list.bullet")
                    Label("Choisis parmi 4 réponses", systemImage: "questionmark.circle")
                    Label("30 secondes par question", systemImage: "timer")
                    Label("+1 bonne réponse, -1/3 mauvaise", systemImage: "plusminus")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("15 questions")
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
                    .foregroundStyle(.green)
                Label("\(viewModel.wrongAnswers)", systemImage: "xmark.circle.fill")
                    .foregroundStyle(.red)
            }
            .font(.subheadline)

            Spacer()

            // Séquence
            if let sequence = viewModel.currentSequence {
                HStack(spacing: 12) {
                    ForEach(sequence.sequence, id: \.self) { item in
                        Text(item)
                            .font(.title.weight(.bold))
                            .frame(width: 50, height: 50)
                            .background(Color(.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    Text("?")
                        .font(.title.weight(.bold))
                        .frame(width: 50, height: 50)
                        .background(Color.green.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
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
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(optionBackground(option, sequence: sequence))
                                .foregroundStyle(optionForeground(option, sequence: sequence))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .disabled(viewModel.selectedAnswer != nil)
                    }
                }
            }

            Spacer()
        }
    }

    private func optionBackground(_ option: String, sequence: LogicSequence) -> Color {
        if viewModel.showFeedback {
            if option == sequence.correctAnswer {
                return .green
            } else if option == viewModel.selectedAnswer {
                return .red
            }
        } else if option == viewModel.selectedAnswer {
            return .green.opacity(0.5)
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
                .foregroundStyle(.green)

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
            .background(Color(.systemGray6))
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
