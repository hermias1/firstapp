import Foundation

/// Résultat d'une partie terminée.
///
/// Type valeur volontairement indépendant de SwiftData : les ViewModels le
/// produisent sans rien savoir du stockage, ce qui rend le calcul des scores
/// testable sans base de données ni interface.
struct GameResult {
    let gameType: GameType
    let score: Double
    let correctAnswers: Int
    let totalItems: Int
    let duration: TimeInterval
}
