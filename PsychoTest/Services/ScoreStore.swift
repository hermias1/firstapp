import Foundation
import SwiftData

/// Accès aux parties enregistrées.
///
/// Les classes `@Model` ne sont pas `Sendable` : tout passe donc par le
/// contexte principal, ce qui suffit largement ici (une écriture par partie).
@MainActor
struct ScoreStore {
    let context: ModelContext

    /// Enregistre une partie et indique si elle établit un nouveau record.
    ///
    /// Le record est évalué **avant** l'insertion, sinon la partie qu'on vient
    /// d'ajouter se comparerait à elle-même.
    @discardableResult
    func record(_ result: GameResult) -> Bool {
        let nouveauRecord = isRecord(result)
        context.insert(GameSession(result: result))
        try? context.save()
        return nouveauRecord
    }

    /// Un score bat le record s'il est plus haut — ou plus bas pour les jeux
    /// mesurés en temps. La première partie d'un jeu est toujours un record.
    func isRecord(_ result: GameResult) -> Bool {
        guard let meilleur = best(for: result.gameType) else { return true }
        return result.gameType.lowerIsBetter
            ? result.score < meilleur.score
            : result.score > meilleur.score
    }

    func best(for type: GameType) -> GameSession? {
        let parties = sessions(for: type)
        return type.lowerIsBetter
            ? parties.min(by: { $0.score < $1.score })
            : parties.max(by: { $0.score < $1.score })
    }

    /// Les parties les plus récentes d'abord.
    func recent(for type: GameType, limit: Int = 20) -> [GameSession] {
        Array(sessions(for: type).prefix(limit))
    }

    func count(for type: GameType) -> Int {
        sessions(for: type).count
    }

    /// Le filtrage se fait en Swift plutôt que par un prédicat SwiftData :
    /// le volume est minuscule (une ligne par partie jouée) et cela garde la
    /// requête lisible et sans surprise.
    private func sessions(for type: GameType) -> [GameSession] {
        let descripteur = FetchDescriptor<GameSession>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        let toutes = (try? context.fetch(descripteur)) ?? []
        return toutes.filter { $0.gameType == type.rawValue }
    }

    /// Efface l'historique d'un jeu, à la demande de l'utilisateur.
    func reset(_ type: GameType) {
        for partie in sessions(for: type) {
            context.delete(partie)
        }
        try? context.save()
    }
}
