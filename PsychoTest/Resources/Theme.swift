import SwiftUI

/// Palette et typographie de l'application.
///
/// Une seule source pour les couleurs et les tailles : les vues n'écrivent plus
/// de valeur littérale. Auparavant chaque jeu portait une teinte système brute
/// (13 des 14 couleurs d'iOS, déjà recyclées entre plusieurs jeux), ce qui ne
/// codait aucune information et donnait une grille bariolée ; et les fonds
/// venaient de `systemBackground` / `systemGroupedBackground`, qui valent tous
/// deux le même noir en thème sombre — les cartes y étaient invisibles.
enum Theme {
    static let nuit = Color(clair: 0x0B1B2B, sombre: 0x0B1B2B)
    static let fond = Color(clair: 0xF2F5F9, sombre: 0x070E18)
    static let surface = Color(clair: 0xFFFFFF, sombre: 0x121F33)
    /// Toutes les séparations : bordures, rails, graticules. Remplace les ombres.
    static let filet = Color(clair: 0xDDE3EC, sombre: 0x23374F)
    static let texteFort = Color(clair: 0x0B1B2B, sombre: 0xE8F0F9)
    static let texteFaible = Color(clair: 0x5B6B80, sombre: 0x93A5BC)

    static let accent = Color(clair: 0x0B5FD0, sombre: 0x4E9BFF)
    static let accentProfond = Color(clair: 0x0E5C86, sombre: 0x3FA6CF)
    static let accentViolet = Color(clair: 0x4C4FBF, sombre: 0x8B8DEB)

    /// Les trois couleurs d'état. Elles disent quelque chose : elles ne servent
    /// jamais à décorer ni à identifier un jeu.
    static let ambre = Color(clair: 0xE8A020, sombre: 0xFFC24D)
    static let vert = Color(clair: 0x1B9C6B, sombre: 0x35C48F)
    static let rouge = Color(clair: 0xD0453B, sombre: 0xF2685E)

    static let rayon: CGFloat = 14
}

extension Color {
    /// Couleur qui suit le thème clair ou sombre de l'appareil.
    init(clair: UInt32, sombre: UInt32) {
        self.init(uiColor: UIColor { trait in
            UIColor(hexadecimal: trait.userInterfaceStyle == .dark ? sombre : clair)
        })
    }
}

extension UIColor {
    convenience init(hexadecimal: UInt32) {
        self.init(red: CGFloat((hexadecimal >> 16) & 0xFF) / 255,
                  green: CGFloat((hexadecimal >> 8) & 0xFF) / 255,
                  blue: CGFloat(hexadecimal & 0xFF) / 255,
                  alpha: 1)
    }
}

extension Font {
    /// Titre d'écran.
    static let ecran = Font.system(size: 26, weight: .heavy)
    /// Titre de section.
    static let bloc = Font.system(size: 19, weight: .bold)
    /// Nom de test, libellé de bouton.
    static let carte = Font.system(size: 15, weight: .semibold)
    /// Étiquette en capitales, à accompagner de `.tracking(1.2)`.
    static let etiquette = Font.system(size: 10, weight: .bold)
    /// Toute valeur mesurée : chrono, score, précision, record.
    ///
    /// En chasse fixe, sinon les chiffres changent de largeur pendant le
    /// décompte — précisément à l'écran le plus tendu de l'application.
    static let mesure = Font.system(size: 28, weight: .bold, design: .monospaced)
    static let mesurePetite = Font.system(size: 13, weight: .semibold, design: .monospaced)
}

extension GameCategory {
    /// La couleur regroupe les tests par famille : elle n'en identifie aucun.
    /// L'œil ne distingue pas dix-huit teintes, il distingue six familles.
    var teinte: Color {
        switch self {
        case .cognitive, .multitask: return Theme.accent
        case .spatial, .logic: return Theme.accentProfond
        case .memory, .language: return Theme.accentViolet
        }
    }
}
