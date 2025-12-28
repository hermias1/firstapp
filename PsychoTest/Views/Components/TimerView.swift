import SwiftUI

struct TimerView: View {
    let timeRemaining: Int
    let totalTime: Int

    private var progress: Double {
        guard totalTime > 0 else { return 0 }
        return Double(timeRemaining) / Double(totalTime)
    }

    private var timerColor: Color {
        if progress > 0.5 {
            return .green
        } else if progress > 0.25 {
            return .orange
        } else {
            return .red
        }
    }

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "timer")
                .foregroundStyle(timerColor)

            Text("\(timeRemaining)s")
                .font(.title3.monospacedDigit())
                .fontWeight(.semibold)
                .foregroundStyle(timerColor)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(timerColor.opacity(0.15))
        .clipShape(Capsule())
    }
}

#Preview {
    VStack(spacing: 20) {
        TimerView(timeRemaining: 25, totalTime: 30)
        TimerView(timeRemaining: 10, totalTime: 30)
        TimerView(timeRemaining: 3, totalTime: 30)
    }
}
