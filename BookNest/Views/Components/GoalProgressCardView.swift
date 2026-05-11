import SwiftUI

// Displays one goal with its title, type, percent complete, and raw count.
struct GoalProgressCardView: View {
    let goal: ReadingGoal
    var currentCountOverride: Int?

    private var currentCount: Int {
        currentCountOverride ?? goal.currentCount
    }

    private var progress: Double {
        guard goal.targetCount > 0 else { return 0 }
        return min(Double(currentCount) / Double(goal.targetCount), 1.0)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Header keeps the descriptive goal text separate from the numeric progress.
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(goal.title)
                        .font(.headline)

                    Text(goal.goalType.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("\(Int(progress * 100))%")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.brown)
            }

            // Progress is capped so the UI stays stable after a goal is exceeded.
            ProgressView(value: progress)
                .tint(.brown)

            Text("\(currentCount) of \(goal.targetCount)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .cardStyle()
    }
}
