import SwiftUI

// MARK: - Model

/// Un puzzle vérifié : les 6 mots de `solution` partagent `commonLetters`,
/// et aucun autre groupe de 6 mots parmi les 9 n'en partage autant.
/// Cette unicité est garantie à la construction du corpus et vérifiée par les tests.
struct StarPuzzleData {
    let solution: [String]
    let distractors: [String]
    let commonLetters: String
}

struct StarPuzzle {
    let words: [String] // les 9 mots proposés
    let solution: [String] // les 6 mots à retrouver
    let commonLetters: String // les lettres que partagent les 6 mots

    /// Corpus de mots français validés par le correcteur orthographique système.
    /// Tous les mots d'un même puzzle ont la même longueur : une longueur
    /// différente serait un indice visuel gratuit.
    static let allPuzzles: [StarPuzzleData] = [
        StarPuzzleData(
            solution: ["GERMINAL", "ASPIRINE", "OREILLER", "REPLIQUE", "EUPHORIE", "SONNERIE"],
            distractors: ["JUDAISME", "EMERAUDE", "CHEVALET"],
            commonLetters: "EIR"
        ),
        StarPuzzleData(
            solution: ["REUNION", "NEUTRON", "TERREUR", "MERCURE", "COULEUR", "MARTEAU"],
            distractors: ["MEMOIRE", "CONSOLE", "MUSIQUE"],
            commonLetters: "ERU"
        ),
        StarPuzzleData(
            solution: ["TERRASSE", "EMERAUDE", "ASPIRINE", "LANTERNE", "PASSOIRE", "SCENARIO"],
            distractors: ["BALTIQUE", "OREILLER", "PONCEUSE"],
            commonLetters: "AER"
        ),
        StarPuzzleData(
            solution: ["TENAILLE", "CANNELLE", "ALLEMAND", "GERMINAL", "ELECTRON", "LENTILLE"],
            distractors: ["PASSOIRE", "ANGOISSE", "TONNERRE"],
            commonLetters: "ELN"
        ),
        StarPuzzleData(
            solution: ["ELEPHANT", "PATIENCE", "ASPIRINE", "PANCREAS", "PASSOIRE", "PANTHERE"],
            distractors: ["COSTUMES", "SEIGNEUR", "DENTELLE"],
            commonLetters: "AEP"
        ),
        StarPuzzleData(
            solution: ["MURAILLE", "IMMEUBLE", "BALTIQUE", "ZOOLOGIE", "REPLIQUE", "TENAILLE"],
            distractors: ["ASPIRINE", "JUDAISME", "NOUVELLE"],
            commonLetters: "EIL"
        ),
        StarPuzzleData(
            solution: ["ASPIRINE", "LENTILLE", "VENDREDI", "PROTEINE", "PEINTURE", "DIMANCHE"],
            distractors: ["PANTHERE", "CHEVALET", "JUDAISME"],
            commonLetters: "EIN"
        ),
        StarPuzzleData(
            solution: ["EUPHORIE", "THYROIDE", "PYRAMIDE", "CUILLERE", "CHANTIER", "REPLIQUE"],
            distractors: ["ANGOISSE", "IMMEUBLE", "BIOLOGIE"],
            commonLetters: "EIR"
        ),
        StarPuzzleData(
            solution: ["MERCURE", "GUEPARD", "TERREUR", "COURAGE", "CORBEAU", "HUMERUS"],
            distractors: ["AMPOULE", "LOYAUTE", "BASILIC"],
            commonLetters: "ERU"
        ),
        StarPuzzleData(
            solution: ["TERRASSE", "BORDEAUX", "ESTUAIRE", "ESCARPIN", "SCARABEE", "ASPIRINE"],
            distractors: ["EQUINOXE", "THYROIDE", "ESQUISSE"],
            commonLetters: "AER"
        ),
        StarPuzzleData(
            solution: ["PHYSIQUE", "MURAILLE", "JUDAISME", "ARCTIQUE", "REPLIQUE", "EUPHORIE"],
            distractors: ["ELEPHANT", "ELECTRON", "LANTERNE"],
            commonLetters: "EIU"
        ),
        StarPuzzleData(
            solution: ["LANTERNE", "SCARABEE", "EMERAUDE", "BORDEAUX", "TRIANGLE", "MURAILLE"],
            distractors: ["EQUINOXE", "PHYSIQUE", "CHOCOLAT"],
            commonLetters: "AER"
        ),
        StarPuzzleData(
            solution: ["BALTIQUE", "BASTILLE", "PATINAGE", "SOLSTICE", "ARCTIQUE", "THYROIDE"],
            distractors: ["BORDEAUX", "PONCEUSE", "DENTELLE"],
            commonLetters: "EIT"
        ),
        StarPuzzleData(
            solution: ["BATTERIE", "CUILLERE", "REPLIQUE", "GERMINAL", "PYRAMIDE", "ARCTIQUE"],
            distractors: ["JUDAISME", "LUNETTES", "NOVEMBRE"],
            commonLetters: "EIR"
        ),
        StarPuzzleData(
            solution: ["CEINTURE", "REPLIQUE", "PASSOIRE", "PYRAMIDE", "ESTUAIRE", "CUILLERE"],
            distractors: ["BORDEAUX", "COSTUMES", "NATATION"],
            commonLetters: "EIR"
        ),
        StarPuzzleData(
            solution: ["PATINAGE", "SCENARIO", "TENAILLE", "INTESTIN", "PEINTURE", "CEINTURE"],
            distractors: ["PASSOIRE", "PERCEUSE", "PAPILLON"],
            commonLetters: "EIN"
        ),
        StarPuzzleData(
            solution: ["PATINAGE", "GERMINAL", "SCENARIO", "ARCTIQUE", "BALTIQUE", "ESCARPIN"],
            distractors: ["PORTRAIT", "PANCREAS", "ELECTRON"],
            commonLetters: "AEI"
        ),
        StarPuzzleData(
            solution: ["GERMINAL", "ASPIRINE", "PYRAMIDE", "BATTERIE", "CEINTURE", "SONNERIE"],
            distractors: ["ANGOISSE", "NATATION", "LUNETTES"],
            commonLetters: "EIR"
        ),
        StarPuzzleData(
            solution: ["NOVEMBRE", "GERMINAL", "CHANTIER", "ESCARPIN", "PRUDENCE", "TRIANGLE"],
            distractors: ["SCARABEE", "DENTELLE", "ALLEMAND"],
            commonLetters: "ENR"
        ),
        StarPuzzleData(
            solution: ["MAGAZINE", "PATIENCE", "TRIANGLE", "EQUINOXE", "PATINAGE", "LENTILLE"],
            distractors: ["BOURGEON", "PORTRAIT", "ORCHIDEE"],
            commonLetters: "EIN"
        ),
    ]

    static func generate() -> StarPuzzle {
        let data = allPuzzles.randomElement()!
        return StarPuzzle(
            words: (data.solution + data.distractors).shuffled(),
            solution: data.solution,
            commonLetters: data.commonLetters
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
    var lastAnswerCorrect: Bool = false

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
        lastAnswerCorrect = false
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
                lastAnswerCorrect = true
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
                        RuleItem(icon: "checkmark.circle", text: "6 des 9 mots partagent 3 lettres"),
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

            if let puzzle = viewModel.puzzle {
                Text("Trouve les 6 mots qui partagent \(puzzle.commonLetters.count) lettres")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
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
            if viewModel.showResult {
                VStack(spacing: 4) {
                    Text(viewModel.lastAnswerCorrect ? "Correct !" : "Raté")
                        .font(.headline)
                        .foregroundStyle(viewModel.lastAnswerCorrect ? .green : .red)
                    if !viewModel.lastAnswerCorrect, let puzzle = viewModel.puzzle {
                        Text("Solution : " + puzzle.solution.joined(separator: ", "))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
            } else if let selected = viewModel.selectedWord {
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
