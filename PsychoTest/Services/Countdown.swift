import Foundation

/// Compte à rebours ancré sur une date de fin.
///
/// Les boucles qui décrémentaient un compteur à chaque `Task.sleep` avaient
/// deux défauts : elles dérivaient (chaque tour coûte un peu plus que
/// l'intervalle demandé), et surtout le système suspend `Task.sleep` quand
/// l'app passe en arrière-plan. Il suffisait donc de sortir de l'app pour
/// figer le chrono et réfléchir sans limite.
///
/// En calculant le temps restant à partir d'une date, le temps écoulé hors de
/// l'app compte comme le reste.
enum Countdown {
    @MainActor
    static func start(seconds: TimeInterval,
                      tick: @escaping @MainActor (TimeInterval) -> Void,
                      onFinish: @escaping @MainActor () -> Void) -> Task<Void, Never> {
        let fin = Date().addingTimeInterval(seconds)
        return Task { @MainActor in
            while !Task.isCancelled {
                let restant = fin.timeIntervalSinceNow
                guard restant > 0 else {
                    tick(0)
                    if !Task.isCancelled { onFinish() }
                    return
                }
                tick(restant)
                try? await Task.sleep(for: .milliseconds(100))
            }
        }
    }
}
