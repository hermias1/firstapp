import SwiftUI

// MARK: - Modèle

enum FaceCube: Int, CaseIterable {
    case haut, bas, gauche, droite, avant, arriere
}

/// Un cube dont chaque face porte un symbole.
struct CubeSymbolise: Equatable {
    /// Index du symbole porté par chaque face.
    var symboles: [Int]

    subscript(face: FaceCube) -> Int { symboles[face.rawValue] }

    /// Ce que l'on voit d'un cube posé devant soi : dessus, avant, droite.
    var vue: [Int] { [self[.haut], self[.avant], self[.droite]] }
}

enum CubesGenerator {
    /// Les six symboles possibles, choisis pour rester distinguables sans
    /// dépendre de la couleur.
    static let symboles = ["circle.fill", "square.fill", "triangle.fill",
                           "star.fill", "xmark", "diamond.fill"]

    // MARK: Rotations

    /// Une rotation est une permutation des faces : `permutation[f]` indique où
    /// la face `f` se retrouve après rotation.
    private static let rotationX: [Int] = {
        var p = Array(0..<6)
        p[FaceCube.haut.rawValue] = FaceCube.arriere.rawValue
        p[FaceCube.arriere.rawValue] = FaceCube.bas.rawValue
        p[FaceCube.bas.rawValue] = FaceCube.avant.rawValue
        p[FaceCube.avant.rawValue] = FaceCube.haut.rawValue
        return p
    }()

    private static let rotationY: [Int] = {
        var p = Array(0..<6)
        p[FaceCube.avant.rawValue] = FaceCube.gauche.rawValue
        p[FaceCube.gauche.rawValue] = FaceCube.arriere.rawValue
        p[FaceCube.arriere.rawValue] = FaceCube.droite.rawValue
        p[FaceCube.droite.rawValue] = FaceCube.avant.rawValue
        return p
    }()

    private static let rotationZ: [Int] = {
        var p = Array(0..<6)
        p[FaceCube.haut.rawValue] = FaceCube.droite.rawValue
        p[FaceCube.droite.rawValue] = FaceCube.bas.rawValue
        p[FaceCube.bas.rawValue] = FaceCube.gauche.rawValue
        p[FaceCube.gauche.rawValue] = FaceCube.haut.rawValue
        return p
    }()

    static func appliquer(_ permutation: [Int], a cube: CubeSymbolise) -> CubeSymbolise {
        var resultat = cube.symboles
        for face in 0..<6 {
            resultat[permutation[face]] = cube.symboles[face]
        }
        return CubeSymbolise(symboles: resultat)
    }

    /// Les 24 orientations d'un cube.
    static func toutesLesOrientations(_ cube: CubeSymbolise) -> [CubeSymbolise] {
        var vues = Set<[Int]>()
        var resultat: [CubeSymbolise] = []
        var frontiere = [cube]
        vues.insert(cube.symboles)

        while let courant = frontiere.popLast() {
            resultat.append(courant)
            for rotation in [rotationX, rotationY, rotationZ] {
                let suivant = appliquer(rotation, a: courant)
                if vues.insert(suivant.symboles).inserted {
                    frontiere.append(suivant)
                }
            }
        }
        return resultat
    }

    /// Les triplets (dessus, avant, droite) réellement observables sur ce cube.
    ///
    /// Il y en a exactement 24. Tout autre triplet — même composé de trois faces
    /// du cube — décrit un cube impossible : soit deux faces opposées y
    /// apparaissent ensemble, soit l'ordre de rotation autour du sommet est inversé.
    static func vuesPossibles(_ cube: CubeSymbolise) -> Set<[Int]> {
        Set(toutesLesOrientations(cube).map(\.vue))
    }

    // MARK: Génération

    /// Les agencements de trois faces distinctes qu'aucune rotation ne peut
    /// produire : soit deux faces opposées y voisinent, soit l'ordre de
    /// rotation autour du sommet est inversé.
    static func tripletsImpossibles(pour cube: CubeSymbolise) -> [[Int]] {
        let realisables = vuesPossibles(cube)
        var resultat: [[Int]] = []
        for premier in 0..<6 {
            for deuxieme in 0..<6 where deuxieme != premier {
                for troisieme in 0..<6 where troisieme != premier && troisieme != deuxieme {
                    let triplet = [premier, deuxieme, troisieme]
                    if !realisables.contains(triplet) { resultat.append(triplet) }
                }
            }
        }
        return resultat
    }

    struct Question {
        let cube: CubeSymbolise
        /// Les quatre vues proposées, sous forme de triplets de symboles.
        let propositions: [[Int]]
        let indexCorrect: Int
    }

    static func generate() -> Question {
        for _ in 0..<200 {
            // Les six faces portent six symboles différents
            let cube = CubeSymbolise(symboles: Array(0..<6).shuffled())
            let possibles = vuesPossibles(cube)
            guard let correcte = possibles.randomElement() else { continue }

            // Les distracteurs sont tirés parmi TOUS les agencements
            // irréalisables, jamais dérivés de la bonne réponse. Les fabriquer
            // en modifiant une ou deux faces de la vue correcte la désignait :
            // elle restait le consensus des quatre propositions, ce qui
            // permettait de répondre à 87 % sans jamais lire le patron.
            let impossibles = CubesGenerator.tripletsImpossibles(pour: cube)
            let fausses = Array(impossibles.shuffled().prefix(3))
            guard fausses.count == 3 else { continue }

            var propositions = Array(fausses)
            let index = Int.random(in: 0...3)
            propositions.insert(correcte, at: index)
            return Question(cube: cube, propositions: propositions, indexCorrect: index)
        }

        // Repli déterministe
        let cube = CubeSymbolise(symboles: [0, 1, 2, 3, 4, 5])
        let correcte = cube.vue
        return Question(cube: cube,
                        propositions: [correcte, [correcte[1], correcte[0], correcte[2]],
                                       [correcte[0], correcte[2], correcte[1]],
                                       [correcte[2], correcte[1], correcte[0]]],
                        indexCorrect: 0)
    }
}

// MARK: - Rendu

/// Le patron déplié, en croix latine.
struct PatronView: View {
    let cube: CubeSymbolise
    var cote: CGFloat = 44

    var body: some View {
        VStack(spacing: 2) {
            ligne([nil, .haut, nil, nil])
            ligne([.gauche, .avant, .droite, .arriere])
            ligne([nil, .bas, nil, nil])
        }
    }

    private func ligne(_ faces: [FaceCube?]) -> some View {
        HStack(spacing: 2) {
            ForEach(faces.indices, id: \.self) { index in
                if let face = faces[index] {
                    caseFace(cube[face])
                } else {
                    Color.clear.frame(width: cote, height: cote)
                }
            }
        }
    }

    private func caseFace(_ symbole: Int) -> some View {
        Image(systemName: CubesGenerator.symboles[symbole])
            .font(.system(size: cote * 0.42))
            .foregroundStyle(.primary)
            .frame(width: cote, height: cote)
            .background(Color(.systemGray6))
            .overlay(Rectangle().stroke(Color(.systemGray3), lineWidth: 1))
    }
}

/// Un cube en perspective, montrant ses trois faces visibles.
struct CubeVueView: View {
    /// Triplet dessus, avant, droite.
    let vue: [Int]
    var cote: CGFloat = 40

    var body: some View {
        ZStack {
            // Face du dessus, en losange aplati
            symbole(vue[0])
                .frame(width: cote, height: cote * 0.55)
                .background(Color(.systemGray5))
                .overlay(Rectangle().stroke(Color(.systemGray3), lineWidth: 1))
                .offset(y: -cote * 0.55)

            HStack(spacing: 0) {
                symbole(vue[1])
                    .frame(width: cote, height: cote)
                    .background(Color(.systemGray6))
                    .overlay(Rectangle().stroke(Color(.systemGray3), lineWidth: 1))
                symbole(vue[2])
                    .frame(width: cote * 0.55, height: cote)
                    .background(Color(.systemGray4))
                    .overlay(Rectangle().stroke(Color(.systemGray3), lineWidth: 1))
            }
        }
        .frame(width: cote * 1.6, height: cote * 1.7)
    }

    private func symbole(_ index: Int) -> some View {
        Image(systemName: CubesGenerator.symboles[index])
            .font(.system(size: cote * 0.36))
            .foregroundStyle(.primary)
    }
}

// MARK: - ViewModel

@MainActor
@Observable
final class CubesPatronsViewModel {
    var question: CubesGenerator.Question?
    var currentQuestion: Int = 0
    var totalQuestions: Int = 15
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var timeRemaining: Int = 25
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
        question = CubesGenerator.generate()
        timeRemaining = 25
        startTimer()
    }

    private func startTimer() {
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: 25) { [self] restant in
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
        return GameResult(gameType: .cubes2D3D, score: Double(correctAnswers),
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

struct CubesPatronsView: View {
    @State private var viewModel = CubesPatronsViewModel()

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
        .navigationTitle("Cubes 2D/3D")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // Masqué pendant la partie : empiler cette destination
                // déclenche le onDisappear de la vue, donc stopGame(),
                // ce qui effacerait la partie en cours sans prévenir.
                if !viewModel.isGameActive {
                    NavigationLink {
                        GameStatsView(type: .cubes2D3D)
                    } label: {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Cubes 2D/3D",
                    rules: [
                        RuleItem(icon: "square.grid.3x3", text: "Un patron déplié est présenté"),
                        RuleItem(icon: "cube", text: "Quatre cubes en perspective sont proposés"),
                        RuleItem(icon: "checkmark", text: "Un seul peut être plié à partir du patron"),
                        RuleItem(icon: "exclamationmark.triangle", text: "Attention au sens de rotation des faces"),
                        RuleItem(icon: "timer", text: "25 secondes par question")
                    ],
                    accentColor: .purple,
                    isGameActive: viewModel.isGameActive
                )
            }
        }
        .onDisappear { viewModel.stopGame() }
    }

    private var startView: some View {
        VStack(spacing: 28) {
            Spacer()
            Image(systemName: "cube.transparent.fill")
                .font(.system(size: 76))
                .foregroundStyle(.purple)
            Text("Cubes 2D/3D").font(.largeTitle.weight(.bold))

            VStack(alignment: .leading, spacing: 8) {
                Label("Un patron déplié est présenté", systemImage: "square.grid.3x3")
                Label("Quatre cubes en perspective sont proposés", systemImage: "cube")
                Label("Un seul peut être plié à partir du patron", systemImage: "checkmark")
                Label("Attention au sens de rotation des faces", systemImage: "exclamationmark.triangle")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("15 questions, 25s chacune")
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
                    .background(Color.purple)
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
                    TimerView(timeRemaining: viewModel.timeRemaining, totalTime: 25)
                }

                PatronView(cube: question.cube)

                Text("Quel cube correspond à ce patron ?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                    ForEach(question.propositions.indices, id: \.self) { index in
                        Button {
                            viewModel.repondre(index)
                        } label: {
                            CubeVueView(vue: question.propositions[index])
                                .frame(maxWidth: .infinity)
                                .padding(8)
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

                if viewModel.showFeedback {
                    Text(viewModel.selectedIndex == nil
                         ? "Temps écoulé"
                         : (viewModel.selectedIndex == question.indexCorrect ? "Correct !" : "Raté"))
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(viewModel.selectedIndex == question.indexCorrect ? .green : .red)
                }

                Spacer()
            }
        }
    }

    private func fond(_ index: Int, question: CubesGenerator.Question) -> Color {
        guard viewModel.showFeedback else { return Color(.systemBackground) }
        if index == question.indexCorrect { return .green.opacity(0.2) }
        if index == viewModel.selectedIndex { return .red.opacity(0.2) }
        return Color(.systemBackground)
    }

    private func bordure(_ index: Int, question: CubesGenerator.Question) -> Color {
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
                    .background(Color.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        CubesPatronsView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
