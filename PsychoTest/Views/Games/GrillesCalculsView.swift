import SwiftUI

// MARK: - Model
struct Calculation: Identifiable {
    let id = UUID()
    let expression: String
    let displayedResult: Int
    let isCorrect: Bool

    static func generate(allowWrong: Bool = true) -> Calculation {
        let operations = ["+", "-", "×"]
        let operation = operations.randomElement()!

        var num1: Int
        var num2: Int
        var correctResult: Int

        switch operation {
        case "+":
            num1 = Int.random(in: 1...50)
            num2 = Int.random(in: 1...50)
            correctResult = num1 + num2
        case "-":
            num1 = Int.random(in: 20...100)
            num2 = Int.random(in: 1...num1)
            correctResult = num1 - num2
        case "×":
            num1 = Int.random(in: 2...12)
            num2 = Int.random(in: 2...12)
            correctResult = num1 * num2
        default:
            num1 = 1
            num2 = 1
            correctResult = 2
        }

        // Si allowWrong=true, alors isCorrect=false (100% faux)
        // Si allowWrong=false, alors isCorrect=true (100% correct)
        let isCorrect = !allowWrong
        let displayedResult: Int

        if isCorrect {
            displayedResult = correctResult
        } else {
            // Générer une mauvaise réponse proche
            let offset = Int.random(in: 1...5) * (Bool.random() ? 1 : -1)
            displayedResult = correctResult + offset
        }

        return Calculation(
            expression: "\(num1) \(operation) \(num2) = \(displayedResult)",
            displayedResult: displayedResult,
            isCorrect: isCorrect
        )
    }
}

// MARK: - ViewModel
@MainActor
@Observable
final class GrillesCalculsViewModel {
    var calculations: [Calculation] = []
    var selectedWrong: Set<UUID> = []
    var currentGrid: Int = 0
    var totalGrids: Int = 10
    var timeRemaining: Int = 45
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var gridResults: [(correct: Int, wrong: Int, missed: Int)] = []
    var showingResult: Bool = false
    var lastGridScore: (correct: Int, wrong: Int, missed: Int)?

    private var timerTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    var totalScore: Int {
        gridResults.reduce(0) { $0 + $1.correct - $1.wrong - $1.missed }
    }

    var averageAccuracy: Double {
        guard !gridResults.isEmpty else { return 0 }
        let total = gridResults.reduce(0) { $0 + $1.correct + $1.wrong + $1.missed }
        let correct = gridResults.reduce(0) { $0 + $1.correct }
        guard total > 0 else { return 0 }
        return Double(correct) / Double(total) * 100
    }

    func startGame() {
        currentGrid = 0
        gridResults = []
        isGameActive = true
        isGameOver = false
        showingResult = false
        generateGrid()
    }

    private func generateGrid() {
        selectedWrong = []
        showingResult = false
        timeRemaining = 45

        // Générer 9 calculs avec 0 à 4 faux
        let wrongCount = Int.random(in: 1...4)
        var calcs: [Calculation] = []

        for i in 0..<9 {
            let allowWrong = i < wrongCount
            calcs.append(Calculation.generate(allowWrong: allowWrong))
        }

        calculations = calcs.shuffled()
        startTimer()
    }

    private func startTimer() {
        timerTask?.cancel()
        timerTask = Task { @MainActor in
            while !Task.isCancelled && timeRemaining > 0 {
                try? await Task.sleep(for: .seconds(1))
                if Task.isCancelled { break }
                timeRemaining -= 1
            }
            if !Task.isCancelled {
                validateGrid()
            }
        }
    }

    func toggleSelection(_ calc: Calculation) {
        if selectedWrong.contains(calc.id) {
            selectedWrong.remove(calc.id)
        } else {
            selectedWrong.insert(calc.id)
        }
    }

    func validateGrid() {
        timerTask?.cancel()
        showingResult = true

        // Calculer le score
        let actualWrong = Set(calculations.filter { !$0.isCorrect }.map { $0.id })
        let correctSelections = selectedWrong.intersection(actualWrong).count
        let wrongSelections = selectedWrong.subtracting(actualWrong).count
        let missedWrong = actualWrong.subtracting(selectedWrong).count

        lastGridScore = (correctSelections, wrongSelections, missedWrong)
        gridResults.append((correctSelections, wrongSelections, missedWrong))

        // Haptic feedback basé sur la performance
        if wrongSelections == 0 && missedWrong == 0 {
            HapticManager.success()
        } else if wrongSelections > 0 || missedWrong > 0 {
            HapticManager.warning()
        }

        // Passer à la grille suivante après un délai
        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .seconds(2))
            if Task.isCancelled { return }
            currentGrid += 1
            if currentGrid >= totalGrids {
                isGameActive = false
                isGameOver = true
            } else {
                generateGrid()
            }
        }
    }

    /// Trouvés moins fausses sélections moins ratés : peut être négatif.
    func makeResult() -> GameResult? {
        guard isGameOver else { return nil }
        return GameResult(gameType: .grillesCalculs, score: Double(totalScore),
                          correctAnswers: gridResults.reduce(0) { $0 + $1.correct },
                          totalItems: totalGrids, duration: 0)
    }

    func stopGame() {
        timerTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = false
    }

    func isWrong(_ calc: Calculation) -> Bool {
        !calc.isCorrect
    }
}

// MARK: - View
struct GrillesCalculsView: View {
    @State private var viewModel = GrillesCalculsViewModel()

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
        .navigationTitle("Grilles de Calculs")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    GameStatsView(type: .grillesCalculs)
                } label: {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Grilles de Calculs",
                    rules: [
                        RuleItem(icon: "square.grid.3x3", text: "Grille de 9 calculs"),
                        RuleItem(icon: "xmark.circle", text: "0 à 4 calculs sont faux"),
                        RuleItem(icon: "hand.tap", text: "Clique sur les calculs faux"),
                        RuleItem(icon: "checkmark.circle", text: "Valide après chaque grille"),
                        RuleItem(icon: "timer", text: "45 secondes par grille")
                    ],
                    accentColor: .orange
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

            Image(systemName: "square.grid.3x3.fill")
                .font(.system(size: 80))
                .foregroundStyle(.orange)

            Text("Grilles de Calculs")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                Text("Règles du jeu")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Label("Grille de 9 calculs", systemImage: "square.grid.3x3")
                    Label("0 à 4 calculs sont faux", systemImage: "xmark.circle")
                    Label("Clique sur les calculs faux", systemImage: "hand.tap")
                    Label("45 secondes par grille", systemImage: "timer")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("10 grilles au total")
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
                    .background(.orange)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var gameActiveView: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("Grille \(viewModel.currentGrid + 1)/\(viewModel.totalGrids)")
                    .font(.headline)

                Spacer()

                TimerView(timeRemaining: viewModel.timeRemaining, totalTime: 45)
            }

            // Instructions
            Text("Clique sur les calculs FAUX")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Spacer()

            // Grille 3x3
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                ForEach(viewModel.calculations) { calc in
                    CalculationCell(
                        calculation: calc,
                        isSelected: viewModel.selectedWrong.contains(calc.id),
                        showResult: viewModel.showingResult,
                        isActuallyWrong: viewModel.isWrong(calc)
                    ) {
                        if !viewModel.showingResult {
                            viewModel.toggleSelection(calc)
                        }
                    }
                }
            }

            Spacer()

            // Résultat de la grille
            if viewModel.showingResult, let score = viewModel.lastGridScore {
                HStack(spacing: 20) {
                    Label("\(score.correct) trouvés", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                    if score.wrong > 0 {
                        Label("\(score.wrong) erreurs", systemImage: "xmark.circle.fill")
                            .foregroundStyle(.red)
                    }
                    if score.missed > 0 {
                        Label("\(score.missed) ratés", systemImage: "exclamationmark.circle.fill")
                            .foregroundStyle(.orange)
                    }
                }
                .font(.subheadline)
            }

            // Bouton valider
            if !viewModel.showingResult {
                Button {
                    viewModel.validateGrid()
                } label: {
                    Text("Valider")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.orange)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
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
                let stats = viewModel.gridResults.reduce((0, 0, 0)) {
                    ($0.0 + $1.correct, $0.1 + $1.wrong, $0.2 + $1.missed)
                }
                ResultRow(label: "Faux trouvés", value: "\(stats.0)")
                ResultRow(label: "Fausses sélections", value: "\(stats.1)")
                ResultRow(label: "Faux ratés", value: "\(stats.2)")
                Divider()
                ResultRow(label: "Score total", value: "\(viewModel.totalScore)")
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
                    .background(.orange)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

struct CalculationCell: View {
    let calculation: Calculation
    let isSelected: Bool
    let showResult: Bool
    let isActuallyWrong: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(calculation.expression)
                .font(.system(size: 14, weight: .medium, design: .monospaced))
                .minimumScaleFactor(0.7)
                .lineLimit(1)
                .padding(12)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(backgroundColor)
                .foregroundStyle(foregroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(borderColor, lineWidth: 2)
                )
        }
    }

    private var backgroundColor: Color {
        if showResult {
            if isActuallyWrong && isSelected {
                return .green.opacity(0.3)
            } else if isActuallyWrong && !isSelected {
                return .orange.opacity(0.3)
            } else if !isActuallyWrong && isSelected {
                return .red.opacity(0.3)
            }
            return Color(.systemGray6)
        }
        return isSelected ? Color.orange.opacity(0.3) : Color(.systemGray6)
    }

    private var foregroundColor: Color {
        .primary
    }

    private var borderColor: Color {
        if showResult {
            if isActuallyWrong && isSelected {
                return .green
            } else if isActuallyWrong && !isSelected {
                return .orange
            } else if !isActuallyWrong && isSelected {
                return .red
            }
            return .clear
        }
        return isSelected ? .orange : .clear
    }
}

#Preview {
    NavigationStack {
        GrillesCalculsView()
    }
}
