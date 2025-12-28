import SwiftUI

struct ScoreView: View {
    let score: Int
    let correct: Int
    let total: Int

    private var accuracy: Double {
        guard total > 0 else { return 0 }
        return Double(correct) / Double(total) * 100
    }

    var body: some View {
        HStack(spacing: 24) {
            VStack(spacing: 4) {
                Text("\(score)")
                    .font(.title.monospacedDigit())
                    .fontWeight(.bold)
                Text("Points")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Divider()
                .frame(height: 40)

            VStack(spacing: 4) {
                Text("\(correct)/\(total)")
                    .font(.title2.monospacedDigit())
                    .fontWeight(.semibold)
                Text("Correct")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Divider()
                .frame(height: 40)

            VStack(spacing: 4) {
                Text(String(format: "%.0f%%", accuracy))
                    .font(.title2.monospacedDigit())
                    .fontWeight(.semibold)
                    .foregroundStyle(accuracy >= 80 ? .green : accuracy >= 50 ? .orange : .red)
                Text("Précision")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ScoreView(score: 150, correct: 8, total: 10)
        .padding()
        .background(Color(.systemGroupedBackground))
}
