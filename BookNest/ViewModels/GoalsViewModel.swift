import Combine
import Foundation

// Holds active reading goals for the goals screen.
final class GoalsViewModel: ObservableObject {
    @Published var goals: [ReadingGoal]

    init(goals: [ReadingGoal]) {
        self.goals = goals
    }

    // Preview and temporary runtime data until real storage is added.
    static let sample = GoalsViewModel(goals: SampleData.goals)
}
