import SwiftUI
import SwiftData

/// Profil du candidat par dimension évaluée.
///
/// La sélection restitue ses résultats par dimension (spatiale, verbale,
/// numérique…) et non test par test : cet écran donne la même lecture, et
/// montre surtout les dimensions encore jamais travaillées.
struct ProfilView: View {
    @Query private var sessions: [GameSession]

    /// Taux de réussite moyen d'une dimension, sur les jeux effectivement joués.
    private func reussite(_ dimension: Dimension) -> Double? {
        let concernes = GameType.allCases.filter { $0.dimensions.contains(dimension) }
        var taux: [Double] = []

        for type in concernes {
            let parties = sessions.filter { $0.gameType == type.rawValue }
            guard !parties.isEmpty else { continue }
            // Les cinq dernières parties du jeu, pour refléter le niveau actuel
            let recentes = parties.sorted { $0.date > $1.date }.prefix(5)
            let scores = recentes.compactMap { partie -> Double? in
                guard partie.totalItems > 0 else { return nil }
                return Double(partie.correctAnswers) / Double(partie.totalItems) * 100
            }
            if !scores.isEmpty {
                taux.append(scores.reduce(0, +) / Double(scores.count))
            }
        }
        guard !taux.isEmpty else { return nil }
        return taux.reduce(0, +) / Double(taux.count)
    }

    private func jeuxJoues(_ dimension: Dimension) -> (joues: Int, total: Int) {
        let concernes = GameType.allCases.filter {
            $0.dimensions.contains(dimension) && estJouable($0)
        }
        let joues = concernes.filter { type in
            sessions.contains { $0.gameType == type.rawValue }
        }
        return (joues.count, concernes.count)
    }

    private func estJouable(_ type: GameType) -> Bool {
        Game.allGames.first { $0.type == type }?.isImplemented ?? false
    }

    var body: some View {
        List {
            Section {
                ForEach(Dimension.allCases) { dimension in
                    ligne(dimension)
                }
            } footer: {
                Text("Le taux est calculé sur tes cinq dernières parties de chaque test.")
            }
        }
        .navigationTitle("Mon profil")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func ligne(_ dimension: Dimension) -> some View {
        let taux = reussite(dimension)
        let couverture = jeuxJoues(dimension)

        return VStack(alignment: .leading, spacing: 8) {
            HStack {
                Label(dimension.rawValue, systemImage: dimension.icone)
                    .font(.subheadline.weight(.medium))
                Spacer()
                if let taux {
                    Text(String(format: "%.0f %%", taux))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(couleur(taux))
                } else {
                    Text("jamais travaillée")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            ProgressView(value: (taux ?? 0) / 100)
                .tint(taux.map(couleur) ?? .gray)

            Text("\(couverture.joues)/\(couverture.total) test\(couverture.total > 1 ? "s" : "") travaillé\(couverture.joues > 1 ? "s" : "")")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }

    private func couleur(_ taux: Double) -> Color {
        switch taux {
        case ..<50: return .red
        case ..<75: return .orange
        default: return .green
        }
    }
}

#Preview {
    NavigationStack {
        ProfilView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
