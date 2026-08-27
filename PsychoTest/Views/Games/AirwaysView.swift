import SwiftUI

// MARK: - Modèle

struct Avion: Identifiable, Equatable {
    let id: Int
    let indicatif: String
    /// Minutes avant le passage à la balise, avant toute manœuvre.
    let arrivee: Int
    /// Cap d'arrivée, en degrés, pour le dessin du radar.
    let cap: Int
}

/// Un exercice de séquencement : espacer les arrivées au-dessus d'une balise.
struct AirwaysPuzzle {
    let avions: [Avion]
    let espacement: Int
    let solution: Int
    let options: [Int]
}

enum AirwaysGenerator {
    /// Nombre minimal de minutes d'attente à répartir pour que deux avions
    /// consécutifs soient séparés d'au moins `espacement`.
    ///
    /// Une manœuvre ne peut que retarder un avion, jamais l'avancer : l'ordre
    /// d'arrivée est donc figé, et retarder au plus juste chaque avion en
    /// conflit donne l'optimum.
    static func manoeuvresMinimales(arrivees: [Int], espacement: Int) -> Int {
        let triees = arrivees.sorted()
        var total = 0
        var precedent = Int.min

        for arrivee in triees {
            let cible = precedent == Int.min ? arrivee : max(arrivee, precedent + espacement)
            total += cible - arrivee
            precedent = cible
        }
        return total
    }

    static let indicatifs = ["AF447", "AF010", "AF66", "AF275", "AF1180",
                             "AF356", "AF702", "AF890"]

    static func generate(nombreAvions: Int = 5) -> AirwaysPuzzle {
        for _ in 0..<200 {
            let espacement = Int.random(in: 2...3)
            // Des arrivées resserrées pour qu'il y ait forcément des conflits
            let arrivees = (0..<nombreAvions).map { _ in Int.random(in: 4...16) }
            let solution = manoeuvresMinimales(arrivees: arrivees, espacement: espacement)

            // Ni trivial, ni décourageant
            guard (2...14).contains(solution) else { continue }

            let avions = zip(arrivees.indices, arrivees).map { index, arrivee in
                Avion(id: index,
                      indicatif: indicatifs[index % indicatifs.count],
                      arrivee: arrivee,
                      cap: Int.random(in: 0..<12) * 30)
            }
            return AirwaysPuzzle(avions: avions, espacement: espacement,
                                 solution: solution, options: options(pour: solution))
        }

        let avions = [Avion(id: 0, indicatif: "AF447", arrivee: 5, cap: 0),
                      Avion(id: 1, indicatif: "AF010", arrivee: 5, cap: 90),
                      Avion(id: 2, indicatif: "AF66", arrivee: 6, cap: 180)]
        let solution = manoeuvresMinimales(arrivees: [5, 5, 6], espacement: 2)
        return AirwaysPuzzle(avions: avions, espacement: 2, solution: solution,
                             options: options(pour: solution))
    }

    static func options(pour solution: Int) -> [Int] {
        PropositionsQCM.autour(de: solution, minimum: 0)
    }
}

// MARK: - Radar

struct RadarView: View {
    let avions: [Avion]

    var body: some View {
        GeometryReader { geo in
            let centre = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            let rayon = min(geo.size.width, geo.size.height) / 2 - 18

            ZStack {
                ForEach([0.4, 0.7, 1.0], id: \.self) { facteur in
                    Circle()
                        .stroke(Color(.systemGray4), lineWidth: 1)
                        .frame(width: rayon * 2 * facteur, height: rayon * 2 * facteur)
                }
                Image(systemName: "triangle.fill")
                    .font(.caption)
                    .foregroundStyle(Theme.ambre)

                ForEach(avions) { avion in
                    let angle = Double(avion.cap) * .pi / 180
                    // Plus l'arrivée est lointaine, plus l'avion est éloigné
                    let distance = rayon * min(1, Double(avion.arrivee) / 18.0)
                    let position = CGPoint(x: centre.x + CGFloat(cos(angle)) * distance,
                                           y: centre.y + CGFloat(sin(angle)) * distance)
                    VStack(spacing: 1) {
                        Image(systemName: "airplane")
                            .font(.caption2)
                            .rotationEffect(.degrees(Double(avion.cap) + 180))
                        Text("\(avion.arrivee)′")
                            .font(.system(size: 9).weight(.medium))
                    }
                    .foregroundStyle(.blue)
                    .position(position)
                }
            }
        }
    }
}

// MARK: - ViewModel

@MainActor
@Observable
final class AirwaysViewModel {
    var puzzle: AirwaysPuzzle?
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
        let avions = currentQuestion < 5 ? 4 : 6
        puzzle = AirwaysGenerator.generate(nombreAvions: avions)
        timeRemaining = 45
        startTimer()
    }

    private func startTimer() {
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: 45) { [self] restant in
            timeRemaining = Int(restant.rounded(.up))
        } onFinish: { [self] in
            repondre(nil)
        }
    }

    func repondre(_ valeur: Int?) {
        guard !showFeedback else { return }
        timerTask?.cancel()
        selectedAnswer = valeur
        showFeedback = true

        if let valeur, valeur == puzzle?.solution {
            correctAnswers += 1
            HapticManager.success()
        } else {
            wrongAnswers += 1
            HapticManager.error()
        }

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
        return GameResult(gameType: .airways, score: Double(correctAnswers),
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

struct AirwaysView: View {
    @State private var viewModel = AirwaysViewModel()

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
        .navigationTitle("Airways")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Masqué pendant la partie : empiler cette destination
                // déclenche le onDisappear de la vue, donc stopGame(),
                // ce qui effacerait la partie en cours sans prévenir.
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .airways)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Airways",
                    rules: [
                        RuleItem(icon: "airplane", text: "Des avions convergent vers une balise"),
                        RuleItem(icon: "clock", text: "Chacun affiche son temps d'arrivée"),
                        RuleItem(icon: "arrow.left.and.right", text: "Ils doivent être espacés du délai indiqué"),
                        RuleItem(icon: "arrow.triangle.turn.up.right.diamond", text: "Une manœuvre retarde un avion d'une minute"),
                        RuleItem(icon: "number", text: "Donne le total MINIMAL de minutes d'attente"),
                        RuleItem(icon: "timer", text: "45 secondes par situation")
                    ],
                    accentColor: Theme.accent,
                    isGameActive: viewModel.isGameActive
                )
            }
        }
        .onDisappear { viewModel.stopGame() }
    }

    private var startView: some View {
        VStack(spacing: 26) {
            Spacer()
            Image(systemName: "airplane.circle.fill")
                .font(.system(size: 76))
                .foregroundStyle(Theme.accent)
            Text("Airways").font(.largeTitle.weight(.bold))

            VStack(alignment: .leading, spacing: 8) {
                Label("Des avions convergent vers une balise", systemImage: "airplane")
                Label("Chacun affiche son temps d'arrivée", systemImage: "clock")
                Label("Ils doivent être espacés du délai indiqué", systemImage: "arrow.left.and.right")
                Label("Une manœuvre retarde un avion d'une minute", systemImage: "arrow.triangle.turn.up.right.diamond")
                Label("Donne le total MINIMAL d'attente", systemImage: "number")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding()
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("10 situations, 45s chacune")
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
                    .background(Theme.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }

    @ViewBuilder
    private var gameView: some View {
        if let puzzle = viewModel.puzzle {
            VStack(spacing: 12) {
                HStack {
                    Text("Situation \(viewModel.currentQuestion + 1)/\(viewModel.totalQuestions)")
                        .font(.headline)
                    Spacer()
                    TimerView(timeRemaining: viewModel.timeRemaining, totalTime: 45)
                }

                RadarView(avions: puzzle.avions)
                    .frame(height: 180)

                VStack(spacing: 4) {
                    ForEach(puzzle.avions) { avion in
                        HStack {
                            Image(systemName: "airplane")
                                .font(.caption2)
                                .foregroundStyle(.blue)
                            Text(avion.indicatif)
                                .font(.caption.monospaced())
                            Spacer()
                            Text("\(avion.arrivee) min")
                                .font(.caption.monospacedDigit())
                        }
                    }
                }
                .padding(8)
                .background(Theme.surface)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                Text("Espacement exigé : \(puzzle.espacement) min")
                    .font(.subheadline.weight(.medium))
                Text("Combien de minutes d'attente au minimum ?")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(puzzle.options, id: \.self) { option in
                        Button {
                            viewModel.repondre(option)
                        } label: {
                            Text("\(option)")
                                .font(.title3.weight(.semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(couleur(option, puzzle: puzzle))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .disabled(viewModel.showFeedback)
                    }
                }

                if viewModel.showFeedback {
                    Text(viewModel.selectedAnswer == puzzle.solution
                         ? "Correct !"
                         : "La réponse était \(puzzle.solution)")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(viewModel.selectedAnswer == puzzle.solution ? Theme.vert : Theme.rouge)
                }

                Spacer(minLength: 0)
            }
        }
    }

    private func couleur(_ option: Int, puzzle: AirwaysPuzzle) -> Color {
        guard viewModel.showFeedback else { return .blue }
        if option == puzzle.solution { return Theme.vert }
        if option == viewModel.selectedAnswer { return Theme.rouge }
        return .gray
    }

    private var gameOverView: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: viewModel.accuracy >= 70 ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(viewModel.accuracy >= 70 ? Theme.vert : Theme.rouge)
            Text("Terminé !").font(.largeTitle.weight(.bold))

            VStack(spacing: 12) {
                ResultRow(label: "Bonnes réponses", value: "\(viewModel.correctAnswers)/\(viewModel.totalQuestions)")
                ResultRow(label: "Précision", value: String(format: "%.0f%%", viewModel.accuracy))
            }
            .padding()
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Button {
                viewModel.startGame()
            } label: {
                Text("Rejouer")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Theme.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        AirwaysView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
