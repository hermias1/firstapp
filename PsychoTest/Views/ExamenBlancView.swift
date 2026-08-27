import SwiftUI
import SwiftData

/// Parcours complet dans l'ordre réel de l'épreuve.
///
/// S'entraîner test par test ne dit pas si l'on tiendra la distance : au PSY0
/// les épreuves s'enchaînent sans pause pendant environ trois heures, et les
/// candidats citent la fatigue et la gestion du temps parmi leurs principales
/// difficultés. Ce parcours reprend l'ordre observé lors des sessions
/// précédentes et mesure le temps total.
struct ExamenBlancView: View {
    @Query private var sessions: [GameSession]
    @AppStorage("examen.debut") private var debutBrut: Double = 0

    /// L'ordre relevé dans les retours de candidats.
    static let ordre: [GameType] = [
        .nidAbeille, .formesGlissees, .pairImpair, .m2Back, .formesEtCouleurs,
        .airways, .objets3D, .seriesLogiques, .cubes2D3D,
        .grillesCalculs, .boitesAMots, .psychomoteur, .cultureAero, .anglaisQCM
    ]

    private var debut: Date? {
        debutBrut > 0 ? Date(timeIntervalSince1970: debutBrut) : nil
    }

    /// Les parties jouées depuis le lancement du parcours.
    private func partie(pour type: GameType) -> GameSession? {
        guard let debut else { return nil }
        return sessions
            .filter { $0.gameType == type.rawValue && $0.date >= debut }
            .max { $0.date < $1.date }
    }

    private var faites: Int {
        Self.ordre.filter { partie(pour: $0) != nil }.count
    }

    private var terminé: Bool { faites == Self.ordre.count }

    private var dureeTotale: TimeInterval? {
        guard let debut,
              let derniere = Self.ordre.compactMap({ partie(pour: $0)?.date }).max()
        else { return nil }
        return derniere.timeIntervalSince(debut)
    }

    var body: some View {
        List {
            if debut == nil {
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Enchaîne les \(Self.ordre.count) épreuves sans pause, dans l'ordre de la vraie session.")
                            .font(.system(size: 15))
                        Text("Le chronomètre tourne du début à la fin. Rien ne t'oblige à tout faire d'un coup, mais c'est l'intérêt de l'exercice.")
                            .font(.caption)
                            .foregroundStyle(Theme.texteFaible)
                        Button {
                            debutBrut = Date().timeIntervalSince1970
                        } label: {
                            Text("Lancer le parcours")
                                .font(.carte)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(Theme.accent, in: RoundedRectangle(cornerRadius: 10))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 4)
                }
            } else {
                Section {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("AVANCEMENT").font(.etiquette).tracking(1.2)
                                .foregroundStyle(Theme.texteFaible)
                            Text("\(faites)/\(Self.ordre.count)")
                                .font(.mesure)
                                .foregroundStyle(Theme.texteFort)
                        }
                        Spacer()
                        if let duree = dureeTotale {
                            VStack(alignment: .trailing, spacing: 2) {
                                Text("TEMPS ÉCOULÉ").font(.etiquette).tracking(1.2)
                                    .foregroundStyle(Theme.texteFaible)
                                Text(dureeLisible(duree))
                                    .font(.mesure)
                                    .foregroundStyle(Theme.texteFort)
                            }
                        }
                    }
                    ProgressView(value: Double(faites), total: Double(Self.ordre.count))
                        .tint(terminé ? Theme.vert : Theme.accent)
                }
            }

            Section("Les épreuves, dans l'ordre") {
                ForEach(Array(Self.ordre.enumerated()), id: \.offset) { index, type in
                    ligne(index: index, type: type)
                }
            }

            if debut != nil {
                Section {
                    Button("Réinitialiser le parcours", role: .destructive) {
                        debutBrut = 0
                    }
                }
            }
        }
        .navigationTitle("Examen blanc")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func ligne(index: Int, type: GameType) -> some View {
        let jeu = Game.allGames.first { $0.type == type }
        let partie = partie(pour: type)
        let suivante = debut != nil && partie == nil
            && Self.ordre.prefix(index).allSatisfy { self.partie(pour: $0) != nil }

        HStack(spacing: 10) {
            Text("\(index + 1)")
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundStyle(partie != nil ? .white : Theme.texteFaible)
                .frame(width: 22, height: 22)
                .background(Circle().fill(partie != nil ? Theme.vert : Theme.filet))

            VStack(alignment: .leading, spacing: 1) {
                Text(jeu?.name ?? type.rawValue)
                    .font(.system(size: 15, weight: suivante ? .semibold : .regular))
                    .foregroundStyle(Theme.texteFort)
                if suivante {
                    Text("à faire maintenant")
                        .font(.caption2)
                        .foregroundStyle(Theme.accent)
                }
            }

            Spacer()

            if let partie {
                Text(type.format(partie.score))
                    .font(.mesurePetite)
                    .foregroundStyle(Theme.texteFaible)
            }
        }
        .padding(.vertical, 2)
    }

    private func dureeLisible(_ duree: TimeInterval) -> String {
        let minutes = Int(duree) / 60
        return minutes >= 60
            ? String(format: "%dh%02d", minutes / 60, minutes % 60)
            : "\(minutes) min"
    }
}

#Preview {
    NavigationStack {
        ExamenBlancView()
    }
    .modelContainer(for: GameSession.self, inMemory: true)
}
