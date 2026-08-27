import Foundation
import SwiftData

/// Accès aux parties enregistrées.
///
/// Les classes `@Model` ne sont pas `Sendable` : tout passe donc par le
/// contexte principal, ce qui suffit largement ici (une écriture par partie).
@MainActor
struct ScoreStore {
    let context: ModelContext

    /// Où se situe une partie parmi celles déjà jouées sur ce test.
    enum Situation: Equatable {
        case premiere
        case record
        /// Rang de la partie, 1 étant la meilleure.
        case rang(Int, sur: Int)
    }

    /// Enregistre une partie et indique comment elle se situe.
    ///
    /// La sélection note en classes, c'est-à-dire en rangs : un score brut ne
    /// dit rien tout seul. Faute de connaître les résultats des autres
    /// candidats, on situe au moins le joueur par rapport à lui-même.
    @discardableResult
    func enregistrer(_ result: GameResult) -> Situation {
        let anterieures = sessions(for: result.gameType)
        let nouveauRecord = isRecord(result)
        context.insert(GameSession(result: result))
        try? context.save()

        if anterieures.isEmpty { return .premiere }
        if nouveauRecord { return .record }

        // Combien de parties passées font mieux que celle-ci
        let meilleures = anterieures.filter {
            result.gameType.lowerIsBetter ? $0.score < result.score : $0.score > result.score
        }.count
        return .rang(meilleures + 1, sur: anterieures.count + 1)
    }

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
