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
                                    GameCard(game: game, etat: etat(for: game.type))
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
                        ExamenBlancView()
                    } label: {
                        Label("Examen blanc", systemImage: "list.number")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ProfilView()
                    } label: {
                        Label("Mon profil", systemImage: "chart.bar.doc.horizontal")
                    }
                }
            }
            .background(Theme.fond)
        }
    }

    /// Ce que la carte doit annoncer : un record, ou une invitation à s'y mettre.
    private func etat(for type: GameType) -> EtatDeJeu {
        let scores = sessions.filter { $0.gameType == type.rawValue }.map(\.score)
        guard let meilleur = type.lowerIsBetter ? scores.min() : scores.max() else {
            return .jamaisJoue
        }
        return .record(type.format(meilleur))
    }

    private func destinationView(for game: Game) -> some View {
        JeuDestination(type: game.type)
    }
}

#Preview {
    MainMenuView()
        .modelContainer(for: GameSession.self, inMemory: true)
}
