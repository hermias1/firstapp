import Foundation
import SwiftUI

struct Game: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String
    let color: Color
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
            name: "Pair ou Impair",
            description: "Alterne entre pairs et impairs en ordre croissant",
            icon: "number.circle.fill",
            color: .blue,
            category: .cognitive,
            difficulty: .easy,
            isImplemented: true
        ),
        Game(
            name: "M2 Back",
            description: "Le chiffre est-il identique à celui d'il y a 2 coups ?",
            icon: "brain.head.profile",
            color: .purple,
            category: .memory,
            difficulty: .easy,
            isImplemented: true
        ),
        Game(
            name: "Grilles de Calculs",
            description: "Trouve les calculs faux dans une grille de 9",
            icon: "square.grid.3x3.fill",
            color: .orange,
            category: .logic,
            difficulty: .easy,
            isImplemented: true
        ),
        Game(
            name: "Séries Logiques",
            description: "Complète la suite avec le bon élément",
            icon: "list.number",
            color: .green,
            category: .logic,
            difficulty: .easy,
            isImplemented: true
        ),
        Game(
            name: "Anglais",
            description: "30 QCM grammaire et vocabulaire en 7min30",
            icon: "textformat.abc",
            color: .red,
            category: .language,
            difficulty: .easy,
            isImplemented: true
        ),
        Game(
            name: "Culture Aéronautique",
            description: "QCM sur l'aviation (barème à points négatifs)",
            icon: "airplane",
            color: .cyan,
            category: .language,
            difficulty: .easy,
            isImplemented: true
        ),

        // MOYENS - Implémentés
        Game(
            name: "Un Mot sur Deux",
            description: "Alterne 2 thématiques en ordre alphabétique",
            icon: "textformat.alt",
            color: .indigo,
            category: .cognitive,
            difficulty: .medium,
            isImplemented: true
        ),
        Game(
            name: "Formes et Couleurs",
            description: "Associe forme/couleur/remplissage à une touche",
            icon: "square.on.circle",
            color: .pink,
            category: .cognitive,
            difficulty: .medium,
            isImplemented: true
        ),
        Game(
            name: "Boîtes à Mots",
            description: "Range les mots dans la bonne boîte thématique",
            icon: "tray.2.fill",
            color: .brown,
            category: .memory,
            difficulty: .medium,
            isImplemented: true
        ),
        Game(
            name: "Mots en Étoile",
            description: "Place 6 mots sur une étoile selon leurs lettres communes",
            icon: "star.fill",
            color: .yellow,
            category: .logic,
            difficulty: .medium,
            isImplemented: true
        ),

        // DIFFICILES - Spatial
        Game(
            name: "Empilements",
            description: "Identifie le cube qui a subi une symétrie",
            icon: "cube.fill",
            color: .mint,
            category: .spatial,
            difficulty: .hard,
            isImplemented: false
        ),
        Game(
            name: "Billes",
            description: "Trouve le nombre min de déplacements dans les tubes",
            icon: "circle.grid.2x1.fill",
            color: .teal,
            category: .spatial,
            difficulty: .hard,
            isImplemented: false
        ),
        Game(
            name: "Formes Glissées",
            description: "Glisse des formes pour reproduire une figure cible",
            icon: "square.on.square",
            color: .gray,
            category: .spatial,
            difficulty: .hard,
            isImplemented: false
        ),
        Game(
            name: "Cubes 2D/3D",
            description: "Reconstitue un patron de cube incomplet",
            icon: "cube.transparent.fill",
            color: .purple,
            category: .spatial,
            difficulty: .hard,
            isImplemented: false
        ),

        // TRÈS DIFFICILES - Multi-tâches
        Game(
            name: "Psychomoteur",
            description: "3 tâches en parallèle pendant 5 minutes",
            icon: "hand.tap.fill",
            color: .red,
            category: .multitask,
            difficulty: .veryHard,
            isImplemented: false
        ),
        Game(
            name: "Airways",
            description: "Déroute les avions avec un minimum de manœuvres",
            icon: "airplane.circle.fill",
            color: .blue,
            category: .multitask,
            difficulty: .veryHard,
            isImplemented: false
        ),
        Game(
            name: "Objets 3D",
            description: "Identifie le point de vue d'une scène 3D",
            icon: "view.3d",
            color: .green,
            category: .spatial,
            difficulty: .veryHard,
            isImplemented: false
        )
    ]

    static var implementedGames: [Game] {
        allGames.filter { $0.isImplemented }
    }

    static var comingSoonGames: [Game] {
        allGames.filter { !$0.isImplemented }
    }
}
