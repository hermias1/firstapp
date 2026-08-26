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
        // Routage par type : exhaustif et vérifié à la compilation, là où une
        // comparaison de noms cassait silencieusement au moindre renommage.
        switch game.type {
        case .pairImpair: PairImpairView()
        case .m2Back: M2BackView()
        case .grillesCalculs: GrillesCalculsView()
        case .seriesLogiques: SeriesLogiquesView()
        case .anglaisQCM: AnglaisQCMView()
        case .cultureAero: CultureAeroView()
        case .unMotSurDeux: UnMotSurDeuxView()
        case .formesEtCouleurs: FormesCouleursView()
        case .boitesAMots: BoitesAMotsView()
        case .motsEnEtoile: MotsEnEtoileView()
        case .empilementsCubes, .billes, .formesGlissees, .cubes2D3D,
             .psychomoteur, .airways, .objets3D:
            ComingSoonView(game: game)
        }
    }
}

#Preview {
    MainMenuView()
}
