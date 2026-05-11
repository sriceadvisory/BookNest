import Combine
import Foundation

// Collects the data needed to render the home dashboard.
final class HomeViewModel: ObservableObject {
    @Published var currentBook: Book?
    @Published var yearlyGoal: ReadingGoal?
    @Published var recentBooks: [Book]

    init(
        currentBook: Book?,
        yearlyGoal: ReadingGoal?,
        recentBooks: [Book]
    ) {
        self.currentBook = currentBook
        self.yearlyGoal = yearlyGoal
        self.recentBooks = recentBooks
    }

    // Preview and temporary runtime data until real storage is added.
    static let sample = HomeViewModel(
        currentBook: SampleData.books[0],
        yearlyGoal: SampleData.goals[0],
        recentBooks: Array(SampleData.books.prefix(3))
    )
}
