import SwiftUI

// MARK: - Model
enum ShapeType: String, CaseIterable {
    case square = "Carré"
    case triangle = "Triangle"
}

enum FillType: String, CaseIterable {
    case empty = "Vide"
    case filled = "Plein"
}

enum ShapeColor: String, CaseIterable {
    case blue = "Bleu"
    case orange = "Orange"

    var color: Color {
        switch self {
        case .blue: return .blue
        case .orange: return .orange
        }
    }
}

struct ShapeItem: Equatable {
    let shape: ShapeType
    let fill: FillType
    let color: ShapeColor

    // Règles PSY0 :
    // Si VIDE → N si Bleu, X si Orange
    // Si PLEIN → N si Carré, X si Triangle
    var expectedKey: String {
        switch fill {
        case .empty:
            return color == .blue ? "N" : "X"
        case .filled:
            return shape == .square ? "N" : "X"
        }
    }

    static func random() -> ShapeItem {
        ShapeItem(
            shape: ShapeType.allCases.randomElement()!,
            fill: FillType.allCases.randomElement()!,
            color: ShapeColor.allCases.randomElement()!
        )
    }
}

// MARK: - ViewModel
@MainActor
@Observable
final class FormesCouleursViewModel {
    var currentShape: ShapeItem?
    var currentIndex: Int = 0
    var totalShapes: Int = 30
    var correctAnswers: Int = 0
    var wrongAnswers: Int = 0
    var isShowingShape: Bool = false
    var isWaitingForAnswer: Bool = false
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var feedback: String?
    var timeRemaining: Double = 2.5

    private var displayTask: Task<Void, Never>?
    private var answerTask: Task<Void, Never>?
    private var transitionTask: Task<Void, Never>?

    var accuracy: Double {
        let total = correctAnswers + wrongAnswers
        guard total > 0 else { return 0 }
        return Double(correctAnswers) / Double(total) * 100
    }

    func startGame() {
        currentIndex = 0
        correctAnswers = 0
        wrongAnswers = 0
        isGameActive = true
        isGameOver = false
        feedback = nil
        showNextShape()
    }

    private func showNextShape() {
        guard currentIndex < totalShapes else {
            endGame()
            return
        }

        feedback = nil
        currentShape = ShapeItem.random()
        isShowingShape = true
        isWaitingForAnswer = false
        timeRemaining = 2.5

        // Afficher la forme pendant 0.8s
        displayTask?.cancel()
        displayTask = Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(800))
            if Task.isCancelled { return }
            isShowingShape = false
            isWaitingForAnswer = true
            startAnswerTimer()
        }
    }

    private func startAnswerTimer() {
        answerTask?.cancel()
        answerTask = Task { @MainActor in
            while !Task.isCancelled && timeRemaining > 0 {
                try? await Task.sleep(for: .milliseconds(100))
                if Task.isCancelled { break }
                timeRemaining -= 0.1
            }
            if !Task.isCancelled && isWaitingForAnswer {
                handleTimeout()
            }
        }
    }

    private func handleTimeout() {
        wrongAnswers += 1
        feedback = "Temps écoulé !"
        moveToNext()
    }

    func answer(_ key: String) {
        guard isWaitingForAnswer, let shape = currentShape else { return }

        answerTask?.cancel()
        isWaitingForAnswer = false

        if key == shape.expectedKey {
            correctAnswers += 1
            feedback = "Correct !"
            HapticManager.success()
        } else {
            wrongAnswers += 1
            feedback = "Faux ! C'était \(shape.expectedKey)"
            HapticManager.error()
        }

        moveToNext()
    }

    private func moveToNext() {
        currentIndex += 1

        transitionTask?.cancel()
        transitionTask = Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(600))
            if Task.isCancelled { return }
            showNextShape()
        }
    }

    private func endGame() {
        displayTask?.cancel()
        answerTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = true
    }

    func stopGame() {
        displayTask?.cancel()
        answerTask?.cancel()
        transitionTask?.cancel()
        isGameActive = false
        isGameOver = false
    }
}

// MARK: - Shape Drawing View
struct ShapeDrawingView: View {
    let item: ShapeItem
    let size: CGFloat

    var body: some View {
        ZStack {
            switch item.shape {
            case .square:
                squareShape
            case .triangle:
                triangleShape
            }
        }
        .frame(width: size, height: size)
    }

    @ViewBuilder
    private var squareShape: some View {
        switch item.fill {
        case .empty:
            Rectangle()
                .stroke(item.color.color, lineWidth: 6)
        case .filled:
            Rectangle()
                .fill(item.color.color)
        }
    }

    @ViewBuilder
    private var triangleShape: some View {
        switch item.fill {
        case .empty:
            Triangle()
                .stroke(item.color.color, lineWidth: 6)
        case .filled:
            Triangle()
                .fill(item.color.color)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// MARK: - View
struct FormesCouleursView: View {
    @State private var viewModel = FormesCouleursViewModel()

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isGameActive {
                gameActiveView
            } else if viewModel.isGameOver {
                gameOverView
            } else {
                startView
            }
        }
        .padding()
        .navigationTitle("Formes et Couleurs")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                GameRulesButton(
                    title: "Règles - Formes et Couleurs",
                    rules: [
                        RuleItem(icon: "square.dotted", text: "VIDE: N=Bleu, X=Orange"),
                        RuleItem(icon: "square.fill", text: "REMPLI: N=Carré, X=Triangle"),
                        RuleItem(icon: "timer", text: "3 secondes par forme"),
                        RuleItem(icon: "eye", text: "Forme visible 0.8 seconde")
                    ],
                    accentColor: .pink
                )
            }
        }
        .onDisappear {
            viewModel.stopGame()
        }
    }

    private var startView: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "square.on.circle")
                .font(.system(size: 80))
                .foregroundStyle(.pink)

            Text("Formes et Couleurs")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {
                Text("Règles")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Si la forme est VIDE :")
                            .font(.subheadline.weight(.semibold))
                        HStack(spacing: 20) {
                            Label("Bleu → N", systemImage: "circle")
                                .foregroundStyle(.blue)
                            Label("Orange → X", systemImage: "circle")
                                .foregroundStyle(.orange)
                        }
                        .font(.subheadline)
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Si la forme est PLEINE :")
                            .font(.subheadline.weight(.semibold))
                        HStack(spacing: 20) {
                            Label("Carré → N", systemImage: "square.fill")
                            Label("Triangle → X", systemImage: "triangle.fill")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text("30 formes • 0.8s affichage • 2.5s réponse")
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
                    .background(.pink)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var gameActiveView: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("\(viewModel.currentIndex + 1)/\(viewModel.totalShapes)")
                    .font(.headline)

                Spacer()

                HStack(spacing: 12) {
                    Label("\(viewModel.correctAnswers)", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                    Label("\(viewModel.wrongAnswers)", systemImage: "xmark.circle.fill")
                        .foregroundStyle(.red)
                }
                .font(.subheadline)
            }

            Spacer()

            // Zone d'affichage de la forme
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(.systemGray6))
                    .frame(width: 200, height: 200)

                if viewModel.isShowingShape, let shape = viewModel.currentShape {
                    ShapeDrawingView(item: shape, size: 120)
                } else if viewModel.isWaitingForAnswer {
                    Text("?")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundStyle(.secondary)
                }
            }

            // Feedback
            if let feedback = viewModel.feedback {
                Text(feedback)
                    .font(.headline)
                    .foregroundStyle(feedback.contains("Correct") ? .green : .red)
            } else {
                Text(" ")
                    .font(.headline)
            }

            // Timer bar
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.pink.opacity(0.3))
                    .frame(height: 8)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.pink)
                            .frame(width: max(0, geo.size.width * (viewModel.timeRemaining / 2.5)))
                    }
            }
            .frame(height: 8)
            .opacity(viewModel.isWaitingForAnswer ? 1 : 0)

            Spacer()

            // Rappel des règles compact
            HStack(spacing: 8) {
                Text("VIDE: Bleu→N, Orange→X")
                    .font(.caption2)
                Text("|")
                Text("PLEIN: Carré→N, Triangle→X")
                    .font(.caption2)
            }
            .foregroundStyle(.secondary)

            // 2 boutons de réponse
            HStack(spacing: 20) {
                Button {
                    viewModel.answer("N")
                } label: {
                    Text("N")
                        .font(.system(size: 48, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(Color.blue.opacity(0.2))
                        .foregroundStyle(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue, lineWidth: 3)
                        )
                }
                .disabled(!viewModel.isWaitingForAnswer)

                Button {
                    viewModel.answer("X")
                } label: {
                    Text("X")
                        .font(.system(size: 48, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(Color.orange.opacity(0.2))
                        .foregroundStyle(.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.orange, lineWidth: 3)
                        )
                }
                .disabled(!viewModel.isWaitingForAnswer)
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
                ResultRow(label: "Bonnes réponses", value: "\(viewModel.correctAnswers)")
                ResultRow(label: "Mauvaises réponses", value: "\(viewModel.wrongAnswers)")
                ResultRow(label: "Précision", value: String(format: "%.0f%%", viewModel.accuracy))
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
                    .background(.pink)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    NavigationStack {
        FormesCouleursView()
    }
}
