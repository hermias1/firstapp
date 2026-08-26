import Foundation
import SwiftData

/// Une partie terminée, telle qu'elle est conservée sur l'appareil.
///
/// `gameType` stocke le `rawValue` de `GameType` : une clé stable, contrairement
/// à l'identifiant de `Game` qui était régénéré à chaque lancement.
@Model
final class GameSession {
    var gameType: String
    var date: Date
    var score: Double
    var correctAnswers: Int
    var totalItems: Int
    var duration: TimeInterval

    init(gameType: String, date: Date, score: Double,
         correctAnswers: Int, totalItems: Int, duration: TimeInterval) {
        self.gameType = gameType
        self.date = date
        self.score = score
        self.correctAnswers = correctAnswers
        self.totalItems = totalItems
        self.duration = duration
    }

    convenience init(result: GameResult, date: Date = Date()) {
        self.init(gameType: result.gameType.rawValue,
                  date: date,
                  score: result.score,
                  correctAnswers: result.correctAnswers,
                  totalItems: result.totalItems,
                  duration: result.duration)
    }
}
