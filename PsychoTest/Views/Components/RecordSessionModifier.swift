import SwiftUI
import SwiftData

/// Enregistre une partie terminée et signale un éventuel nouveau record.
///
/// La garde `dejaEnregistre` est essentielle : `isGameOver` peut rebasculer et
/// la vue peut réapparaître dans la pile de navigation. Sans elle, une même
/// partie serait comptée deux fois et fausserait le record.
private struct RecordSessionModifier: ViewModifier {
    let termine: Bool
    let resultat: () -> GameResult?

    @Environment(\.modelContext) private var context
    @State private var dejaEnregistre = false
    @State private var situation: ScoreStore.Situation?

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if let situation, let texte = libelle(situation) {
                    Label(texte, systemImage: situation == .record ? "trophy.fill" : "chart.bar.fill")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 9)
                        .background(Capsule().fill(situation == .record ? Theme.ambre : Theme.accent))
                        .padding(.top, 8)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .onChange(of: termine) { _, estTermine in
                guard estTermine else {
                    // Nouvelle partie : on réarme la garde
                    dejaEnregistre = false
                    situation = nil
                    return
                }
                guard !dejaEnregistre, let resultat = resultat() else { return }
                dejaEnregistre = true
                let resultatSituation = ScoreStore(context: context).enregistrer(resultat)
                withAnimation(.spring) { situation = resultatSituation }
            }
    }
}

private extension RecordSessionModifier {
    /// La première partie ne se compare à rien : mieux vaut ne rien annoncer.
    func libelle(_ situation: ScoreStore.Situation) -> String? {
        switch situation {
        case .premiere: return nil
        case .record: return "Nouveau record !"
        case .rang(let rang, let total):
            // Un score égal au record n'est pas un record, mais reste 1re
            return "\(rang)\(rang == 1 ? "re" : "e") meilleure sur \(total)"
        }
    }
}

extension View {
    /// À appliquer sur l'écran d'un jeu : enregistre la partie dès qu'elle
    /// est terminée, une seule fois.
    func recordSession(when termine: Bool,
                       resultat: @escaping () -> GameResult?) -> some View {
        modifier(RecordSessionModifier(termine: termine, resultat: resultat))
    }
}
