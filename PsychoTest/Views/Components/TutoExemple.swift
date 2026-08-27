import SwiftUI

/// Un exemple concret sur l'écran de départ d'un jeu.
///
/// Une consigne comme « place 6 mots sur une étoile selon leurs lettres
/// communes » ne se comprend pas en la lisant : elle se comprend en voyant un
/// cas résolu. Ce bloc affiche donc une situation réelle du jeu, avec sa
/// réponse, avant la première partie.
struct TutoExemple<Contenu: View>: View {
    let legende: String
    @ViewBuilder var contenu: Contenu

    var body: some View {
        VStack(spacing: 10) {
            Text("EXEMPLE")
                .font(.etiquette)
                .tracking(1.4)
                .foregroundStyle(Theme.texteFaible)

            contenu

            Text(legende)
                .font(.caption)
                .foregroundStyle(Theme.texteFaible)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: Theme.rayon).fill(Theme.surface)
        )
        .overlay(
            RoundedRectangle(cornerRadius: Theme.rayon)
                .strokeBorder(Theme.filet, lineWidth: 1)
        )
    }
}

/// Liste de règles compacte, en remplacement des `Label` empilés.
struct ReglesCompactes: View {
    let regles: [String]
    let teinte: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            ForEach(Array(regles.enumerated()), id: \.offset) { index, regle in
                HStack(alignment: .firstTextBaseline, spacing: 9) {
                    Text("\(index + 1)")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundStyle(teinte)
                        .frame(width: 17, height: 17)
                        .background(Circle().fill(teinte.opacity(0.14)))
                    Text(regle)
                        .font(.system(size: 14))
                        .foregroundStyle(Theme.texteFort)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                }
            }
        }
    }
}

/// Un mot dont la première et la dernière lettre sont mises en évidence :
/// ce sont elles qui font la liaison dans Mots en Étoile.
struct MotAvecLiaisons: View {
    let mot: String
    var teinte: Color = Theme.accentProfond

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(mot.enumerated()), id: \.offset) { index, lettre in
                let extremite = index == 0 || index == mot.count - 1
                Text(String(lettre))
                    .font(.system(size: 13, weight: extremite ? .heavy : .regular,
                                  design: .monospaced))
                    .foregroundStyle(extremite ? teinte : Theme.texteFaible)
            }
        }
    }
}
