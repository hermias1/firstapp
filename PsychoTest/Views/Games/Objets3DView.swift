import SwiftUI

// MARK: - Modèle

/// Sous quel angle on regarde l'empilement.
enum PointDeVue: String, CaseIterable {
    case dessus = "de dessus"
    case face = "de face"
    case cote = "de côté"

    /// Les deux coordonnées conservées par la projection.
    func projeter(_ cube: Cube) -> (Int, Int) {
        switch self {
        case .dessus: return (cube.x, cube.y)
        case .face: return (cube.x, cube.z)
        case .cote: return (cube.y, cube.z)
        }
    }
}

enum Objets3DGenerator {
    /// Silhouette de l'empilement vue sous cet angle, sous forme de grille.
    ///
    /// La projection perd la profondeur : deux cubes alignés dans l'axe du
    /// regard ne forment qu'une seule case.
    static func projection(_ empilement: Empilement, vue: PointDeVue) -> [[Bool]] {
        let points = empilement.map(vue.projeter)
        guard let maxA = points.map(\.0).max(), let maxB = points.map(\.1).max() else {
            return []
        }
        var grille = Array(repeating: Array(repeating: false, count: maxA + 1),
                           count: maxB + 1)
        for (a, b) in points {
            // De face et de côté, la seconde coordonnée est l'altitude : elle
            // croît vers le haut, alors que les lignes d'une grille s'affichent
            // du haut vers le bas. Sans cette inversion, la silhouette proposée
            // est le reflet vertical de ce que montre le dessin.
            let ligne = vue == .dessus ? b : maxB - b
            grille[ligne][a] = true
        }
        return grille
    }

    /// Variante d'une silhouette : une case ajoutée ou retirée.
    static func muter(_ grille: [[Bool]]) -> [[Bool]] {
        guard !grille.isEmpty, !grille[0].isEmpty else { return grille }
        var copie = grille
        let ligne = Int.random(in: 0..<copie.count)
        let colonne = Int.random(in: 0..<copie[0].count)
        copie[ligne][colonne].toggle()
        return copie
    }

    struct Question {
        let empilement: Empilement
        let vue: PointDeVue
        let propositions: [[[Bool]]]
        let indexCorrect: Int
    }

    static func generate(nombreDeCubes: Int = 6) -> Question {
        for _ in 0..<200 {
            let empilement = EmpilementsGenerator.formeAleatoire(nombreDeCubes: nombreDeCubes)
            guard empilement.count == nombreDeCubes,
                  let vue = PointDeVue.allCases.randomElement() else { continue }

            let correcte = projection(empilement, vue: vue)
            // Une silhouette trop petite ne distingue rien
            guard correcte.flatMap({ $0 }).filter({ $0 }).count >= 3 else { continue }

            var fausses: [[[Bool]]] = []
            var tentatives = 0
            while fausses.count < 3 && tentatives < 300 {
                tentatives += 1
                let candidate = muter(correcte)
                // Une silhouette vide, identique à la bonne réponse ou déjà
                // proposée ne ferait pas un distracteur
                guard candidate != correcte,
                      candidate.flatMap({ $0 }).contains(true),
                      !fausses.contains(candidate) else { continue }
                fausses.append(candidate)
            }
            guard fausses.count == 3 else { continue }

            var propositions = fausses
            let index = Int.random(in: 0...3)
            propositions.insert(correcte, at: index)
            return Question(empilement: empilement, vue: vue,
                            propositions: propositions, indexCorrect: index)
        }

        let empilement = [Cube(x: 0, y: 0, z: 0), Cube(x: 1, y: 0, z: 0),
                          Cube(x: 1, y: 1, z: 0), Cube(x: 1, y: 1, z: 1)]
        let correcte = projection(empilement, vue: .dessus)
        return Question(empilement: empilement, vue: .dessus,
                        propositions: [correcte, muter(correcte),
                                       muter(muter(correcte)), [[true]]],
                        indexCorrect: 0)
    }
}

// MARK: - Rendu

/// Une silhouette : cases pleines et cases vides.
struct SilhouetteView: View {
    let grille: [[Bool]]
    var cote: CGFloat = 20

    var body: some View {
        VStack(spacing: 2) {
            ForEach(grille.indices, id: \.self) { ligne in
                HStack(spacing: 2) {
                    ForEach(grille[ligne].indices, id: \.self) { colonne in
                        Rectangle()
                            .fill(grille[ligne][colonne]
                                  ? Color(red: 0.36, green: 0.49, blue: 0.68)
                                  : Color(.systemGray5))
                            .frame(width: cote, height: cote)
                    }
                }
            }
        }
        .padding(4)
    }
}

// MARK: - ViewModel

@MainActor
@Observable
final class Objets3DViewModel {
    var question: Objets3DGenerator.Question?
    var currentQuestion: Int = 0
    var totalQuestions: Int = 15
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var timeRemaining: Int = 20
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var selectedIndex: Int?
    var showFeedback: Bool = false

    private var timerTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    var accuracy: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalQuestions) * 100
    }

    func startGame() {
        currentQuestion = 0
        correctAnswers = 0
        wrongAnswers = 0
        isGameActive = true
        isGameOver = false
        loadQuestion()
    }

    private func loadQuestion() {
        selectedIndex = nil
        showFeedback = false
        let cubes = currentQuestion < 8 ? 5 : 7
        question = Objets3DGenerator.generate(nombreDeCubes: cubes)
        timeRemaining = 20
        startTimer()
    }

    private func startTimer() {
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: 20) { [self] restant in
            timeRemaining = Int(restant.rounded(.up))
        } onFinish: { [self] in
            repondre(nil)
        }
    }

    func repondre(_ index: Int?) {
        guard !showFeedback else { return }
        timerTask?.cancel()
        selectedIndex = index
        showFeedback = true

        if let index, index == question?.indexCorrect {
            correctAnswers += 1
            HapticManager.success()
        } else {
            wrongAnswers += 1
            HapticManager.error()
        }

        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(1500))
            if Task.isCancelled { return }
            currentQuestion += 1
            if currentQuestion >= totalQuestions {
                endGame()
            } else {
                loadQuestion()
            }
        }
    }

    private func endGame() {
        timerTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = true
    }

    func makeResult() -> GameResult? {
        guard isGameOver else { return nil }
        return GameResult(gameType: .objets3D, score: Double(correctAnswers),
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

// MARK: - Vue

struct Objets3DView: View {
    @State private var viewModel = Objets3DViewModel()

    var body: some View {
        VStack(spacing: 16) {
            if viewModel.isGameActive {
                gameView
            } else if viewModel.isGameOver {
                gameOverView
            } else {
                startView
            }
        }
        .padding()
        .recordSession(when: viewModel.isGameOver) { viewModel.makeResult() }
        .navigationTitle("Objets 3D")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    GameStatsView(type: .objets3D)
                } label: {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Objets 3D",
                    rules: [
                        RuleItem(icon: "cube", text: "Un assemblage de cubes est présenté"),
                        RuleItem(icon: "eye", text: "On te demande une vue précise"),
                        RuleItem(icon: "square.grid.2x2", text: "Choisis la silhouette correspondante"),
                        RuleItem(icon: "arrow.down.to.line", text: "Les cubes alignés se confondent en une seule case"),
                        RuleItem(icon: "timer", text: "20 secondes par question")
                    ],
                    accentColor: .green,
                    isGameActive: viewModel.isGameActive
                )
            }
        }
        .onDisappear { viewModel.stopGame() }
    }

    private var startView: some View {
        VStack(spacing: 28) {
            Spacer()
            Image(systemName: "view.3d")
                .font(.system(size: 76))
                .foregroundStyle(.green)
            Text("Objets 3D").font(.largeTitle.weight(.bold))

            VStack(alignment: .leading, spacing: 8) {
                Label("Un assemblage de cubes est présenté", systemImage: "cube")
                Label("On te demande une vue précise", systemImage: "eye")
                Label("Choisis la silhouette correspondante", systemImage: "square.grid.2x2")
                Label("Les cubes alignés se confondent", systemImage: "arrow.down.to.line")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("15 questions, 20s chacune")
                .font(.callout)
                .foregroundStyle(.secondary)

            Button {
                viewModel.startGame()
            } label: {
                Text("Commencer")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }

    @ViewBuilder
    private var gameView: some View {
        if let question = viewModel.question {
            VStack(spacing: 14) {
                HStack {
                    Text("Question \(viewModel.currentQuestion + 1)/\(viewModel.totalQuestions)")
                        .font(.headline)
                    Spacer()
                    TimerView(timeRemaining: viewModel.timeRemaining, totalTime: 20)
                }

                EmpilementView(cubes: question.empilement)
                    .frame(height: 130)

                Text("Quelle est la vue \(question.vue.rawValue) ?")
                    .font(.subheadline.weight(.medium))

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                    ForEach(question.propositions.indices, id: \.self) { index in
                        Button {
                            viewModel.repondre(index)
                        } label: {
                            SilhouetteView(grille: question.propositions[index])
                                .frame(maxWidth: .infinity)
                                .padding(6)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(fond(index, question: question))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(bordure(index, question: question), lineWidth: 2)
                                )
                        }
                        .buttonStyle(.plain)
                        .disabled(viewModel.showFeedback)
                    }
                }

                Spacer()
            }
        }
    }

    private func fond(_ index: Int, question: Objets3DGenerator.Question) -> Color {
        guard viewModel.showFeedback else { return Color(.systemBackground) }
        if index == question.indexCorrect { return .green.opacity(0.2) }
        if index == viewModel.selectedIndex { return .red.opacity(0.2) }
        return Color(.systemBackground)
    }

    private func bordure(_ index: Int, question: Objets3DGenerator.Question) -> Color {
        guard viewModel.showFeedback else { return Color(.systemGray4) }
        if index == question.indexCorrect { return .green }
        if index == viewModel.selectedIndex { return .red }
        return Color(.systemGray4)
    }

    private var gameOverView: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: viewModel.accuracy >= 70 ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(viewModel.accuracy >= 70 ? .green : .red)
            Text("Terminé !").font(.largeTitle.weight(.bold))

            VStack(spacing: 12) {
                ResultRow(label: "Bonnes réponses", value: "\(viewModel.correctAnswers)/\(viewModel.totalQuestions)")
                ResultRow(label: "Précision", value: String(format: "%.0f%%", viewModel.accuracy))
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Button {
                viewModel.startGame()
            } label: {
                Text("Rejouer")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        Objets3DView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
