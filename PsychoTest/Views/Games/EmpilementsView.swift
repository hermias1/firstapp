import SwiftUI

// MARK: - Modèle

/// Un cube dans une grille entière.
struct Cube: Hashable, Comparable {
    let x: Int
    let y: Int
    let z: Int

    static func < (a: Cube, b: Cube) -> Bool {
        (a.x, a.y, a.z) < (b.x, b.y, b.z)
    }
}

/// Un empilement, c'est-à-dire un ensemble de cubes collés.
typealias Empilement = [Cube]

enum EmpilementsGenerator {
    // MARK: Rotations

    private static func rotX(_ c: Cube) -> Cube { Cube(x: c.x, y: -c.z, z: c.y) }
    private static func rotY(_ c: Cube) -> Cube { Cube(x: c.z, y: c.y, z: -c.x) }
    private static func rotZ(_ c: Cube) -> Cube { Cube(x: -c.y, y: c.x, z: c.z) }

    /// Ramène un empilement à une forme comparable : collé à l'origine et trié.
    /// Deux empilements identiques à une translation près ont la même forme.
    static func normaliser(_ e: Empilement) -> Empilement {
        guard let minX = e.map(\.x).min(),
              let minY = e.map(\.y).min(),
              let minZ = e.map(\.z).min() else { return e }
        return e.map { Cube(x: $0.x - minX, y: $0.y - minY, z: $0.z - minZ) }.sorted()
    }

    /// Les 24 orientations d'un solide, obtenues en composant les rotations
    /// d'un quart de tour autour des trois axes.
    static func toutesLesRotations(_ e: Empilement) -> [Empilement] {
        var vues = Set<Empilement>()
        var resultat: [Empilement] = []
        var frontiere = [normaliser(e)]
        vues.insert(frontiere[0])

        while let courant = frontiere.popLast() {
            resultat.append(courant)
            for rotation in [rotX, rotY, rotZ] {
                let suivant = normaliser(courant.map(rotation))
                if vues.insert(suivant).inserted {
                    frontiere.append(suivant)
                }
            }
        }
        return resultat
    }

    /// Image miroir : on inverse un seul axe.
    static func miroir(_ e: Empilement) -> Empilement {
        normaliser(e.map { Cube(x: -$0.x, y: $0.y, z: $0.z) })
    }

    /// Ce que la projection isométrique laisse réellement voir : les couples
    /// (x - y, x + y - 2z), recentrés pour être comparables d'une figure à
    /// l'autre.
    ///
    /// Deux cubes distants de (1, 1, 1) tombent exactement au même point à
    /// l'écran : le plus proche masque totalement l'autre. Une figure dont
    /// l'empreinte compte moins de points que de cubes affiche donc moins de
    /// blocs qu'elle n'en contient, et la question devient indécidable.
    static func empreinte(_ e: Empilement) -> Set<[Int]> {
        let points = e.map { [$0.x - $0.y, $0.x + $0.y - 2 * $0.z] }
        guard let minA = points.map({ $0[0] }).min(),
              let minB = points.map({ $0[1] }).min() else { return [] }
        return Set(points.map { [$0[0] - minA, $0[1] - minB] })
    }

    /// Vrai si aucun cube n'en masque un autre dans cette orientation.
    static func lisible(_ e: Empilement) -> Bool {
        empreinte(e).count == e.count
    }

    /// Une forme est chirale si son miroir ne peut pas être obtenu par rotation.
    ///
    /// Sans cette vérification, un empilement symétrique donnerait trois figures
    /// superposables et la question n'aurait aucune réponse.
    static func estChirale(_ e: Empilement) -> Bool {
        let reflet = miroir(e)
        return !toutesLesRotations(e).contains(reflet)
    }

    // MARK: Génération

    /// Construit un empilement connexe en ajoutant des cubes voisins.
    static func formeAleatoire(nombreDeCubes: Int) -> Empilement {
        var cubes: Set<Cube> = [Cube(x: 0, y: 0, z: 0)]
        let directions = [(1, 0, 0), (-1, 0, 0), (0, 1, 0), (0, -1, 0), (0, 0, 1), (0, 0, -1)]

        while cubes.count < nombreDeCubes {
            guard let base = cubes.randomElement(),
                  let direction = directions.randomElement() else { break }
            let candidat = Cube(x: base.x + direction.0,
                                y: base.y + direction.1,
                                z: base.z + direction.2)
            cubes.insert(candidat)
        }
        return normaliser(Array(cubes))
    }

    struct Question {
        let figures: [Empilement]
        /// Index de la figure ayant subi la symétrie.
        let indexSymetrie: Int
    }

    static func generate(nombreDeCubes: Int = 5) -> Question {
        for _ in 0..<300 {
            let forme = formeAleatoire(nombreDeCubes: nombreDeCubes)
            guard forme.count == nombreDeCubes, estChirale(forme) else { continue }

            let orientations = toutesLesRotations(forme).filter(lisible).shuffled()
            guard orientations.count >= 2 else { continue }
            let reflets = toutesLesRotations(miroir(forme)).filter(lisible).shuffled()
            guard let reflet = reflets.first else { continue }

            // Deux orientations différentes de la même forme, plus un reflet
            var figures = [orientations[0], orientations[1], reflet]

            // Deux figures au dessin identique rendraient la troisième
            // reconnaissable sans raisonnement, ou la question insoluble si
            // c'est le reflet qui se confond avec une rotation.
            guard Set(figures.map(empreinte)).count == 3 else { continue }
            let index = Int.random(in: 0..<3)
            figures.swapAt(2, index)

            return Question(figures: figures, indexSymetrie: index)
        }

        // Repli déterministe : une forme en L tordu, chirale. Les deux figures
        // non symétriques doivent être vues sous des angles différents, sinon
        // le doublon désigne la troisième.
        let forme = normaliser([Cube(x: 0, y: 0, z: 0), Cube(x: 1, y: 0, z: 0),
                                Cube(x: 1, y: 1, z: 0), Cube(x: 1, y: 1, z: 1),
                                Cube(x: 2, y: 1, z: 1)])
        let vues = toutesLesRotations(forme).filter(lisible)
        let reflets = toutesLesRotations(miroir(forme)).filter(lisible)
        let premiere = vues.first ?? forme
        let seconde = vues.first { empreinte($0) != empreinte(premiere) } ?? forme
        let reflet = reflets.first { empreinte($0) != empreinte(premiere)
                                     && empreinte($0) != empreinte(seconde) }
                     ?? miroir(forme)
        return Question(figures: [premiere, seconde, reflet], indexSymetrie: 2)
    }
}

// MARK: - Rendu isométrique

/// Dessine un empilement en projection isométrique.
struct EmpilementView: View {
    let cubes: Empilement
    var cote: CGFloat = 22

    private var largeurDemi: CGFloat { cote * cos(.pi / 6) }
    private var hauteurDemi: CGFloat { cote * sin(.pi / 6) }

    /// Position à l'écran du centre de la face supérieure d'un cube.
    private func projection(_ c: Cube) -> CGPoint {
        CGPoint(x: CGFloat(c.x - c.y) * largeurDemi,
                y: CGFloat(c.x + c.y) * hauteurDemi - CGFloat(c.z) * cote)
    }

    var body: some View {
        Canvas { context, taille in
            // Du fond vers l'avant, pour que les cubes proches recouvrent les autres
            let ordonnes = cubes.sorted { ($0.x + $0.y + $0.z) < ($1.x + $1.y + $1.z) }
            let points = ordonnes.map(projection)
            let minX = points.map(\.x).min() ?? 0
            let maxX = points.map(\.x).max() ?? 0
            let minY = points.map(\.y).min() ?? 0
            let maxY = points.map(\.y).max() ?? 0
            let decalage = CGPoint(
                x: taille.width / 2 - (minX + maxX) / 2,
                y: taille.height / 2 - (minY + maxY) / 2
            )

            for point in points {
                let centre = CGPoint(x: point.x + decalage.x, y: point.y + decalage.y)
                dessinerCube(context: context, centre: centre)
            }
        }
    }

    private func dessinerCube(context: GraphicsContext, centre: CGPoint) {
        let haut = CGPoint(x: centre.x, y: centre.y - hauteurDemi)
        let droite = CGPoint(x: centre.x + largeurDemi, y: centre.y)
        let bas = CGPoint(x: centre.x, y: centre.y + hauteurDemi)
        let gauche = CGPoint(x: centre.x - largeurDemi, y: centre.y)

        // Face supérieure
        var dessus = Path()
        dessus.move(to: haut)
        dessus.addLine(to: droite)
        dessus.addLine(to: bas)
        dessus.addLine(to: gauche)
        dessus.closeSubpath()

        // Face avant gauche
        var faceGauche = Path()
        faceGauche.move(to: gauche)
        faceGauche.addLine(to: bas)
        faceGauche.addLine(to: CGPoint(x: bas.x, y: bas.y + cote))
        faceGauche.addLine(to: CGPoint(x: gauche.x, y: gauche.y + cote))
        faceGauche.closeSubpath()

        // Face avant droite
        var faceDroite = Path()
        faceDroite.move(to: bas)
        faceDroite.addLine(to: droite)
        faceDroite.addLine(to: CGPoint(x: droite.x, y: droite.y + cote))
        faceDroite.addLine(to: CGPoint(x: bas.x, y: bas.y + cote))
        faceDroite.closeSubpath()

        context.fill(dessus, with: .color(Color(red: 0.62, green: 0.73, blue: 0.88)))
        context.fill(faceGauche, with: .color(Color(red: 0.36, green: 0.49, blue: 0.68)))
        context.fill(faceDroite, with: .color(Color(red: 0.25, green: 0.35, blue: 0.52)))
        for face in [dessus, faceGauche, faceDroite] {
            context.stroke(face, with: .color(.black.opacity(0.35)), lineWidth: 1)
        }
    }
}

// MARK: - ViewModel

@MainActor
@Observable
final class EmpilementsViewModel {
    var question: EmpilementsGenerator.Question?
    var currentQuestion: Int = 0
    var totalQuestions: Int = 20
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var timeRemaining: Double = 10
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
        // La difficulté monte avec l'avancement : plus de cubes, plus dur à
        // comparer mentalement.
        let cubes = currentQuestion < 7 ? 4 : (currentQuestion < 14 ? 5 : 6)
        question = EmpilementsGenerator.generate(nombreDeCubes: cubes)
        timeRemaining = 10
        startTimer()
    }

    private func startTimer() {
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: 10) { [self] restant in
            timeRemaining = restant
        } onFinish: { [self] in
            repondre(nil)
        }
    }

    func repondre(_ index: Int?) {
        guard !showFeedback else { return }
        timerTask?.cancel()
        selectedIndex = index
        showFeedback = true

        if let index, index == question?.indexSymetrie {
            correctAnswers += 1
            HapticManager.success()
        } else {
            wrongAnswers += 1
            HapticManager.error()
        }

        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(1200))
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
        return GameResult(gameType: .empilementsCubes, score: Double(correctAnswers),
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

struct EmpilementsView: View {
    @State private var viewModel = EmpilementsViewModel()

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
        .navigationTitle("Empilements")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Masqué pendant la partie : empiler cette destination
                // déclenche le onDisappear de la vue, donc stopGame(),
                // ce qui effacerait la partie en cours sans prévenir.
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .empilementsCubes)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Empilements",
                    rules: [
                        RuleItem(icon: "cube", text: "Trois empilements sont présentés"),
                        RuleItem(icon: "arrow.triangle.2.circlepath", text: "Deux sont identiques, à une rotation près"),
                        RuleItem(icon: "flip.horizontal", text: "Le troisième a subi une symétrie"),
                        RuleItem(icon: "hand.tap", text: "Touche celui qui a subi la symétrie"),
                        RuleItem(icon: "timer", text: "10 secondes par question")
                    ],
                    accentColor: .mint,
                    isGameActive: viewModel.isGameActive
                )
            }
        }
        .onDisappear {
            viewModel.stopGame()
        }
    }

    private var startView: some View {
        VStack(spacing: 28) {
            Spacer()
            Image(systemName: "cube.fill")
                .font(.system(size: 76))
                .foregroundStyle(.mint)
            Text("Empilements")
                .font(.largeTitle.weight(.bold))

            VStack(alignment: .leading, spacing: 8) {
                Label("Trois empilements sont présentés", systemImage: "cube")
                Label("Deux sont identiques, à une rotation près", systemImage: "arrow.triangle.2.circlepath")
                Label("Le troisième a subi une symétrie", systemImage: "flip.horizontal")
                Label("Touche celui qui a subi la symétrie", systemImage: "hand.tap")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("20 questions, 10s chacune")
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
                    .background(Color.mint)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }

    @ViewBuilder
    private var gameView: some View {
        if let question = viewModel.question {
            VStack(spacing: 16) {
                HStack {
                    Text("Question \(viewModel.currentQuestion + 1)/\(viewModel.totalQuestions)")
                        .font(.headline)
                    Spacer()
                    Text(String(format: "%.1fs", max(0, viewModel.timeRemaining)))
                        .font(.headline.monospacedDigit())
                        .foregroundStyle(viewModel.timeRemaining < 3 ? .red : .primary)
                }

                GeometryReader { geo in
                    let barre = max(0, viewModel.timeRemaining / 10)
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color(.systemGray5))
                        Capsule().fill(viewModel.timeRemaining < 3 ? Color.red : Color.mint)
                            .frame(width: geo.size.width * barre)
                    }
                }
                .frame(height: 6)

                Text("Lequel a subi une symétrie ?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                VStack(spacing: 12) {
                    ForEach(question.figures.indices, id: \.self) { index in
                        Button {
                            viewModel.repondre(index)
                        } label: {
                            HStack {
                                Text("\(index + 1)")
                                    .font(.headline)
                                    .frame(width: 28)
                                EmpilementView(cubes: question.figures[index])
                                    .frame(height: 110)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(couleurFond(index, question: question))
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

                if viewModel.showFeedback {
                    Text(viewModel.selectedIndex == nil
                         ? "Temps écoulé"
                         : (viewModel.selectedIndex == question.indexSymetrie ? "Correct !" : "Raté"))
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(viewModel.selectedIndex == question.indexSymetrie ? .green : .red)
                }

                Spacer()
            }
        }
    }

    private func couleurFond(_ index: Int, question: EmpilementsGenerator.Question) -> Color {
        guard viewModel.showFeedback else { return Color(.systemGray6) }
        if index == question.indexSymetrie { return .green.opacity(0.25) }
        if index == viewModel.selectedIndex { return .red.opacity(0.25) }
        return Color(.systemGray6)
    }

    private func bordure(_ index: Int, question: EmpilementsGenerator.Question) -> Color {
        guard viewModel.showFeedback else { return .clear }
        if index == question.indexSymetrie { return .green }
        if index == viewModel.selectedIndex { return .red }
        return .clear
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
                    .background(Color.mint)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        EmpilementsView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
