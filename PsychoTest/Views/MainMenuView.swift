import SwiftUI
import SwiftData

struct MainMenuView: View {
    /// Une seule requête pour toutes les parties : le meilleur score de chaque
    /// jeu est ensuite calculé en mémoire.
    @Query private var sessions: [GameSession]

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
                                    GameCard(game: game, record: record(for: game.type))
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ProfilView()
                    } label: {
                        Label("Mon profil", systemImage: "chart.bar.doc.horizontal")
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }

    /// Meilleur score du jeu, ou nil s'il n'a jamais été joué.
    private func record(for type: GameType) -> String? {
        let scores = sessions.filter { $0.gameType == type.rawValue }.map(\.score)
        guard let meilleur = type.lowerIsBetter ? scores.min() : scores.max() else {
            return nil
        }
        return type.format(meilleur)
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
        case .calculMental: MentalCalculationView()
        case .billes: BillesView()
        case .formesGlissees: FormesGlisseesView()
        case .empilementsCubes: EmpilementsView()
        case .cubes2D3D: CubesPatronsView()
        case .objets3D: Objets3DView()
        case .airways: AirwaysView()
        case .psychomoteur:
            ComingSoonView(game: game)
        }
    }
}

#Preview {
    MainMenuView()
        .modelContainer(for: GameSession.self, inMemory: true)
}
