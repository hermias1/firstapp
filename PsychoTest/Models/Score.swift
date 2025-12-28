import Foundation

struct Score: Identifiable, Codable {
    let id: UUID
    let gameId: UUID
    let gameName: String
    let points: Int
    let accuracy: Double
    let date: Date
    let duration: TimeInterval

    init(gameId: UUID, gameName: String, points: Int, accuracy: Double, duration: TimeInterval) {
        self.id = UUID()
        self.gameId = gameId
        self.gameName = gameName
        self.points = points
        self.accuracy = accuracy
        self.date = Date()
        self.duration = duration
    }
}
