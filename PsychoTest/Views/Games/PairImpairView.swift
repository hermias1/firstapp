import SwiftUI

// MARK: - ViewModel
@MainActor
@Observable
final class PairImpairViewModel {
    var numbers: [Int] = []
    var selectedNumbers: [Int] = []
    var currentSeries: Int = 0
    var totalSeries: Int = 10
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var hasError: Bool = false
    var errorCount: Int = 0
    var startTime: Date?
    var seriesTimes: [TimeInterval] = []
    var nextExpectedPair: Int = 0
    var nextExpectedImpair: Int = 0
    var hasStarted: Bool = false // Indique si START a été cliqué
    var expectingPair: Bool = true // Start with pair after START

    private var sortedPairs: [Int] = []
    private var sortedImpairs: [Int] = []
    private var pairIndex: Int = 0
    private var impairIndex: Int = 0
    private var transitionTask: Task<Void, Never>?

    var averageTime: TimeInterval {
        guard !seriesTimes.isEmpty else { return 0 }
        return seriesTimes.reduce(0, +) / Double(seriesTimes.count)
    }

    func startGame() {
        currentSeries = 0
        seriesTimes = []
        errorCount = 0
        isGameActive = true
        isGameOver = false
        startNewSeries()
    }

    func startNewSeries(resetTimer: Bool = true) {
        hasError = false
        selectedNumbers = []
        hasStarted = false
        expectingPair = true
        pairIndex = 0
        impairIndex = 0

        // Générer des nombres pairs et impairs aléatoires
        var pairs = Array(stride(from: 2, through: 20, by: 2)) // 2,4,6...20
        var impairs = Array(stride(from: 1, through: 19, by: 2)) // 1,3,5...19

        // Mélanger et prendre 5 de chaque
        pairs.shuffle()
        impairs.shuffle()
        let selectedPairs = Array(pairs.prefix(5))
        let selectedImpairs = Array(impairs.prefix(5))

        // Trier pour savoir l'ordre attendu
        sortedPairs = selectedPairs.sorted()
        sortedImpairs = selectedImpairs.sorted()

        // Initialiser les premiers attendus
        nextExpectedPair = sortedPairs[0]
        nextExpectedImpair = sortedImpairs[0]

        // Mélanger pour affichage + ajouter "START" (représenté par 0)
        numbers = ([0] + selectedPairs + selectedImpairs).shuffled()
        if resetTimer { startTime = Date() }
    }

    func selectNumber(_ number: Int) {
        guard !hasError else { return }

        // Si c'est le bouton START (0)
        if number == 0 {
            if !hasStarted {
                hasStarted = true
                selectedNumbers.append(0)
                HapticManager.light()
            }
            return
        }

        // Ne peut pas jouer avant d'avoir cliqué START
        guard hasStarted else {
            triggerError()
            return
        }

        let isPair = number % 2 == 0

        if expectingPair {
            // On attend un pair
            if isPair && number == nextExpectedPair {
                selectedNumbers.append(number)
                pairIndex += 1
                // Passer au prochain pair dans la liste triée (s'il existe)
                if pairIndex < sortedPairs.count {
                    nextExpectedPair = sortedPairs[pairIndex]
                }
                expectingPair = false
                HapticManager.success()
                checkSeriesComplete()
            } else {
                triggerError()
            }
        } else {
            // On attend un impair
            if !isPair && number == nextExpectedImpair {
                selectedNumbers.append(number)
                impairIndex += 1
                // Passer au prochain impair dans la liste triée (s'il existe)
                if impairIndex < sortedImpairs.count {
                    nextExpectedImpair = sortedImpairs[impairIndex]
                }
                expectingPair = true
                HapticManager.success()
                checkSeriesComplete()
            } else {
                triggerError()
            }
        }
    }

    private func triggerError() {
        hasError = true
        errorCount += 1
        HapticManager.error()
        // Après une courte pause, une nouvelle série est tirée
        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(1))
            if Task.isCancelled { return }
            startNewSeries(resetTimer: false)
        }
    }

    private func checkSeriesComplete() {
        // START + 5 pairs + 5 impairs = 11 sélections
        if selectedNumbers.count == 11 {
            if let start = startTime {
                seriesTimes.append(Date().timeIntervalSince(start))
            }
            currentSeries += 1

            if currentSeries >= totalSeries {
                isGameActive = false
                isGameOver = true
            } else {
                transitionTask?.cancel()
                transitionTask = Task { @MainActor in
                    try? await Task.sleep(for: .milliseconds(500))
                    if Task.isCancelled { return }
                    startNewSeries()
                }
            }
        }
    }

    func isSelected(_ number: Int) -> Bool {
        selectedNumbers.contains(number)
    }

    /// Temps moyen par série : plus bas est meilleur.
    func makeResult() -> GameResult? {
        guard isGameOver else { return nil }
        // Le total inclut les tentatives ratées : sans cela le taux de
        // réussite vaudrait 100 % même en se trompant à chaque série.
        return GameResult(gameType: .pairImpair, score: averageTime,
                          correctAnswers: currentSeries,
                          totalItems: currentSeries + errorCount,
                          duration: seriesTimes.reduce(0, +))
    }

    func stopGame() {
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = false
    }
}

// MARK: - View
struct PairImpairView: View {
    @State private var viewModel = PairImpairViewModel()

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
        .navigationTitle("Pair ou Impair")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Masqué pendant la partie : empiler cette destination
                // déclenche le onDisappear de la vue, donc stopGame(),
                // ce qui effacerait la partie en cours sans prévenir.
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .pairImpair)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Pair ou Impair",
                    rules: [
                        RuleItem(icon: "play.circle", text: "Clique d'abord sur START"),
                        RuleItem(icon: "arrow.left.arrow.right", text: "Alterne PAIR puis IMPAIR"),
                        RuleItem(icon: "2.circle", text: "Pairs: 2, 4, 6, 8..."),
                        RuleItem(icon: "1.circle", text: "Impairs: 1, 3, 5, 7..."),
                        RuleItem(icon: "arrow.up", text: "Ordre croissant obligatoire"),
                        RuleItem(icon: "exclamationmark.triangle", text: "Erreur = nouvelle série")
                    ],
                    accentColor: .blue,
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

            Image(systemName: "number.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue)

            Text("Pair ou Impair")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                Text("Règles du jeu")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Label("Clique d'abord sur START", systemImage: "play.circle")
                    Label("Alterne PAIR puis IMPAIR", systemImage: "arrow.left.arrow.right")
                    Label("Pairs: 2, 4, 6, 8...", systemImage: "2.circle")
                    Label("Impairs: 1, 3, 5, 7...", systemImage: "1.circle")
                    Label("Ordre croissant obligatoire", systemImage: "arrow.up")
                    Label("Erreur = nouvelle série", systemImage: "exclamationmark.triangle")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("10 séries, le plus vite possible")
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
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var gameActiveView: some View {
        VStack(spacing: 24) {
            // Header
            HStack {
                Text("Série \(viewModel.currentSeries + 1)/\(viewModel.totalSeries)")
                    .font(.headline)

                Spacer()

                Text(viewModel.expectingPair ? "→ PAIR" : "→ IMPAIR")
                    .font(.headline)
                    .foregroundStyle(viewModel.expectingPair ? .blue : .orange)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(viewModel.expectingPair ? Color.blue.opacity(0.15) : Color.orange.opacity(0.15))
                    .clipShape(Capsule())
            }

            if viewModel.hasError {
                Text("Erreur ! Recommence...")
                    .font(.headline)
                    .foregroundStyle(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Spacer()

            // Grille de nombres
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 5), spacing: 12) {
                ForEach(viewModel.numbers, id: \.self) { number in
                    Button {
                        viewModel.selectNumber(number)
                    } label: {
                        Text(number == 0 ? "START" : "\(number)")
                            .font(number == 0 ? .caption.weight(.bold) : .title2.weight(.bold))
                            .frame(width: 56, height: 56)
                            .background(buttonColor(for: number))
                            .foregroundStyle(viewModel.isSelected(number) ? .white : .primary)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(viewModel.isSelected(number) || viewModel.hasError)
                }
            }

            Spacer()

            // Progression
            Text("Sélectionnés: \(viewModel.selectedNumbers.count)/11")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private func buttonColor(for number: Int) -> Color {
        // START button
        if number == 0 {
            return viewModel.isSelected(number) ? .green : .green.opacity(0.3)
        }

        // Nombres pairs et impairs
        if viewModel.isSelected(number) {
            return number % 2 == 0 ? .blue : .orange
        }
        return Color(.systemGray5)
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
                ResultRow(label: "Séries complétées", value: "\(viewModel.currentSeries)")
                ResultRow(label: "Erreurs", value: "\(viewModel.errorCount)")
                ResultRow(label: "Temps moyen", value: String(format: "%.1fs", viewModel.averageTime))
                ResultRow(label: "Temps total", value: String(format: "%.1fs", viewModel.seriesTimes.reduce(0, +)))
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
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

struct ResultRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    NavigationStack {
        PairImpairView()
    }
}
