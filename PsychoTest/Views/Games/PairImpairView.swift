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
    var startTime: Date?
    var seriesTimes: [TimeInterval] = []
    var nextExpectedPair: Int = 0
    var nextExpectedImpair: Int = 0
    var expectingPair: Bool = true // Start with pair after START

    var averageTime: TimeInterval {
        guard !seriesTimes.isEmpty else { return 0 }
        return seriesTimes.reduce(0, +) / Double(seriesTimes.count)
    }

    func startGame() {
        currentSeries = 0
        seriesTimes = []
        isGameActive = true
        isGameOver = false
        startNewSeries()
    }

    func startNewSeries() {
        hasError = false
        selectedNumbers = []
        expectingPair = true
        nextExpectedPair = 2
        nextExpectedImpair = 1

        // Générer des nombres pairs et impairs mélangés
        var pairs = Array(stride(from: 2, through: 20, by: 2)) // 2,4,6...20
        var impairs = Array(stride(from: 1, through: 19, by: 2)) // 1,3,5...19

        // Mélanger et prendre 5 de chaque
        pairs.shuffle()
        impairs.shuffle()
        pairs = Array(pairs.prefix(5))
        impairs = Array(impairs.prefix(5))

        // Mélanger le tout
        numbers = (pairs + impairs).shuffled()
        startTime = Date()
    }

    func selectNumber(_ number: Int) {
        guard !hasError else { return }

        let isPair = number % 2 == 0

        if expectingPair {
            // On attend un pair
            if isPair && number == nextExpectedPair {
                selectedNumbers.append(number)
                nextExpectedPair += 2
                expectingPair = false
                checkSeriesComplete()
            } else {
                triggerError()
            }
        } else {
            // On attend un impair
            if !isPair && number == nextExpectedImpair {
                selectedNumbers.append(number)
                nextExpectedImpair += 2
                expectingPair = true
                checkSeriesComplete()
            } else {
                triggerError()
            }
        }
    }

    private func triggerError() {
        hasError = true
        // Après une courte pause, on recommence la série
        Task {
            try? await Task.sleep(for: .seconds(1))
            startNewSeries()
        }
    }

    private func checkSeriesComplete() {
        // 5 pairs + 5 impairs = 10 sélections
        if selectedNumbers.count == 10 {
            if let start = startTime {
                seriesTimes.append(Date().timeIntervalSince(start))
            }
            currentSeries += 1

            if currentSeries >= totalSeries {
                isGameActive = false
                isGameOver = true
            } else {
                Task {
                    try? await Task.sleep(for: .milliseconds(500))
                    startNewSeries()
                }
            }
        }
    }

    func isSelected(_ number: Int) -> Bool {
        selectedNumbers.contains(number)
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
        .navigationTitle("Pair ou Impair")
        .navigationBarTitleDisplayMode(.inline)
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
                    Label("Alterne entre PAIR et IMPAIR", systemImage: "arrow.left.arrow.right")
                    Label("Commence par un PAIR (2, 4, 6...)", systemImage: "2.circle")
                    Label("Puis IMPAIR (1, 3, 5...)", systemImage: "1.circle")
                    Label("Toujours en ordre croissant", systemImage: "arrow.up")
                    Label("Erreur = recommencer la série", systemImage: "exclamationmark.triangle")
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
                        Text("\(number)")
                            .font(.title2.weight(.bold))
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
            Text("Sélectionnés: \(viewModel.selectedNumbers.count)/10")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private func buttonColor(for number: Int) -> Color {
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
