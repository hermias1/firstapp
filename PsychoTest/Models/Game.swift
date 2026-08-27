import Foundation
import SwiftUI

struct Game: Identifiable {
    var id: GameType { type }
    let type: GameType
    let name: String
    let description: String
    let icon: String
    let category: GameCategory
    let difficulty: Difficulty
    let isImplemented: Bool

    enum Difficulty: Int {
        case easy = 1
        case medium = 2
        case hard = 3
        case veryHard = 4
    }
}

enum GameCategory: String, CaseIterable {
    case cognitive = "Cognitif"
    case memory = "Mémoire"
    case spatial = "Spatial"
    case logic = "Logique"
    case language = "Langage"
    case multitask = "Multi-tâches"
}

enum GameType: String, CaseIterable {
    case pairImpair
    case m2Back
    case grillesCalculs
    case seriesLogiques
    case anglaisQCM
    case cultureAero
    case unMotSurDeux
    case formesEtCouleurs
    case boitesAMots
    case motsEnEtoile
    case calculMental
    case empilementsCubes
    case billes
    case formesGlissees
    case cubes2D3D
    case psychomoteur
    case airways
    case objets3D
}

extension Game {
    static let allGames: [Game] = [
        // FACILES - Implémentés
        Game(
            type: .pairImpair,
            name: "Pair ou Impair",
            description: "Alterne pairs et impairs",
            icon: "number.circle.fill",
            category: .cognitive,
            difficulty: .easy,
            isImplemented: true
        ),
        Game(
            type: .m2Back,
            name: "M2 Back",
            description: "Le chiffre d'il y a 2 coups",
            icon: "brain.head.profile",
            category: .memory,
            difficulty: .easy,
            isImplemented: true
        ),
        Game(
            type: .grillesCalculs,
            name: "Grilles de Calculs",
            description: "Repère les calculs faux",
            icon: "square.grid.3x3.fill",
            category: .logic,
            difficulty: .easy,
            isImplemented: true
        ),
        Game(
            type: .seriesLogiques,
            name: "Séries Logiques",
            description: "Complète la suite",
            icon: "list.number",
            category: .logic,
            difficulty: .easy,
            isImplemented: true
        ),
        Game(
            type: .anglaisQCM,
            name: "Anglais",
            description: "30 QCM en 7 min 30",
            icon: "textformat.abc",
            category: .language,
            difficulty: .easy,
            isImplemented: true
        ),
        Game(
            type: .cultureAero,
            name: "Culture Aéronautique",
            description: "QCM aviation, points négatifs",
            icon: "airplane",
            category: .language,
            difficulty: .easy,
            isImplemented: true
        ),

        // MOYENS - Implémentés
        Game(
            type: .unMotSurDeux,
            name: "Un Mot sur Deux",
            description: "Deux thèmes en alphabétique",
            icon: "textformat.alt",
            category: .cognitive,
            difficulty: .medium,
            isImplemented: true
        ),
        Game(
            type: .formesEtCouleurs,
            name: "Formes et Couleurs",
            description: "Forme et couleur, une touche",
            icon: "square.on.circle",
            category: .cognitive,
            difficulty: .medium,
            isImplemented: true
        ),
        Game(
            type: .boitesAMots,
            name: "Boîtes à Mots",
            description: "Range les mots par thème",
            icon: "tray.2.fill",
            category: .memory,
            difficulty: .medium,
            isImplemented: true
        ),
        Game(
            type: .motsEnEtoile,
            name: "Mots en Étoile",
            description: "6 mots liés par une lettre",
            icon: "star.fill",
            category: .logic,
            difficulty: .medium,
            isImplemented: true
        ),

        Game(
            type: .calculMental,
            name: "Calcul Mental",
            description: "Un maximum en 60 secondes",
            icon: "plusminus.circle.fill",
            category: .cognitive,
            difficulty: .medium,
            isImplemented: true
        ),

        // DIFFICILES - Spatial
        Game(
            type: .empilementsCubes,
            name: "Empilements",
            description: "Trouve la symétrie",
            icon: "cube.fill",
            category: .spatial,
            difficulty: .hard,
            isImplemented: true
        ),
        Game(
            type: .billes,
            name: "Billes",
            description: "Le nombre minimal de coups",
            icon: "circle.grid.2x1.fill",
            category: .spatial,
            difficulty: .hard,
            isImplemented: true
        ),
        Game(
            type: .formesGlissees,
            name: "Formes Glissées",
            description: "Superpose pour reproduire",
            icon: "square.on.square",
            category: .spatial,
            difficulty: .hard,
            isImplemented: true
        ),
        Game(
            type: .cubes2D3D,
            name: "Cubes 2D/3D",
            description: "Le cube du patron déplié",
            icon: "cube.transparent.fill",
            category: .spatial,
            difficulty: .hard,
            isImplemented: true
        ),

        // TRÈS DIFFICILES - Multi-tâches
        Game(
            type: .psychomoteur,
            name: "Psychomoteur",
            description: "Deux tâches à la fois",
            icon: "hand.tap.fill",
            category: .multitask,
            difficulty: .veryHard,
            isImplemented: true
        ),
        Game(
            type: .airways,
            name: "Airways",
            description: "Espace les arrivées",
            icon: "airplane.circle.fill",
            category: .multitask,
            difficulty: .veryHard,
            isImplemented: true
        ),
        Game(
            type: .objets3D,
            name: "Objets 3D",
            description: "La silhouette vue d'un angle",
            icon: "view.3d",
            category: .spatial,
            difficulty: .veryHard,
            isImplemented: true
        )
    ]

    /// Couleur de famille du test, dérivée de sa catégorie.
    var teinte: Color { category.teinte }

    static var implementedGames: [Game] {
        allGames.filter { $0.isImplemented }
    }

    static var comingSoonGames: [Game] {
        allGames.filter { !$0.isImplemented }
    }
}

// MARK: - Lecture des scores

enum ScoreUnit {
    case percent
    case points
    case seconds
}

extension GameType {
    /// Vrai pour les jeux mesurés en temps, où le plus petit score est le meilleur.
    var lowerIsBetter: Bool {
        switch self {
        case .pairImpair, .unMotSurDeux: return true
        default: return false
        }
    }

    var scoreUnit: ScoreUnit {
        switch self {
        case .pairImpair, .unMotSurDeux: return .seconds
        case .m2Back, .formesEtCouleurs, .boitesAMots: return .percent
        default: return .points
        }
    }

    /// Score mis en forme pour l'affichage, dans l'unité du jeu.
    func format(_ score: Double) -> String {
        switch scoreUnit {
        case .percent: return String(format: "%.0f %%", score)
        case .seconds: return String(format: "%.1f s", score)
        case .points: return String(format: "%.0f pts", score)
        }
    }
}

// MARK: - Dimensions évaluées

/// Les dimensions selon lesquelles la sélection restitue les résultats.
/// Un même test en évalue souvent plusieurs.
enum Dimension: String, CaseIterable, Identifiable {
    case attention = "Attention"
    case spatiale = "Spatiale"
    case numerique = "Numérique"
    case verbale = "Verbale"
    case intellectuelle = "Intellectuelle"
    case memorisation = "Mémorisation"
    case anglais = "Anglais"

    var id: String { rawValue }

    var icone: String {
        switch self {
        case .attention: return "eye"
        case .spatiale: return "cube"
        case .numerique: return "number"
        case .verbale: return "text.book.closed"
        case .intellectuelle: return "lightbulb"
        case .memorisation: return "brain"
        case .anglais: return "globe.europe.africa"
        }
    }
}

extension GameType {
    /// Rattachement des tests aux dimensions, d'après la classification
    /// utilisée par les organismes de préparation à la sélection.
    var dimensions: [Dimension] {
        switch self {
        case .pairImpair: return [.attention, .spatiale, .numerique]
        case .unMotSurDeux: return [.attention, .spatiale, .verbale]
        case .m2Back: return [.attention, .memorisation]
        case .formesEtCouleurs: return [.attention]
        case .grillesCalculs: return [.numerique]
        case .calculMental: return [.numerique]
        case .boitesAMots: return [.verbale]
        case .motsEnEtoile: return [.verbale]
        case .seriesLogiques: return [.intellectuelle]
        case .billes: return [.spatiale, .intellectuelle]
        case .formesGlissees: return [.spatiale, .intellectuelle]
        case .empilementsCubes, .cubes2D3D, .objets3D: return [.spatiale]
        case .anglaisQCM: return [.anglais]
        case .cultureAero: return []
        case .psychomoteur: return [.attention]
        case .airways: return [.attention, .intellectuelle]
        }
    }
}
