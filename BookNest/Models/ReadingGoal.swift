import Foundation
import SwiftData

// Tracks a reading target and the user's current progress toward it.
@Model
final class ReadingGoal {
    @Attribute(.unique) var id: UUID
    var title: String
    var goalType: GoalType
    var targetCount: Int
    var currentCount: Int
    var targetDate: Date?

    init(
        id: UUID = UUID(),
        title: String,
        goalType: GoalType,
        targetCount: Int,
        currentCount: Int = 0,
        targetDate: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.goalType = goalType
        self.targetCount = targetCount
        self.currentCount = currentCount
        self.targetDate = targetDate
    }

    // Progress is capped so the UI stays stable after a goal is exceeded.
    var progress: Double {
        guard targetCount > 0 else { return 0 }
        return min(Double(currentCount) / Double(targetCount), 1.0)
    }
}
