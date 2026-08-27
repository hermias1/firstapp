import SwiftUI

/// Ce qui vaut une partie réussie, pour toute l'application.
///
/// Le seuil vivait en dur dans chaque écran de fin, et avait divergé : la
/// plupart des tests félicitaient à partir de 70 %, le psychomoteur à 60. Deux
/// tests ne peuvent pas dire au candidat des choses différentes de la même
/// performance.
enum Reussite {
    static let seuil: Double = 70

    static func atteinte(_ taux: Double) -> Bool { taux >= seuil }

    static func icone(_ taux: Double) -> String {
        atteinte(taux) ? "checkmark.circle.fill" : "xmark.circle.fill"
    }

    static func couleur(_ taux: Double) -> Color {
        atteinte(taux) ? Theme.vert : Theme.rouge
    }
}

/// En-tête commun aux écrans de fin de partie.
struct EnTeteDeFin: View {
    let taux: Double

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: Reussite.icone(taux))
                .font(.system(size: 66))
                .foregroundStyle(Reussite.couleur(taux))
            Text("Terminé !")
                .font(.ecran)
                .foregroundStyle(Theme.texteFort)
            Text(Reussite.atteinte(taux)
                 ? "Au-dessus du seuil de \(Int(Reussite.seuil)) %"
                 : "En dessous du seuil de \(Int(Reussite.seuil)) %")
                .font(.caption)
                .foregroundStyle(Theme.texteFaible)
        }
    }
}
