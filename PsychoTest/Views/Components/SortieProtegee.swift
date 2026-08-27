import SwiftUI

/// Empêche de perdre une partie d'un retour malencontreux.
///
/// Le bouton « retour » de la barre de navigation déclenche `onDisappear`,
/// donc `stopGame()` : une partie chronométrée en cours disparaissait sans un
/// mot et sans rien enregistrer. Un geste de balayage depuis le bord de
/// l'écran suffisait, ce qui arrive souvent sur un téléphone tenu à une main.
private struct SortieProtegeeModifier: ViewModifier {
    let enPartie: Bool
    let abandonner: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var demandeConfirmation = false

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(enPartie)
            .toolbar {
                if enPartie {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            demandeConfirmation = true
                        } label: {
                            Label("Quitter", systemImage: "xmark")
                                .font(.system(size: 15, weight: .semibold))
                        }
                    }
                }
            }
            .alert("Abandonner la partie ?", isPresented: $demandeConfirmation) {
                Button("Continuer", role: .cancel) {}
                Button("Abandonner", role: .destructive) {
                    abandonner()
                    dismiss()
                }
            } message: {
                Text("Ta progression sur cette partie sera perdue et rien ne sera enregistré.")
            }
    }
}

extension View {
    /// À appliquer sur l'écran d'un jeu : protège la partie en cours d'une
    /// sortie accidentelle.
    func sortieProtegee(enPartie: Bool, abandonner: @escaping () -> Void) -> some View {
        modifier(SortieProtegeeModifier(enPartie: enPartie, abandonner: abandonner))
    }
}
