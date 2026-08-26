import SwiftUI

// MARK: - Modèle

/// Une forme à poser sur la grille, décrite par les cases qu'elle occupe
/// relativement à son coin haut-gauche.
struct FormeGlissee: Equatable {
    let cases: [Position]
    let hauteur: Int
    let largeur: Int

    struct Position: Equatable, Hashable {
        let ligne: Int
        let colonne: Int
    }
}

/// Un puzzle de superposition.
///
/// Règles officielles du test : deux cases marine superposées donnent marine,
/// une marine et une grise donnent gris, deux grises donnent marine. C'est
/// exactement un OU exclusif, ce qui rend la superposition indépendante de
/// l'ordre de pose des formes.
struct FormesGlisseesPuzzle {
    let formes: [FormeGlissee]
    let cible: [[Bool]]
    let solution: [FormeGlissee.Position]
    let taille: Int
}

enum FormesGlisseesGenerator {
    static let taille = 5

    /// Applique une forme sur une grille : chaque case couverte bascule.
    static func appliquer(_ forme: FormeGlissee, en position: FormeGlissee.Position,
                          sur grille: inout [[Bool]]) {
        for c in forme.cases {
            grille[position.ligne + c.ligne][position.colonne + c.colonne].toggle()
        }
    }

    /// Toutes les positions où la forme tient entièrement dans la grille.
    static func positionsValides(_ forme: FormeGlissee, taille: Int) -> [FormeGlissee.Position] {
        var resultat: [FormeGlissee.Position] = []
        for ligne in 0...(taille - forme.hauteur) {
            for colonne in 0...(taille - forme.largeur) {
                resultat.append(.init(ligne: ligne, colonne: colonne))
            }
        }
        return resultat
    }

    static func grilleVide(_ taille: Int) -> [[Bool]] {
        Array(repeating: Array(repeating: false, count: taille), count: taille)
    }

    /// Les formes possibles, toutes distinctes, tenant dans une boîte 2×2 ou 2×3.
    static let catalogue: [FormeGlissee] = [
        FormeGlissee(cases: [.init(ligne: 0, colonne: 0), .init(ligne: 0, colonne: 1),
                             .init(ligne: 1, colonne: 0), .init(ligne: 1, colonne: 1)],
                     hauteur: 2, largeur: 2),                                   // carré
        FormeGlissee(cases: [.init(ligne: 0, colonne: 0), .init(ligne: 0, colonne: 1),
                             .init(ligne: 1, colonne: 0)],
                     hauteur: 2, largeur: 2),                                   // coin
        FormeGlissee(cases: [.init(ligne: 0, colonne: 1), .init(ligne: 1, colonne: 0),
                             .init(ligne: 1, colonne: 1)],
                     hauteur: 2, largeur: 2),                                   // coin opposé
        FormeGlissee(cases: [.init(ligne: 0, colonne: 0), .init(ligne: 0, colonne: 1),
                             .init(ligne: 0, colonne: 2)],
                     hauteur: 1, largeur: 3),                                   // barre
        FormeGlissee(cases: [.init(ligne: 0, colonne: 0), .init(ligne: 1, colonne: 0)],
                     hauteur: 2, largeur: 1),                                   // domino vertical
        FormeGlissee(cases: [.init(ligne: 0, colonne: 0), .init(ligne: 0, colonne: 1),
                             .init(ligne: 1, colonne: 1), .init(ligne: 1, colonne: 2)],
                     hauteur: 2, largeur: 3),                                   // marche
        FormeGlissee(cases: [.init(ligne: 0, colonne: 0), .init(ligne: 1, colonne: 0),
                             .init(ligne: 1, colonne: 1), .init(ligne: 0, colonne: 2)],
                     hauteur: 2, largeur: 3),                                   // dispersée
    ]

    /// Compte les placements distincts qui reproduisent la cible.
    ///
    /// Sert à garantir qu'un puzzle n'a qu'une seule réponse : un puzzle à
    /// plusieurs solutions rendrait la correction arbitraire.
    static func nombreDeSolutions(formes: [FormeGlissee], cible: [[Bool]],
                                  taille: Int) -> Int {
        let positions = formes.map { positionsValides($0, taille: taille) }
        var total = 0

        func explorer(_ index: Int, _ grille: [[Bool]]) {
            if index == formes.count {
                if grille == cible { total += 1 }
                return
            }
            for position in positions[index] {
                var suivante = grille
                appliquer(formes[index], en: position, sur: &suivante)
                explorer(index + 1, suivante)
            }
        }
        explorer(0, grilleVide(taille))
        return total
    }

    static func generate() -> FormesGlisseesPuzzle {
        for _ in 0..<300 {
            let formes = Array(catalogue.shuffled().prefix(3))
            var cible = grilleVide(taille)
            var solution: [FormeGlissee.Position] = []

            for forme in formes {
                guard let position = positionsValides(forme, taille: taille).randomElement() else { break }
                solution.append(position)
                appliquer(forme, en: position, sur: &cible)
            }
            guard solution.count == formes.count else { continue }

            // Une cible presque vide serait triviale ; une cible à solution
            // multiple serait injuste.
            let casesGrises = cible.flatMap { $0 }.filter { $0 }.count
            guard casesGrises >= 5 else { continue }
            guard nombreDeSolutions(formes: formes, cible: cible, taille: taille) == 1 else { continue }

            return FormesGlisseesPuzzle(formes: formes, cible: cible,
                                        solution: solution, taille: taille)
        }

        // Repli déterministe
        let formes = [catalogue[0], catalogue[3], catalogue[4]]
        var cible = grilleVide(taille)
        let solution: [FormeGlissee.Position] = [.init(ligne: 0, colonne: 0),
                                                 .init(ligne: 3, colonne: 1),
                                                 .init(ligne: 2, colonne: 4)]
        for (forme, position) in zip(formes, solution) {
            appliquer(forme, en: position, sur: &cible)
        }
        return FormesGlisseesPuzzle(formes: formes, cible: cible,
                                    solution: solution, taille: taille)
    }
}

// MARK: - ViewModel

@MainActor
@Observable
final class FormesGlisseesViewModel {
    var puzzle: FormesGlisseesPuzzle?
    var grille: [[Bool]] = []
    var placements: [Int: FormeGlissee.Position] = [:]
    var formeSelectionnee: Int = 0
    var currentQuestion: Int = 0
    var totalQuestions: Int = 10
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var timeRemaining: Int = 60
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var showFeedback: Bool = false
    var derniereReussie: Bool = false

    private var timerTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    var accuracy: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalQuestions) * 100
    }

    /// Une forme non encore posée, à proposer au joueur.
    var formesRestantes: [Int] {
        guard let puzzle else { return [] }
        return puzzle.formes.indices.filter { placements[$0] == nil }
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
        let nouveau = FormesGlisseesGenerator.generate()
        puzzle = nouveau
        grille = FormesGlisseesGenerator.grilleVide(nouveau.taille)
        placements = [:]
        formeSelectionnee = 0
        showFeedback = false
        timeRemaining = 60
        startTimer()
    }

    private func startTimer() {
        timerTask?.cancel()
        timerTask = Countdown.start(seconds: 60) { [self] restant in
            timeRemaining = Int(restant.rounded(.up))
        } onFinish: { [self] in
            terminer(reussi: false)
        }
    }

    /// Coin haut-gauche correspondant à une case survolée, la forme étant
    /// centrée sur le doigt plutôt qu'accrochée par un coin invisible.
    func coinPourCentre(forme: FormeGlissee, ligne: Int, colonne: Int) -> FormeGlissee.Position? {
        guard let puzzle else { return nil }
        let cible = puzzle.taille
        let l = min(max(0, ligne - forme.hauteur / 2), cible - forme.hauteur)
        let c = min(max(0, colonne - forme.largeur / 2), cible - forme.largeur)
        return FormeGlissee.Position(ligne: l, colonne: c)
    }

    /// Cases que la forme en cours de déplacement recouvrirait.
    func apercu(forme: FormeGlissee, en position: FormeGlissee.Position) -> Set<FormeGlissee.Position> {
        Set(forme.cases.map {
            FormeGlissee.Position(ligne: position.ligne + $0.ligne,
                                  colonne: position.colonne + $0.colonne)
        })
    }

    /// Dépose une forme donnée à une position déjà validée.
    func deposer(index: Int, en position: FormeGlissee.Position) {
        guard let puzzle, !showFeedback, placements[index] == nil else { return }
        let forme = puzzle.formes[index]
        guard position.ligne + forme.hauteur <= puzzle.taille,
              position.colonne + forme.largeur <= puzzle.taille else { return }

        placements[index] = position
        FormesGlisseesGenerator.appliquer(forme, en: position, sur: &grille)
        HapticManager.light()

        if let suivante = formesRestantes.first {
            formeSelectionnee = suivante
        } else {
            terminer(reussi: grille == puzzle.cible)
        }
    }

    func recommencer() {
        guard let puzzle, !showFeedback else { return }
        grille = FormesGlisseesGenerator.grilleVide(puzzle.taille)
        placements = [:]
        formeSelectionnee = 0
    }

    private func terminer(reussi: Bool) {
        guard !showFeedback else { return }
        timerTask?.cancel()
        showFeedback = true
        derniereReussie = reussi
        if reussi {
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
        return GameResult(gameType: .formesGlissees, score: Double(correctAnswers),
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

// MARK: - Grille

private let couleurMarine = Color(red: 0.11, green: 0.21, blue: 0.42)
private let couleurGrise = Color(red: 0.72, green: 0.74, blue: 0.78)

struct GrilleView: View {
    let grille: [[Bool]]
    let cote: CGFloat
    /// Cases que la forme en cours de déplacement viendrait recouvrir.
    var apercu: Set<FormeGlissee.Position> = []
    var onTap: ((Int, Int) -> Void)? = nil

    var body: some View {
        VStack(spacing: 2) {
            ForEach(grille.indices, id: \.self) { ligne in
                HStack(spacing: 2) {
                    ForEach(grille[ligne].indices, id: \.self) { colonne in
                        Rectangle()
                            .fill(grille[ligne][colonne] ? couleurGrise : couleurMarine)
                            .frame(width: cote, height: cote)
                            .overlay(
                                apercu.contains(.init(ligne: ligne, colonne: colonne))
                                ? Rectangle().stroke(Color.yellow, lineWidth: 3)
                                : nil
                            )
                            .onTapGesture { onTap?(ligne, colonne) }
                    }
                }
            }
        }
        .padding(4)
        .background(Color(.systemGray4))
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

private struct FormeApercu: View {
    let forme: FormeGlissee
    let selectionnee: Bool

    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<forme.hauteur, id: \.self) { ligne in
                HStack(spacing: 2) {
                    ForEach(0..<forme.largeur, id: \.self) { colonne in
                        Rectangle()
                            .fill(forme.cases.contains(.init(ligne: ligne, colonne: colonne))
                                  ? couleurGrise : Color.clear)
                            .frame(width: 16, height: 16)
                    }
                }
            }
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(selectionnee ? Color.gray.opacity(0.35) : Color(.systemGray6))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(selectionnee ? Color.accentColor : Color.clear, lineWidth: 2)
        )
    }
}

// MARK: - Vue

struct FormesGlisseesView: View {
    @State private var viewModel = FormesGlisseesViewModel()

    /// Cadre de la grille de travail, pour convertir la position du doigt en case.
    @State private var cadreGrille: CGRect = .zero
    @State private var formeEnMain: Int?
    @State private var positionDoigt: CGPoint?

    private let coteCase: CGFloat = 34

    /// Case survolée par le doigt, si celui-ci est au-dessus de la grille.
    private func caseSurvolee(_ point: CGPoint) -> (ligne: Int, colonne: Int)? {
        guard cadreGrille.contains(point), let puzzle = viewModel.puzzle else { return nil }
        let pas = coteCase + 2
        let colonne = Int((point.x - cadreGrille.minX - 4) / pas)
        let ligne = Int((point.y - cadreGrille.minY - 4) / pas)
        guard (0..<puzzle.taille).contains(ligne), (0..<puzzle.taille).contains(colonne) else {
            return nil
        }
        return (ligne, colonne)
    }

    /// Position de dépôt visée par le doigt, forme centrée sous lui.
    private func positionVisee() -> FormeGlissee.Position? {
        guard let index = formeEnMain, let point = positionDoigt,
              let puzzle = viewModel.puzzle,
              let survolee = caseSurvolee(point) else { return nil }
        return viewModel.coinPourCentre(forme: puzzle.formes[index],
                                        ligne: survolee.ligne, colonne: survolee.colonne)
    }

    private var apercuCases: Set<FormeGlissee.Position> {
        guard let index = formeEnMain, let puzzle = viewModel.puzzle,
              let position = positionVisee() else { return [] }
        return viewModel.apercu(forme: puzzle.formes[index], en: position)
    }

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
        .navigationTitle("Formes Glissées")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    GameStatsView(type: .formesGlissees)
                } label: {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Formes Glissées",
                    rules: [
                        RuleItem(icon: "square.on.square", text: "Superpose les formes pour reproduire la cible"),
                        RuleItem(icon: "square.fill", text: "Marine + marine = marine"),
                        RuleItem(icon: "square.lefthalf.filled", text: "Marine + gris = gris"),
                        RuleItem(icon: "square", text: "Gris + gris = marine"),
                        RuleItem(icon: "hand.tap", text: "Touche une case : la forme s'y pose par son coin haut-gauche"),
                        RuleItem(icon: "timer", text: "60 secondes par grille")
                    ],
                    accentColor: .gray,
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
            Image(systemName: "square.on.square")
                .font(.system(size: 76))
                .foregroundStyle(.gray)
            Text("Formes Glissées")
                .font(.largeTitle.weight(.bold))

            VStack(alignment: .leading, spacing: 10) {
                Text("Règles de superposition")
                    .font(.headline)
                HStack(spacing: 10) {
                    carre(false); Text("+"); carre(false); Text("="); carre(false)
                }
                HStack(spacing: 10) {
                    carre(false); Text("+"); carre(true); Text("="); carre(true)
                }
                HStack(spacing: 10) {
                    carre(true); Text("+"); carre(true); Text("="); carre(false)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("10 grilles, 60s chacune")
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
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }

    private func carre(_ gris: Bool) -> some View {
        Rectangle()
            .fill(gris ? couleurGrise : couleurMarine)
            .frame(width: 22, height: 22)
            .clipShape(RoundedRectangle(cornerRadius: 3))
    }

    @ViewBuilder
    private var gameView: some View {
        if let puzzle = viewModel.puzzle {
            ZStack {
                VStack(spacing: 14) {
                    HStack {
                        Text("Grille \(viewModel.currentQuestion + 1)/\(viewModel.totalQuestions)")
                            .font(.headline)
                        Spacer()
                        TimerView(timeRemaining: viewModel.timeRemaining, totalTime: 60)
                    }

                    HStack(alignment: .top, spacing: 16) {
                        VStack(spacing: 6) {
                            Text("Cible").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                            GrilleView(grille: puzzle.cible, cote: 18)
                        }
                        VStack(spacing: 6) {
                            Text("Ta grille").font(.caption.weight(.semibold)).foregroundStyle(.secondary)
                            GrilleView(grille: viewModel.grille, cote: coteCase, apercu: apercuCases)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear.onAppear {
                                            cadreGrille = geo.frame(in: .named("plateau"))
                                        }
                                        .onChange(of: geo.frame(in: .named("plateau"))) { _, cadre in
                                            cadreGrille = cadre
                                        }
                                    }
                                )
                        }
                    }
                    .frame(maxWidth: .infinity)

                    if !viewModel.formesRestantes.isEmpty {
                        Text("Fais glisser une forme sur la grille")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        HStack(spacing: 12) {
                            ForEach(viewModel.formesRestantes, id: \.self) { index in
                                FormeApercu(forme: puzzle.formes[index],
                                            selectionnee: formeEnMain == index)
                                    .opacity(formeEnMain == index ? 0.35 : 1)
                                    .gesture(
                                        DragGesture(minimumDistance: 0, coordinateSpace: .named("plateau"))
                                            .onChanged { valeur in
                                                guard !viewModel.showFeedback else { return }
                                                formeEnMain = index
                                                positionDoigt = valeur.location
                                            }
                                            .onEnded { _ in
                                                if let position = positionVisee() {
                                                    viewModel.deposer(index: index, en: position)
                                                }
                                                formeEnMain = nil
                                                positionDoigt = nil
                                            }
                                    )
                            }
                        }
                    }

                    if viewModel.showFeedback {
                        Text(viewModel.derniereReussie ? "Correct !" : "Raté")
                            .font(.headline)
                            .foregroundStyle(viewModel.derniereReussie ? .green : .red)
                    } else {
                        Button("Recommencer le placement") {
                            viewModel.recommencer()
                        }
                        .font(.subheadline)
                    }

                    Spacer(minLength: 0)
                }

                // La forme suit le doigt, décalée vers le haut pour rester visible
                if let index = formeEnMain, let point = positionDoigt {
                    FormeApercu(forme: puzzle.formes[index], selectionnee: true)
                        .opacity(0.9)
                        .allowsHitTesting(false)
                        .position(x: point.x, y: point.y - 46)
                }
            }
            .coordinateSpace(.named("plateau"))
        }
    }

    private var gameOverView: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: viewModel.accuracy >= 70 ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 70))
                .foregroundStyle(viewModel.accuracy >= 70 ? .green : .red)
            Text("Terminé !").font(.largeTitle.weight(.bold))

            VStack(spacing: 12) {
                ResultRow(label: "Grilles réussies", value: "\(viewModel.correctAnswers)/\(viewModel.totalQuestions)")
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
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        FormesGlisseesView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
