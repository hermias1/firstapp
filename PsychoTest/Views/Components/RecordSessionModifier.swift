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
    @State private var afficheRecord = false

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if afficheRecord {
                    Label("Nouveau record !", systemImage: "trophy.fill")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(.orange))
                        .padding(.top, 8)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .onChange(of: termine) { _, estTermine in
                guard estTermine else {
                    // Nouvelle partie : on réarme la garde
                    dejaEnregistre = false
                    afficheRecord = false
                    return
                }
                guard !dejaEnregistre, let resultat = resultat() else { return }
                dejaEnregistre = true
                let record = ScoreStore(context: context).record(resultat)
                withAnimation(.spring) { afficheRecord = record }
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
