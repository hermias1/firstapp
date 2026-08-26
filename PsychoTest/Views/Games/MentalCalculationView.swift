import SwiftUI

struct MentalCalculationView: View {
    @State private var viewModel = MentalCalculationViewModel()
    @FocusState private var isInputFocused: Bool

    var body: some View {
        VStack(spacing: 24) {
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
        .navigationTitle("Calcul Mental")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    GameStatsView(type: .calculMental)
                } label: {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Calcul Mental",
                    rules: [
                        RuleItem(icon: "plus.forwardslash.minus", text: "Résous des opérations (+, -, ×, ÷)"),
                        RuleItem(icon: "timer", text: "60 secondes au total"),
                        RuleItem(icon: "flame", text: "Le max d'opérations possible"),
                        RuleItem(icon: "star", text: "Bonus de temps pour les réponses rapides")
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

    // MARK: - Start View
    private var startView: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "plus.forwardslash.minus")
                .font(.system(size: 80))
                .foregroundStyle(.blue)

            Text("Calcul Mental")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Résous le maximum d'opérations en 60 secondes")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            VStack(spacing: 12) {
                Text("Difficulté")
                    .font(.headline)

                Picker("Difficulté", selection: $viewModel.difficulty) {
                    ForEach(MentalCalculationViewModel.Difficulty.allCases, id: \.self) { diff in
                        Text(diff.rawValue).tag(diff)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding()

            Spacer()

            Button {
                viewModel.startGame()
                isInputFocused = true
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

    // MARK: - Game Active View
    private var gameActiveView: some View {
        VStack(spacing: 32) {
            HStack {
                ScoreView(
                    score: viewModel.score,
                    correct: viewModel.correctCount,
                    total: viewModel.totalQuestions
                )
                Spacer()
                TimerView(timeRemaining: viewModel.timeRemaining, totalTime: 60)
            }

            Spacer()

            Text(viewModel.currentQuestion)
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .monospacedDigit()

            Text("= ?")
                .font(.system(size: 32, weight: .medium))
                .foregroundStyle(.secondary)

            TextField("Réponse", text: $viewModel.userAnswer)
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .focused($isInputFocused)
                .onSubmit {
                    viewModel.submitAnswer()
                }

            Spacer()

            Button {
                viewModel.submitAnswer()
            } label: {
                Text("Valider")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(viewModel.userAnswer.isEmpty)
        }
    }

    // MARK: - Game Over View
    private var gameOverView: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.green)

            Text("Temps écoulé !")
                .font(.largeTitle)
                .fontWeight(.bold)

            ScoreView(
                score: viewModel.score,
                correct: viewModel.correctCount,
                total: viewModel.totalQuestions
            )

            Spacer()

            Button {
                viewModel.startGame()
                isInputFocused = true
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

#Preview {
    NavigationStack {
        MentalCalculationView()
    }
}
