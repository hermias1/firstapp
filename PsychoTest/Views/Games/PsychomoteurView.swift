import SwiftUI

// MARK: - ViewModel

/// Test de double tâche : maintenir un curseur sur une cible mobile tout en
/// répondant à des stimuli.
///
/// L'épreuve officielle se joue à deux joysticks ; la poursuite est ici confiée
/// au doigt et la tâche secondaire à un bouton, mais la contrainte reste la
/// même : tenir deux choses à la fois.
@MainActor
@Observable
final class PsychomoteurViewModel {
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var timeRemaining: Int = 60

    /// Position du doigt, en coordonnées normalisées (0 à 1).
    var positionDoigt: CGPoint?

    /// Stimulus courant de la tâche secondaire, s'il y en a un.
    var chiffre: Int?
    var feedbackSecondaire: String?

    private(set) var echantillons: Int = 0
    private(set) var echantillonsSurCible: Int = 0
    private(set) var bonnesReponses: Int = 0
    private(set) var erreursSecondaires: Int = 0

    private var debut: Date?
    private var suiviTask: Task<Void, Never>?
    private var stimulusTask: Task<Void, Never>?
    private var timerTask: Task<Void, Never>?
    private var chiffreRepondu = false

    static let duree: TimeInterval = 60
    static let tolerance: CGFloat = 0.07

    /// Précision de poursuite, en pourcentage du temps passé sur la cible.
    var precisionPoursuite: Double {
        guard echantillons > 0 else { return 0 }
        return Double(echantillonsSurCible) / Double(echantillons) * 100
    }

    /// Score global : la poursuite, pénalisée par les ratés de la tâche
    /// secondaire. Tenir le curseur en ignorant les stimuli ne suffit pas.
    var scoreGlobal: Double {
        max(0, precisionPoursuite - Double(erreursSecondaires) * 3)
    }

    /// Position de la cible à l'instant `t`, en coordonnées normalisées.
    ///
    /// Deux sinusoïdes de périodes incommensurables : la trajectoire ne se
    /// répète pas, on ne peut donc pas l'anticiper par mémorisation.
    nonisolated static func positionCible(_ t: TimeInterval) -> CGPoint {
        CGPoint(x: 0.5 + 0.34 * sin(t * 0.63),
                y: 0.5 + 0.30 * sin(t * 0.98 + 1.2))
    }

    func startGame() {
        echantillons = 0
        echantillonsSurCible = 0
        bonnesReponses = 0
        erreursSecondaires = 0
        positionDoigt = nil
        chiffre = nil
        feedbackSecondaire = nil
        timeRemaining = Int(Self.duree)
        // Sans cette remise à zéro, un drapeau resté armé à la fin d'une partie
        // rendait le bouton PAIR inerte au début de la suivante.
        chiffreRepondu = false
        isGameActive = true
        isGameOver = false
        debut = Date()

        demarrerSuivi()
        demarrerStimuli()
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: Self.duree) { [self] restant in
            timeRemaining = Int(restant.rounded(.up))
        } onFinish: { [self] in
            endGame()
        }
    }

    /// Échantillonne la distance entre le doigt et la cible, 20 fois par seconde.
    private func demarrerSuivi() {
        suiviTask?.cancel()
        suiviTask = Task { @MainActor in
            while !Task.isCancelled {
                if let debut, Date().timeIntervalSince(debut) > 2 {
                    // Les deux premières secondes servent à poser le doigt :
                    // les compter comme du hors-cible pénalisait le démarrage.
                    let cible = Self.positionCible(Date().timeIntervalSince(debut))
                    echantillons += 1
                    if let doigt = positionDoigt {
                        let dx = doigt.x - cible.x
                        let dy = doigt.y - cible.y
                        if sqrt(dx * dx + dy * dy) <= Self.tolerance {
                            echantillonsSurCible += 1
                        }
                    }
                }
                try? await Task.sleep(for: .milliseconds(50))
            }
        }
    }

    /// Fait apparaître un chiffre toutes les 3 à 5 secondes.
    private func demarrerStimuli() {
        stimulusTask?.cancel()
        stimulusTask = Task { @MainActor in
            while !Task.isCancelled {
                // Intervalle fixe : un tirage aléatoire faisait varier le
                // nombre de stimuli d'une partie à l'autre, donc la charge,
                // et rendait deux scores incomparables.
                try? await Task.sleep(for: .milliseconds(4000))
                if Task.isCancelled { return }

                chiffre = Int.random(in: 1...9)
                chiffreRepondu = false
                feedbackSecondaire = nil

                try? await Task.sleep(for: .milliseconds(1800))
                if Task.isCancelled { return }

                // Un chiffre pair non signalé est un oubli
                if let valeur = chiffre, valeur % 2 == 0, !chiffreRepondu {
                    erreursSecondaires += 1
                    feedbackSecondaire = "Pair manqué"
                    HapticManager.error()
                }
                chiffre = nil
            }
        }
    }

    /// Le joueur signale un chiffre pair.
    func signalerPair() {
        guard isGameActive, !chiffreRepondu else { return }
        chiffreRepondu = true

        if let valeur = chiffre, valeur % 2 == 0 {
            bonnesReponses += 1
            feedbackSecondaire = "Correct"
            HapticManager.success()
        } else {
            // Signaler un chiffre impair, ou signaler alors qu'il n'y a rien
            erreursSecondaires += 1
            feedbackSecondaire = "Faux signalement"
            HapticManager.error()
        }
    }

    private func endGame() {
        suiviTask?.cancel()
        stimulusTask?.cancel()
        timerTask?.cancel()
        chiffre = nil
        isGameActive = false
        isGameOver = true
    }

    func makeResult() -> GameResult? {
        guard isGameOver else { return nil }
        return GameResult(gameType: .psychomoteur, score: scoreGlobal,
                          correctAnswers: echantillonsSurCible,
                          totalItems: max(1, echantillons),
                          duration: Self.duree)
    }

    func stopGame() {
        suiviTask?.cancel()
        stimulusTask?.cancel()
        timerTask?.cancel()
        isGameActive = false
        isGameOver = false
    }

    var tempsEcoule: TimeInterval {
        guard let debut else { return 0 }
        return Date().timeIntervalSince(debut)
    }
}

// MARK: - Vue

struct PsychomoteurView: View {
    @State private var viewModel = PsychomoteurViewModel()

    var body: some View {
        VStack(spacing: 14) {
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
        .sortieProtegee(enPartie: viewModel.isGameActive) { viewModel.stopGame() }
        .navigationTitle("Psychomoteur")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Masqué pendant la partie : empiler cette destination
                // déclenche le onDisappear de la vue, donc stopGame(),
                // ce qui effacerait la partie en cours sans prévenir.
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .psychomoteur)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Psychomoteur",
                    rules: [
                        RuleItem(icon: "hands.sparkles", text: "Tiens le téléphone à deux mains"),
                        RuleItem(icon: "hand.draw", text: "Un pouce suit la cible, l'autre répond"),
                        RuleItem(icon: "number", text: "Un chiffre apparaît régulièrement"),
                        RuleItem(icon: "2.circle", text: "Touche PAIR uniquement si le chiffre est pair"),
                        RuleItem(icon: "exclamationmark.triangle", text: "Oubli ou faux signalement : -3 points"),
                        RuleItem(icon: "timer", text: "60 secondes")
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
            Image(systemName: "hand.tap.fill")
                .font(.system(size: 76))
                .foregroundStyle(Theme.accent)
            Text("Psychomoteur").font(.largeTitle.weight(.bold))

            VStack(alignment: .leading, spacing: 8) {
                Label("Tiens le téléphone à deux mains", systemImage: "hands.sparkles")
                Label("Un pouce suit la cible, l'autre appuie sur PAIR", systemImage: "hand.draw")
                Label("Un chiffre apparaît régulièrement", systemImage: "number")
                Label("Touche PAIR si le chiffre est pair", systemImage: "2.circle")
                Label("Les deux tâches comptent en même temps", systemImage: "arrow.triangle.branch")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding()
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("60 secondes de double tâche")
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

    private var gameView: some View {
        VStack(spacing: 12) {
            HStack {
                // Repère d'état placé hors de la zone de poursuite : sous le
                // doigt, le joueur ne voyait pas le cercle qu'il recouvre.
                Circle()
                    .fill(estSurCibleMaintenant ? Theme.vert : Theme.rouge)
                    .frame(width: 12, height: 12)
                Text(String(format: "Précision %.0f%%", viewModel.precisionPoursuite))
                    .font(.headline.monospacedDigit())
                Spacer()
                Text("\(viewModel.timeRemaining)s")
                    .font(.headline.monospacedDigit())
                    .foregroundStyle(viewModel.timeRemaining < 10 ? .red : .primary)
            }

            // Zone de poursuite
            TimelineView(.animation) { timeline in
                GeometryReader { geo in
                    let t = timeline.date.timeIntervalSince1970
                    let cible = PsychomoteurViewModel.positionCible(viewModel.tempsEcoule)
                    let centre = CGPoint(x: cible.x * geo.size.width,
                                         y: cible.y * geo.size.height)
                    let rayon = PsychomoteurViewModel.tolerance * min(geo.size.width, geo.size.height)
                    let surCible = estSurCible(geo: geo.size, cible: cible)

                    ZStack {
                        Circle()
                            .strokeBorder(surCible ? Theme.vert : Theme.rouge, lineWidth: 3)
                            .background(Circle().fill((surCible ? Theme.vert : Theme.rouge).opacity(0.15)))
                            .frame(width: rayon * 2, height: rayon * 2)
                            .position(centre)

                        if let doigt = viewModel.positionDoigt {
                            Circle()
                                .fill(Color.primary)
                                .frame(width: 14, height: 14)
                                .position(x: doigt.x * geo.size.width, y: doigt.y * geo.size.height)
                        }
                        // Rend la zone tactile sur toute sa surface
                        Color.clear.contentShape(Rectangle())
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { valeur in
                                viewModel.positionDoigt = CGPoint(
                                    x: valeur.location.x / geo.size.width,
                                    y: valeur.location.y / geo.size.height)
                            }
                            .onEnded { _ in viewModel.positionDoigt = nil }
                    )
                    .opacity(t > 0 ? 1 : 1)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 340)
            .background(Theme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            // Tâche secondaire
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray5))
                    if let chiffre = viewModel.chiffre {
                        Text("\(chiffre)")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                    }
                }
                .frame(width: 84, height: 68)

                Button {
                    viewModel.signalerPair()
                } label: {
                    Text("PAIR")
                        .font(.title3.weight(.bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 68)
                        .background(Theme.accent)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }

            Text(viewModel.feedbackSecondaire ?? " ")
                .font(.caption)
                .foregroundStyle(viewModel.feedbackSecondaire == "Correct" ? Theme.vert : Theme.rouge)
        }
    }

    /// Le joueur est-il sur la cible à cet instant.
    private var estSurCibleMaintenant: Bool {
        guard let doigt = viewModel.positionDoigt else { return false }
        let cible = PsychomoteurViewModel.positionCible(viewModel.tempsEcoule)
        let dx = doigt.x - cible.x
        let dy = doigt.y - cible.y
        return sqrt(dx * dx + dy * dy) <= PsychomoteurViewModel.tolerance
    }

    private func estSurCible(geo: CGSize, cible: CGPoint) -> Bool {
        guard let doigt = viewModel.positionDoigt else { return false }
        let dx = doigt.x - cible.x
        let dy = doigt.y - cible.y
        return sqrt(dx * dx + dy * dy) <= PsychomoteurViewModel.tolerance
    }

    private var gameOverView: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: viewModel.scoreGlobal >= 60 ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(viewModel.scoreGlobal >= 60 ? Theme.vert : Theme.rouge)
            Text("Terminé !").font(.largeTitle.weight(.bold))

            VStack(spacing: 12) {
                ResultRow(label: "Score global", value: String(format: "%.0f", viewModel.scoreGlobal))
                ResultRow(label: "Temps sur la cible", value: String(format: "%.0f%%", viewModel.precisionPoursuite))
                ResultRow(label: "Chiffres pairs signalés", value: "\(viewModel.bonnesReponses)")
                ResultRow(label: "Erreurs secondaires", value: "\(viewModel.erreursSecondaires)")
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
        PsychomoteurView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
