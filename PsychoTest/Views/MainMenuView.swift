import SwiftUI

struct MainMenuView: View {
    let implementedGames = Game.implementedGames
    let comingSoonGames = Game.comingSoonGames

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Tests disponibles
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Tests disponibles")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding(.horizontal)

                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            ForEach(implementedGames) { game in
                                NavigationLink(destination: destinationView(for: game)) {
                                    GameCard(game: game)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Tests à venir
                    if !comingSoonGames.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Prochainement")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                                .padding(.horizontal)

                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 12) {
                                ForEach(comingSoonGames) { game in
                                    GameCard(game: game, isDisabled: true)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("PSY0 Training")
            .background(Color(.systemGroupedBackground))
        }
    }

    @ViewBuilder
    private func destinationView(for game: Game) -> some View {
        switch game.name {
        case "Pair ou Impair":
            PairImpairView()
        case "M2 Back":
            M2BackView()
        case "Grilles de Calculs":
            GrillesCalculsView()
        case "Séries Logiques":
            SeriesLogiquesView()
        case "Anglais":
            AnglaisQCMView()
        case "Culture Aéronautique":
            CultureAeroView()
        case "Un Mot sur Deux":
            UnMotSurDeuxView()
        case "Formes et Couleurs":
            FormesCouleursView()
        case "Boîtes à Mots":
            BoitesAMotsView()
        case "Mots en Étoile":
            MotsEnEtoileView()
        default:
            ComingSoonView(game: game)
        }
    }
}

#Preview {
    MainMenuView()
}
