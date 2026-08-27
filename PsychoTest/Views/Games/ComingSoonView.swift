import SwiftUI

struct ComingSoonView: View {
    let game: Game

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: game.icon)
                .font(.system(size: 80))
                .foregroundStyle(game.teinte)

            Text(game.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Bientôt disponible")
                .font(.title2)
                .foregroundStyle(.secondary)

            Text(game.description)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ComingSoonView(game: Game.allGames.last!)
    }
}
