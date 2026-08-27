import SwiftUI
import SwiftData
import Charts

/// Progression sur un jeu : record, nombre de parties et évolution récente.
struct GameStatsView: View {
    let type: GameType

    @Environment(\.modelContext) private var context
    @Query private var toutesLesParties: [GameSession]
    @State private var demandeEffacement = false

    private var jeu: Game? {
        Game.allGames.first { $0.type == type }
    }

    /// Les parties de ce jeu, de la plus récente à la plus ancienne.
    private var parties: [GameSession] {
        toutesLesParties
            .filter { $0.gameType == type.rawValue }
            .sorted { $0.date > $1.date }
    }

    private var record: Double? {
        let scores = parties.map(\.score)
        return type.lowerIsBetter ? scores.min() : scores.max()
    }

    var body: some View {
        Group {
            if parties.isEmpty {
                ContentUnavailableView(
                    "Aucune partie",
                    systemImage: "chart.line.uptrend.xyaxis",
                    description: Text("Joue une première partie pour voir ta progression ici.")
                )
            } else {
                List {
                    Section {
                        HStack {
                            statistique("Record", record.map(type.format) ?? "—")
                            Divider()
                            statistique("Parties", "\(parties.count)")
                        }
                        .frame(maxWidth: .infinity)
                    }

                    Section("Évolution") {
                        graphique
                            .frame(height: 200)
                            .padding(.vertical, 8)
                    }

                    Section("Dernières parties") {
                        ForEach(parties.prefix(20)) { partie in
                            HStack {
                                Text(partie.date, format: .dateTime.day().month().hour().minute())
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text(type.format(partie.score))
                                    .font(.subheadline.weight(.medium))
                            }
                        }
                    }

                    Section {
                        Button("Effacer l'historique", role: .destructive) {
                            demandeEffacement = true
                        }
                    }
                }
            }
        }
        .navigationTitle(jeu?.name ?? "Progression")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Effacer l'historique ?", isPresented: $demandeEffacement) {
            Button("Annuler", role: .cancel) {}
            Button("Effacer", role: .destructive) {
                ScoreStore(context: context).reset(type)
            }
        } message: {
            Text("Toutes les parties enregistrées pour ce jeu seront supprimées.")
        }
    }

    /// Les 20 dernières parties, de la plus ancienne à la plus récente.
    private var graphique: some View {
        let recentes = Array(parties.prefix(20).reversed())
        return Chart(Array(recentes.enumerated()), id: \.offset) { index, partie in
            LineMark(x: .value("Partie", index + 1),
                     y: .value("Score", partie.score))
                .foregroundStyle(jeu?.teinte ?? Theme.accent)
            PointMark(x: .value("Partie", index + 1),
                      y: .value("Score", partie.score))
                .foregroundStyle(jeu?.teinte ?? Theme.accent)
        }
        .chartXAxis(.hidden)
    }

    private func statistique(_ titre: String, _ valeur: String) -> some View {
        VStack(spacing: 4) {
            Text(valeur)
                .font(.title2.weight(.bold))
            Text(titre)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        GameStatsView(type: .m2Back)
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
