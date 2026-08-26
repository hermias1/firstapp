import SwiftUI

// MARK: - Modèle

/// Un puzzle de billes : passer de `depart` à `cible` en un minimum de coups.
///
/// Un coup consiste à prendre la bille du dessus d'un tube et à la poser sur un
/// autre tube non plein. `solution` est le nombre minimal de coups, calculé par
/// parcours en largeur à la génération : contrairement à un puzzle écrit à la
/// main, il est donc impossible de proposer une énigme sans solution.
struct BillesPuzzle {
    let depart: [[Int]]
    let cible: [[Int]]
    let solution: Int
    let options: [Int]
    let capacite: Int
}

enum BillesGenerator {
    static let capacite = 4
    static let nombreTubes = 3

    /// Tous les états atteignables en un coup.
    static func coupsPossibles(_ etat: [[Int]]) -> [[[Int]]] {
        var resultat: [[[Int]]] = []
        for source in etat.indices where !etat[source].isEmpty {
            for cible in etat.indices where cible != source && etat[cible].count < capacite {
                var suivant = etat
                suivant[cible].append(suivant[source].removeLast())
                resultat.append(suivant)
            }
        }
        return resultat
    }

    /// Nombre minimal de coups pour aller de `depart` à `cible`, ou nil au-delà
    /// de `maximum` coups.
    static func distanceMinimale(de depart: [[Int]], a cible: [[Int]],
                                 maximum: Int = 10) -> Int? {
        if depart == cible { return 0 }
        var vus: Set<[[Int]]> = [depart]
        var frontiere = [depart]
        var distance = 0

        while !frontiere.isEmpty && distance < maximum {
            distance += 1
            var suivante: [[[Int]]] = []
            for etat in frontiere {
                for coup in coupsPossibles(etat) {
                    if coup == cible { return distance }
                    if vus.insert(coup).inserted { suivante.append(coup) }
                }
            }
            frontiere = suivante
        }
        return nil
    }

    static func generate() -> BillesPuzzle {
        // Le tirage est rejeté tant que le puzzle n'est pas dans la fourchette
        // de difficulté visée ; quelques essais suffisent en pratique.
        for _ in 0..<200 {
            var depart: [[Int]] = Array(repeating: [], count: nombreTubes)
            // 6 billes : deux de chacune des trois couleurs
            for bille in [0, 0, 1, 1, 2, 2].shuffled() {
                let libres = depart.indices.filter { depart[$0].count < capacite }
                guard let tube = libres.randomElement() else { break }
                depart[tube].append(bille)
            }

            // La cible est obtenue en jouant des coups au hasard : elle est
            // donc toujours atteignable.
            var cible = depart
            for _ in 0..<Int.random(in: 3...9) {
                guard let suivant = coupsPossibles(cible).randomElement() else { break }
                cible = suivant
            }

            guard let solution = distanceMinimale(de: depart, a: cible),
                  (2...8).contains(solution) else { continue }

            return BillesPuzzle(depart: depart, cible: cible, solution: solution,
                                options: options(pour: solution), capacite: capacite)
        }

        // Repli déterministe, jamais atteint en pratique
        let depart = [[0, 1], [2], []]
        let cible = [[0], [2], [1]]
        return BillesPuzzle(depart: depart, cible: cible, solution: 1,
                            options: [1, 2, 3, 4], capacite: capacite)
    }

    static func options(pour solution: Int) -> [Int] {
        PropositionsQCM.autour(de: solution, minimum: 1)
    }
}

// MARK: - ViewModel

@MainActor
@Observable
final class BillesViewModel {
    var puzzle: BillesPuzzle?
    var currentQuestion: Int = 0
    var totalQuestions: Int = 10
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var timeRemaining: Int = 45
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var selectedAnswer: Int?
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
        loadPuzzle()
    }

    private func loadPuzzle() {
        selectedAnswer = nil
        showFeedback = false
        puzzle = BillesGenerator.generate()
        timeRemaining = 45
        startTimer()
    }

    private func startTimer() {
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: 45) { [self] restant in
            timeRemaining = Int(restant.rounded(.up))
        } onFinish: { [self] in
            handleTimeout()
        }
    }

    private func handleTimeout() {
        guard !showFeedback else { return }
        showFeedback = true
        wrongAnswers += 1
        moveToNext()
    }

    func selectAnswer(_ valeur: Int) {
        guard !showFeedback else { return }
        timerTask?.cancel()
        selectedAnswer = valeur
        showFeedback = true

        if valeur == puzzle?.solution {
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
            try? await Task.sleep(for: .seconds(2))
            if Task.isCancelled { return }
            currentQuestion += 1
            if currentQuestion >= totalQuestions {
                endGame()
            } else {
                loadPuzzle()
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
        return GameResult(gameType: .billes, score: Double(correctAnswers),
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

// MARK: - Tubes

private let couleursBilles: [Color] = [.red, .blue, .green, .orange]

struct TubeView: View {
    let billes: [Int]
    let capacite: Int

    var body: some View {
        VStack(spacing: 4) {
            Spacer(minLength: 0)
            ForEach(Array(billes.enumerated().reversed()), id: \.offset) { _, bille in
                Circle()
                    .fill(couleursBilles[bille % couleursBilles.count])
                    .frame(width: 26, height: 26)
            }
        }
        .padding(6)
        .frame(width: 44, height: CGFloat(capacite) * 30 + 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray5))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray3), lineWidth: 2)
        )
    }
}

private struct EtatView: View {
    let titre: String
    let tubes: [[Int]]
    let capacite: Int

    var body: some View {
        VStack(spacing: 8) {
            Text(titre)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            HStack(spacing: 10) {
                ForEach(tubes.indices, id: \.self) { index in
                    TubeView(billes: tubes[index], capacite: capacite)
                }
            }
        }
    }
}

// MARK: - Vue

struct BillesView: View {
    @State private var viewModel = BillesViewModel()

    var body: some View {
        VStack(spacing: 20) {
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
        .navigationTitle("Billes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    GameStatsView(type: .billes)
                } label: {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Billes",
                    rules: [
                        RuleItem(icon: "arrow.left.arrow.right", text: "Un coup = déplacer la bille du dessus"),
                        RuleItem(icon: "tray.full", text: "Un tube contient 4 billes au maximum"),
                        RuleItem(icon: "target", text: "Atteindre la position cible"),
                        RuleItem(icon: "number", text: "Donne le nombre MINIMAL de coups"),
                        RuleItem(icon: "timer", text: "45 secondes par puzzle")
                    ],
                    accentColor: .teal,
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
            Image(systemName: "circle.grid.2x1.fill")
                .font(.system(size: 80))
                .foregroundStyle(.teal)
            Text("Billes")
                .font(.largeTitle.weight(.bold))

            VStack(alignment: .leading, spacing: 8) {
                Label("Un coup = déplacer la bille du dessus", systemImage: "arrow.left.arrow.right")
                Label("Un tube contient 4 billes au maximum", systemImage: "tray.full")
                Label("Atteindre la position cible", systemImage: "target")
                Label("Donne le nombre MINIMAL de coups", systemImage: "number")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("10 puzzles, 45s chacun")
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
                    .background(Color.teal)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }

    @ViewBuilder
    private var gameView: some View {
        if let puzzle = viewModel.puzzle {
            VStack(spacing: 16) {
                HStack {
                    Text("Puzzle \(viewModel.currentQuestion + 1)/\(viewModel.totalQuestions)")
                        .font(.headline)
                    Spacer()
                    TimerView(timeRemaining: viewModel.timeRemaining, totalTime: 45)
                }

                HStack(spacing: 24) {
                    EtatView(titre: "Départ", tubes: puzzle.depart, capacite: puzzle.capacite)
                    Image(systemName: "arrow.right")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    EtatView(titre: "Cible", tubes: puzzle.cible, capacite: puzzle.capacite)
                }
                .frame(maxWidth: .infinity)

                Text("Combien de coups au minimum ?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(puzzle.options, id: \.self) { option in
                        Button {
                            viewModel.selectAnswer(option)
                        } label: {
                            Text("\(option)")
                                .font(.title3.weight(.semibold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(couleurBouton(option, puzzle: puzzle))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .disabled(viewModel.showFeedback)
                    }
                }

                if viewModel.showFeedback {
                    Text(viewModel.selectedAnswer == puzzle.solution
                         ? "Correct !"
                         : "La réponse était \(puzzle.solution)")
                        .font(.headline)
                        .foregroundStyle(viewModel.selectedAnswer == puzzle.solution ? .green : .red)
                }

                Spacer()
            }
        }
    }

    private func couleurBouton(_ option: Int, puzzle: BillesPuzzle) -> Color {
        guard viewModel.showFeedback else { return .teal }
        if option == puzzle.solution { return .green }
        if option == viewModel.selectedAnswer { return .red }
        return .gray
    }

    private var gameOverView: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: viewModel.accuracy >= 70 ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(viewModel.accuracy >= 70 ? .green : .red)
            Text("Terminé !")
                .font(.largeTitle.weight(.bold))

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
                    .background(Color.teal)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        BillesView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
