import SwiftUI

// MARK: - ViewModel
@MainActor
@Observable
final class M2BackViewModel {
    var currentNumber: Int = 0
    var history: [Int] = []
    var currentIndex: Int = 0
    var totalNumbers: Int = 42
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var isShowingNumber: Bool = false
    var isWaitingForAnswer: Bool = false
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var feedback: AnswerFeedback?
    var timeRemaining: Double = 3.0

    private var sequence: [Int] = []
    private var timerTask: Task<Void, Never>?
    private var answerTimerTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    enum AnswerFeedback {
        case correct
        case wrong
    }

    var accuracy: Double {
        let total = correctAnswers + wrongAnswers
        guard total > 0 else { return 0 }
        return Double(correctAnswers) / Double(total) * 100
    }

    func startGame() {
        history = []
        currentIndex = 0
        correctAnswers = 0
        wrongAnswers = 0
        isGameActive = true
        isGameOver = false
        feedback = nil
        generateSequence()
        showNextNumber()
    }

    private func generateSequence() {
        // Générer une séquence probabiliste intelligente avec auto-équilibrage
        sequence = []

        // Générer 2 premiers nombres aléatoires (pas de match possible)
        sequence.append(Int.random(in: 0...9))
        sequence.append(Int.random(in: 0...9))

        var matchCount: Int = 0  // Nombre de matches générés
        let targetMatchRate = 0.5  // Objectif : 50% de matches en moyenne

        for i in 2..<totalNumbers {
            // Calculer combien de matches on devrait avoir à ce stade
            let expectedMatches = Double(i - 2) * targetMatchRate
            let actualMatches = Double(matchCount)
            let debt = expectedMatches - actualMatches  // Dette de matches

            // Ajuster la probabilité selon la dette
            // Si debt > 0 : on est en retard, augmenter la probabilité
            // Si debt < 0 : on est en avance, diminuer la probabilité
            let baseProbability = 0.5
            let adjustment = debt * 0.1  // Facteur d'ajustement progressif
            var probability = baseProbability + adjustment

            // Limiter entre 20% et 80% pour garder de l'imprévisibilité
            probability = min(max(probability, 0.2), 0.8)

            // Décision probabiliste
            if Double.random(in: 0...1) < probability {
                // Match : répéter le nombre de n-2
                sequence.append(sequence[i - 2])
                matchCount += 1
            } else {
                // Pas de match : générer un nombre différent de n-2
                var newNumber: Int
                repeat {
                    newNumber = Int.random(in: 0...9)
                } while newNumber == sequence[i - 2]
                sequence.append(newNumber)
            }
        }
    }

    private func showNextNumber() {
        guard currentIndex < totalNumbers else {
            endGame()
            return
        }

        feedback = nil
        currentNumber = sequence[currentIndex]
        isShowingNumber = true
        isWaitingForAnswer = false

        // Afficher le nombre pendant 1 seconde
        timerTask?.cancel()
        timerTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(1))
            if Task.isCancelled { return }
            isShowingNumber = false

            // Les 2 premiers nombres : pas de question (pas de n-2 encore)
            if currentIndex < 2 {
                // Passer directement au suivant sans demander de réponse
                moveToNext()
            } else {
                // À partir du 3ème nombre : demander si ça match n-2
                isWaitingForAnswer = true
                timeRemaining = 3.0
                startAnswerTimer()
            }
        }
    }

    private func startAnswerTimer() {
        answerTimerTask?.cancel()
        answerTimerTask = Countdown.start(seconds: 3.0) { [self] restant in
            timeRemaining = restant
        } onFinish: { [self] in
            // Temps écoulé = mauvaise réponse
            if isWaitingForAnswer { handleTimeout() }
        }
    }

    private func handleTimeout() {
        isWaitingForAnswer = false
        wrongAnswers += 1
        feedback = .wrong
        moveToNext()
    }

    func answer(isMatch: Bool) {
        guard isWaitingForAnswer else { return }

        answerTimerTask?.cancel()
        isWaitingForAnswer = false

        // Vérifier si c'est un M2 match
        let actualMatch: Bool
        if currentIndex >= 2 {
            actualMatch = sequence[currentIndex] == sequence[currentIndex - 2]
        } else {
            actualMatch = false
        }

        if isMatch == actualMatch {
            correctAnswers += 1
            feedback = .correct
            HapticManager.success()
        } else {
            wrongAnswers += 1
            feedback = .wrong
            HapticManager.error()
        }

        moveToNext()
    }

    private func moveToNext() {
        history.append(currentNumber)
        currentIndex += 1

        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(500))
            if Task.isCancelled { return }
            showNextNumber()
        }
    }

    private func endGame() {
        timerTask?.cancel()
        answerTimerTask?.cancel()
        isGameActive = false
        isGameOver = true
    }

    func makeResult() -> GameResult? {
        guard isGameOver else { return nil }
        return GameResult(gameType: .m2Back, score: accuracy,
                          correctAnswers: correctAnswers,
                          totalItems: correctAnswers + wrongAnswers, duration: 0)
    }

    func stopGame() {
        timerTask?.cancel()
        answerTimerTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = false
    }
}

// MARK: - View
struct M2BackView: View {
    @State private var viewModel = M2BackViewModel()

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
        .navigationTitle("M2 Back")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    GameStatsView(type: .m2Back)
                } label: {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - M2 Back",
                    rules: [
                        RuleItem(icon: "eye", text: "Un chiffre s'affiche pendant 1 seconde"),
                        RuleItem(icon: "timer", text: "Tu as 3 secondes pour répondre"),
                        RuleItem(icon: "checkmark.circle", text: "OUI si le chiffre = celui d'il y a 2 coups"),
                        RuleItem(icon: "xmark.circle", text: "NON sinon"),
                        RuleItem(icon: "number", text: "42 chiffres au total")
                    ],
                    accentColor: .purple,
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

            Image(systemName: "brain.head.profile")
                .font(.system(size: 80))
                .foregroundStyle(.purple)

            Text("M2 Back")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                Text("Règles du jeu")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Label("Un chiffre s'affiche pendant 1s", systemImage: "eye")
                    Label("Tu as 3s pour répondre", systemImage: "timer")
                    Label("OUI si le chiffre = celui d'il y a 2 coups", systemImage: "checkmark.circle")
                    Label("NON sinon", systemImage: "xmark.circle")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("42 chiffres au total")
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
                    .background(.purple)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var gameActiveView: some View {
        VStack(spacing: 24) {
            // Header
            HStack {
                Text("\(viewModel.currentIndex + 1)/\(viewModel.totalNumbers)")
                    .font(.headline)

                Spacer()

                HStack(spacing: 16) {
                    Label("\(viewModel.correctAnswers)", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                    Label("\(viewModel.wrongAnswers)", systemImage: "xmark.circle.fill")
                        .foregroundStyle(.red)
                }
                .font(.subheadline)
            }

            Spacer()

            // Zone d'affichage du nombre
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(.systemGray6))
                    .frame(width: 200, height: 200)

                if viewModel.isShowingNumber {
                    Text("\(viewModel.currentNumber)")
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                } else if viewModel.isWaitingForAnswer {
                    Text("?")
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondary)
                }
            }

            // Message d'aide
            if viewModel.isWaitingForAnswer {
                Text("Mémorise !")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            // Feedback
            if let feedback = viewModel.feedback {
                Text(feedback == .correct ? "Correct !" : "Faux !")
                    .font(.headline)
                    .foregroundStyle(feedback == .correct ? .green : .red)
            }

            // Timer bar
            if viewModel.isWaitingForAnswer {
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.purple.opacity(0.3))
                        .frame(height: 8)
                        .overlay(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.purple)
                                .frame(width: geo.size.width * (viewModel.timeRemaining / 3.0))
                        }
                }
                .frame(height: 8)
            }

            Spacer()

            // Boutons de réponse
            if viewModel.isWaitingForAnswer {
                HStack(spacing: 20) {
                    Button {
                        viewModel.answer(isMatch: false)
                    } label: {
                        Text("NON")
                            .font(.title2.weight(.bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(.red)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    Button {
                        viewModel.answer(isMatch: true)
                    } label: {
                        Text("OUI")
                            .font(.title2.weight(.bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(.green)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
        }
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
                ResultRow(label: "Précision", value: String(format: "%.0f%%", viewModel.accuracy))
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Spacer()

            Button {
                viewModel.startGame()
            } label: {
                Text("Rejouer")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.purple)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    NavigationStack {
        M2BackView()
    }
}
