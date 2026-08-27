import SwiftUI

/// Ce qu'affiche une carte à propos d'un test déjà travaillé.
enum EtatDeJeu: Equatable {
    case jamaisJoue
    case record(String)
}

struct GameCard: View {
    let game: Game
    var isDisabled: Bool = false
    var etat: EtatDeJeu = .jamaisJoue

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Image(systemName: game.icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(isDisabled ? Theme.texteFaible : game.teinte)
                    .frame(width: 30, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 9)
                            .fill(game.teinte.opacity(isDisabled ? 0.06 : 0.12))
                    )
                Spacer(minLength: 4)
                Text(game.category.rawValue.uppercased())
                    .font(.etiquette)
                    .tracking(1.0)
                    .foregroundStyle(Theme.texteFaible)
                    .lineLimit(1)
            }

            Text(game.name)
                .font(.carte)
                .foregroundStyle(isDisabled ? Theme.texteFaible : Theme.texteFort)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Text(game.description)
                .font(.system(size: 11))
                .foregroundStyle(Theme.texteFaible)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Spacer(minLength: 0)

            HStack(spacing: 6) {
                // Difficulté en barres plutôt qu'en pastilles de 6 points,
                // illisibles à cette taille.
                HStack(spacing: 3) {
                    ForEach(0..<4, id: \.self) { index in
                        Capsule()
                            .fill(index < game.difficulty.rawValue
                                  ? game.teinte : Theme.filet)
                            .frame(width: 10, height: 3)
                    }
                }
                Spacer(minLength: 0)
                switch etat {
                case .jamaisJoue:
                    // Un appel à l'action plutôt qu'un vide
                    Text("À TRAVAILLER")
                        .font(.etiquette)
                        .tracking(0.6)
                        .minimumScaleFactor(0.8)
                        .foregroundStyle(Theme.texteFaible)
                        .lineLimit(1)
                case .record(let valeur):
                    Label(valeur, systemImage: "trophy.fill")
                        .font(.mesurePetite)
                        .foregroundStyle(Theme.ambre)
                        .lineLimit(1)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        // minHeight et non height : la carte doit pouvoir grandir avec le
        // réglage de taille de texte de l'utilisateur.
        .frame(minHeight: 138, alignment: .top)
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: Theme.rayon)
                .fill(Theme.surface)
        )
        .overlay(
            // Un filet, pas une ombre : l'ombre noire disparaissait sur fond
            // sombre, où la carte devenait invisible.
            RoundedRectangle(cornerRadius: Theme.rayon)
                .strokeBorder(Theme.filet, lineWidth: 1)
        )
        .opacity(isDisabled ? 0.6 : 1)
    }
}

#Preview {
    HStack(spacing: 12) {
        GameCard(game: Game.allGames[0], etat: .record("12,4 s"))
        GameCard(game: Game.allGames[10])
    }
    .padding()
    .background(Theme.fond)
}
