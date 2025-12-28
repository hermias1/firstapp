import Foundation
import SwiftUI
import Observation

@MainActor
@Observable
final class MentalCalculationViewModel {
    // MARK: - Properties
    var currentQuestion: String = ""
    var correctAnswer: Int = 0
    var userAnswer: String = ""
    var score: Int = 0
    var correctCount: Int = 0
    var totalQuestions: Int = 0
    var timeRemaining: Int = 60
    var isGameActive: Bool = false
    var isGameOver: Bool = false
    var difficulty: Difficulty = .medium

    private var timerTask: Task<Void, Never>?

    enum Difficulty: String, CaseIterable {
        case easy = "Facile"
        case medium = "Moyen"
        case hard = "Difficile"

        var range: ClosedRange<Int> {
            switch self {
            case .easy: return 1...10
            case .medium: return 1...50
            case .hard: return 1...100
            }
        }

        var operations: [MathOperation] {
            switch self {
            case .easy: return [.addition, .subtraction]
            case .medium: return [.addition, .subtraction, .multiplication]
            case .hard: return MathOperation.allCases
            }
        }
    }

    enum MathOperation: String, CaseIterable {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "×"
        case division = "÷"
    }

    // MARK: - Game Logic
    func startGame() {
        score = 0
        correctCount = 0
        totalQuestions = 0
        timeRemaining = 60
        isGameActive = true
        isGameOver = false
        userAnswer = ""
        generateQuestion()
        startTimer()
    }

    func stopGame() {
        timerTask?.cancel()
        timerTask = nil
        isGameActive = false
        isGameOver = true
    }

    func submitAnswer() {
        guard let answer = Int(userAnswer) else { return }

        totalQuestions += 1

        if answer == correctAnswer {
            correctCount += 1
            let basePoints = 10
            let timeBonus = timeRemaining / 10
            score += basePoints + timeBonus
        }

        userAnswer = ""
        generateQuestion()
    }

    private func generateQuestion() {
        let range = difficulty.range
        let operations = difficulty.operations
        let operation = operations.randomElement() ?? .addition

        var num1 = Int.random(in: range)
        var num2 = Int.random(in: range)

        switch operation {
        case .addition:
            correctAnswer = num1 + num2
            currentQuestion = "\(num1) + \(num2)"

        case .subtraction:
            if num1 < num2 { swap(&num1, &num2) }
            correctAnswer = num1 - num2
            currentQuestion = "\(num1) - \(num2)"

        case .multiplication:
            num1 = Int.random(in: 1...12)
            num2 = Int.random(in: 1...12)
            correctAnswer = num1 * num2
            currentQuestion = "\(num1) × \(num2)"

        case .division:
            num2 = Int.random(in: 1...12)
            correctAnswer = Int.random(in: 1...12)
            num1 = num2 * correctAnswer
            currentQuestion = "\(num1) ÷ \(num2)"
        }
    }

    private func startTimer() {
        // Cancel any existing timer before starting a new one
        timerTask?.cancel()
        timerTask = Task { @MainActor in
            while !Task.isCancelled && timeRemaining > 0 {
                try? await Task.sleep(for: .seconds(1))
                if Task.isCancelled { break }
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
                if timeRemaining == 0 {
                    stopGame()
                }
            }
        }
    }
}
