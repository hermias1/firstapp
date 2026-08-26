import SwiftUI

// MARK: - Rule Item
struct RuleItem: Identifiable {
    let id = UUID()
    let icon: String
    let text: String
}

// MARK: - Game Rules Button
struct GameRulesButton: View {
    let title: String
    let rules: [RuleItem]
    let accentColor: Color

    @State private var showingRules = false

    var body: some View {
        Button {
            showingRules = true
            HapticManager.light()
        } label: {
            Image(systemName: "info.circle")
                .font(.title3)
                .foregroundStyle(accentColor)
        }
        .sheet(isPresented: $showingRules) {
            RulesSheet(title: title, rules: rules, accentColor: accentColor)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Rules Sheet
struct RulesSheet: View {
    let title: String
    let rules: [RuleItem]
    let accentColor: Color
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(rules) { rule in
                    Label {
                        Text(rule.text)
                            .font(.subheadline)
                    } icon: {
                        Image(systemName: rule.icon)
                            .foregroundStyle(accentColor)
                            .frame(width: 24)
                    }
                }

                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("OK") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

// MARK: - Haptic Manager
@MainActor
enum HapticManager {
    static func light() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    static func medium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    static func heavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }

    static func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    static func error() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    static func warning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
}

#Preview {
    GameRulesButton(
        title: "Règles du jeu",
        rules: [
            RuleItem(icon: "number.circle", text: "Alterne entre PAIR et IMPAIR"),
            RuleItem(icon: "arrow.up", text: "Toujours en ordre croissant"),
            RuleItem(icon: "exclamationmark.triangle", text: "Erreur = recommencer")
        ],
        accentColor: .blue
    )
}
