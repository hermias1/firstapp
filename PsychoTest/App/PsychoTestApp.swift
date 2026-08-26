import SwiftUI
import SwiftData

@main
struct PsychoTestApp: App {
    var body: some Scene {
        WindowGroup {
            MainMenuView()
        }
        .modelContainer(for: GameSession.self)
    }
}
