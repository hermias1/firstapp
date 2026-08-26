import SwiftUI

// MARK: - Model
struct StarPuzzle {
    let words: [String] // 9 mots de 7 lettres
    let solution: [String] // 6 mots qui forment une solution valide

    static func generate() -> StarPuzzle {
        // Mots de 6-8 lettres avec des lettres communes
        let wordSets: [[String]] = [
            // Set 1 - Lettres communes: A, E, R
            ["ABRICOT", "ARBITRE", "CALIBRE", "DECIBEL", "ESCRIME", "GERBIER", "HERBIER", "LIBERAL", "MINERAL"],
            // Set 2 - Lettres communes: I, O, N
            ["ABEILLE", "CABINET", "DEBITER", "FENETRE", "GLACIER", "HABITUE", "INCITER", "JANVIER", "LIBERTÉ"],
            // Set 3 - Lettres communes: E, R, T
            ["ACROBAT", "BAROQUE", "CAPABLE", "DECORER", "ECARTER", "FABULER", "GALOPER", "HABITER", "IMPOSER"],
            // Set 4 - Lettres communes: A, L, E
            ["ADAPTER", "BALAYER", "CAPABLE", "DERNIER", "ECLATER", "FACETTE", "GALERIE", "HALETER", "IMPASSE"],
            // Set 5 - Lettres communes: O, R, E
            ["ADMIRER", "BALISER", "CAPORAL", "DECODER", "ECOLIER", "FABULER", "GAMBADE", "HABILLE", "IVRESSE"],
            // Set 6 - Lettres communes: A, N, T
            ["ABANDON", "BALANCE", "CABINET", "DANCING", "ELEGANT", "FANTOME", "GALANTE", "HABITANT", "INSTANT"],
            // Set 7 - Lettres communes: E, S, T
            ["ARTISTE", "BATISTE", "CELESTE", "DETESTE", "EGOISTE", "FACIÈS", "GESTION", "HISTOIRE", "INSISTE"],
            // Set 8 - Lettres communes: I, R, E
            ["ADMIRER", "BRUITER", "CITERAI", "DELITRE", "ECRITURE", "FILTRER", "GLISSER", "HERITER", "IGNORER"],
            // Set 9 - Lettres communes: O, N, E
            ["ABONNER", "BOUGONNE", "CANNONE", "DETONER", "ETONNER", "FLONNER", "GAZONN", "HONNETE", "IONISER"],
            // Set 10 - Lettres communes: A, R, I
            ["AFFIRME", "BÂTIR", "CHARITÉ", "DARLING", "ECRIRA", "FARCIR", "GARNIR", "HAIRAIT", "IMAGINA"],
            // Set 11 - Lettres communes: E, L, A
            ["ALERTER", "BALLADE", "CALEPIN", "DALMATE", "ELASTIQUE", "FALÁFEL", "GALETAS", "HALLEBARDE", "IDEALES"],
            // Set 12 - Lettres communes: O, U, R
            ["AMOUR", "BOUGRE", "COLOUR", "DETOUR", "EBOURGÉ", "FOUDRE", "GOURDE", "HOURRA", "INJURE"],
            // Set 13 - Lettres communes: I, N, E
            ["ANEMIE", "BENIGNE", "CANINE", "DIVINE", "ENIVRER", "FÉMININE", "GENUINE", "HIVERNE", "INANIME"],
            // Set 14 - Lettres communes: A, T, E
            ["ABATTRE", "BATTAGE", "CANTATE", "DATTERA", "EPATERA", "FATALE", "GÂTERIE", "HABITER", "IGNARE"],
            // Set 15 - Lettres communes: O, S, E
            ["ARROSER", "BOISÉES", "CHOISIE", "DEPOSIT", "EXPOSER", "FLOSSER", "GLOSSER", "HOSPICE", "IMPOSE"],
            // Set 16 - Lettres communes: E, R, S
            ["ADMIRES", "BRESSER", "CRISSER", "DRESSER", "EXPRESS", "FRESSER", "GRESSER", "HIESSER", "IVRESSE"],
            // Set 17 - Lettres communes: A, N, E
            ["ARCANES", "BANANES", "CANAPES", "DANOISE", "ENGANE", "FANFARE", "GANGRENE", "HANGAR", "INANITÉ"],
            // Set 18 - Lettres communes: I, T, E
            ["ABRITER", "BRUITER", "CITERAI", "DEBITER", "ECRITES", "FILTRER", "GÎTERA", "HÉRITER", "IMITERA"],
            // Set 19 - Lettres communes: O, R, T
            ["AVORTER", "BORTSCH", "CONFORT", "DISTORT", "EXHORTE", "FORT", "GORTEX", "HORTEUR", "IMPORT"],
            // Set 20 - Lettres communes: A, L, I
            ["ABOLIRA", "BALISER", "CALIBRE", "DALIBEC", "ÉTALIR", "FAMILIÉ", "GALIBOT", "HALIBUT", "INALIÉ"],
        ]

        // Choisir un set principal (6 mots corrects avec lettres communes)
        let correctSetIndex = Int.random(in: 0..<wordSets.count)
        let correctSet = wordSets[correctSetIndex].shuffled()
        let correctWords = Array(correctSet.prefix(6))

        // Choisir un set différent pour les 3 distracteurs
        var distractorSetIndex: Int
        repeat {
            distractorSetIndex = Int.random(in: 0..<wordSets.count)
        } while distractorSetIndex == correctSetIndex

        let distractorSet = wordSets[distractorSetIndex].shuffled()
        let distractorWords = Array(distractorSet.prefix(3))

        // Mélanger les 9 mots ensemble
        let allWords = (correctWords + distractorWords).shuffled()

        return StarPuzzle(
            words: allWords,
            solution: correctWords
        )
    }
}

// MARK: - ViewModel
@MainActor
@Observable
final class MotsEnEtoileViewModel {
    var puzzle: StarPuzzle?
    var availableWords: [String] = []
    var placedWords: [Int: String] = [:] // position (0-5) -> mot
    var selectedWord: String?
    var currentQuestion: Int = 0
    var totalQuestions: Int = 10
    var correctAnswers: Int = 0
    var timeRemaining: Int = 50
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var showResult: Bool = false

    private var timerTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    func startGame() {
        currentQuestion = 0
        correctAnswers = 0
        isGameActive = true
        isGameOver = false
        loadNewPuzzle()
    }

    private func loadNewPuzzle() {
        puzzle = StarPuzzle.generate()
        availableWords = puzzle?.words ?? []
        placedWords = [:]
        selectedWord = nil
        showResult = false
        timeRemaining = 50
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
                validatePuzzle()
            }
        }
    }

    func selectWord(_ word: String) {
        if selectedWord == word {
            selectedWord = nil
        } else {
            selectedWord = word
        }
    }

    func placeWordAt(_ position: Int) {
        guard let word = selectedWord else { return }

        // Si la position a déjà un mot, le remettre dans les disponibles
        if let existingWord = placedWords[position] {
            availableWords.append(existingWord)
        }

        // Retirer le mot des disponibles et le placer
        availableWords.removeAll { $0 == word }
        placedWords[position] = word
        selectedWord = nil
    }

    func removeWordFrom(_ position: Int) {
        if let word = placedWords[position] {
            availableWords.append(word)
            placedWords[position] = nil
        }
    }

    func validatePuzzle() {
        timerTask?.cancel()
        showResult = true

        // Vérifier si 6 mots sont placés ET s'ils sont tous dans la solution
        if placedWords.count == 6, let solution = puzzle?.solution {
            let placedWordsList = Array(placedWords.values)
            // Tous les mots placés doivent être dans la solution
            let allCorrect = placedWordsList.allSatisfy { solution.contains($0) }

            if allCorrect {
                correctAnswers += 1
                HapticManager.success()
            } else {
                HapticManager.error()
            }
        } else {
            // Pas assez de mots placés
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
                loadNewPuzzle()
            }
        }
    }

    private func endGame() {
        timerTask?.cancel()
        isGameActive = false
        isGameOver = true
    }

    func stopGame() {
        timerTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = false
    }
}

// MARK: - Star Shape View
struct StarPlacementView: View {
    let placedWords: [Int: String]
    let onTapPosition: (Int) -> Void
    let onRemove: (Int) -> Void

    var body: some View {
        ZStack {
            // Dessiner l'étoile
            StarShape()
                .stroke(Color.yellow, lineWidth: 3)
                .frame(width: 250, height: 250)

            // Positions sur l'étoile (6 positions)
            ForEach(0..<6, id: \.self) { index in
                let position = starPosition(for: index, in: 250)

                Button {
                    if placedWords[index] != nil {
                        onRemove(index)
                    } else {
                        onTapPosition(index)
                    }
                } label: {
                    if let word = placedWords[index] {
                        Text(word)
                            .font(.caption2.weight(.bold))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                            .background(Color.yellow)
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    } else {
                        Circle()
                            .fill(Color.yellow.opacity(0.3))
                            .frame(width: 30, height: 30)
                            .overlay(
                                Text("\(index + 1)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            )
                    }
                }
                .position(x: position.x + 125, y: position.y + 125)
            }
        }
        .frame(width: 250, height: 250)
    }

    private func starPosition(for index: Int, in size: CGFloat) -> CGPoint {
        let radius = size / 2 - 30
        let angle = (Double(index) * 60 - 90) * .pi / 180
        return CGPoint(
            x: cos(angle) * radius,
            y: sin(angle) * radius
        )
    }
}

struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.4

        for i in 0..<12 {
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            let angle = (Double(i) * 30 - 90) * .pi / 180
            let point = CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )

            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}

// MARK: - View
struct MotsEnEtoileView: View {
    @State private var viewModel = MotsEnEtoileViewModel()

    var body: some View {
        VStack(spacing: 16) {
            if viewModel.isGameActive {
                gameActiveView
            } else if viewModel.isGameOver {
                gameOverView
            } else {
                startView
            }
        }
        .padding()
        .navigationTitle("Mots en Étoile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Mots en Étoile",
                    rules: [
                        RuleItem(icon: "textformat.size", text: "9 mots affichés"),
                        RuleItem(icon: "checkmark.circle", text: "6 mots partagent des lettres communes"),
                        RuleItem(icon: "hand.tap", text: "Trouve et place les 6 bons mots"),
                        RuleItem(icon: "timer", text: "50 secondes par puzzle")
                    ],
                    accentColor: .yellow
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

            Image(systemName: "star.fill")
                .font(.system(size: 80))
                .foregroundStyle(.yellow)

            Text("Mots en Étoile")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                Text("Règles du jeu")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Label("9 mots affichés", systemImage: "textformat.size")
                    Label("6 mots font partie du groupe", systemImage: "checkmark.circle")
                    Label("Trouve et place les 6 bons mots", systemImage: "hand.tap")
                    Label("50 secondes pour résoudre", systemImage: "timer")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("10 puzzles, 50s chacun")
                .font(.callout)
                .foregroundStyle(.secondary)

            Text("(Version entraînement simplifié)")
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()

            Button {
                viewModel.startGame()
            } label: {
                Text("Commencer")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.yellow)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var gameActiveView: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                Text("Puzzle \(viewModel.currentQuestion + 1)/\(viewModel.totalQuestions)")
                    .font(.headline)

                Spacer()

                TimerView(timeRemaining: viewModel.timeRemaining, totalTime: 50)
            }

            // Étoile
            StarPlacementView(
                placedWords: viewModel.placedWords,
                onTapPosition: { position in
                    viewModel.placeWordAt(position)
                },
                onRemove: { position in
                    viewModel.removeWordFrom(position)
                }
            )

            // Instructions
            if let selected = viewModel.selectedWord {
                Text("Mot sélectionné: \(selected)")
                    .font(.subheadline)
                    .foregroundStyle(.yellow)
            } else {
                Text("Sélectionne un mot puis une position")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            // Mots disponibles
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                ForEach(viewModel.availableWords, id: \.self) { word in
                    Button {
                        viewModel.selectWord(word)
                    } label: {
                        Text(word)
                            .font(.caption.weight(.medium))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .frame(maxWidth: .infinity)
                            .background(viewModel.selectedWord == word ? Color.yellow : Color(.systemGray5))
                            .foregroundStyle(viewModel.selectedWord == word ? .black : .primary)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }

            Spacer()

            // Bouton valider
            if !viewModel.showResult {
                Button {
                    viewModel.validatePuzzle()
                } label: {
                    Text("Valider (\(viewModel.placedWords.count)/6)")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.placedWords.count == 6 ? .yellow : Color(.systemGray4))
                        .foregroundStyle(viewModel.placedWords.count == 6 ? .black : .secondary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(viewModel.placedWords.count < 6)
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
                ResultRow(label: "Puzzles réussis", value: "\(viewModel.correctAnswers)")
                ResultRow(label: "Total", value: "\(viewModel.totalQuestions)")
                ResultRow(label: "Score", value: "\(viewModel.correctAnswers * 10) pts")
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
                    .background(.yellow)
                    .foregroundStyle(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    NavigationStack {
        MotsEnEtoileView()
    }
}
