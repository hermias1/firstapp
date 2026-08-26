import SwiftUI

struct GameCard: View {
    let game: Game
    var isDisabled: Bool = false
    /// Meilleur score déjà réalisé, mis en forme dans l'unité du jeu.
    var record: String? = nil

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: game.icon)
                .font(.system(size: 36))
                .foregroundStyle(isDisabled ? .gray : game.color)

            VStack(spacing: 4) {
                Text(game.name)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(isDisabled ? .secondary : .primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)

                Text(game.description)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }

            if let record {
                Label(record, systemImage: "trophy.fill")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(game.color)
            }

            // Indicateur de difficulté
            HStack(spacing: 2) {
                ForEach(0..<4) { index in
                    Circle()
                        .fill(index < game.difficulty.rawValue ? game.color.opacity(isDisabled ? 0.3 : 1) : Color.gray.opacity(0.3))
                        .frame(width: 6, height: 6)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 160)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(isDisabled ? 0.05 : 0.1), radius: 5, y: 2)
        .opacity(isDisabled ? 0.6 : 1)
    }
}

#Preview {
    HStack {
        GameCard(game: Game.allGames[0], record: "12,4 s")
        GameCard(game: Game.allGames[0], isDisabled: true)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
