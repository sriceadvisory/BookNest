import Combine
import Foundation

// Turns the book collection into summary numbers for the stats screen.
final class StatsViewModel: ObservableObject {
    @Published var books: [Book]

    init(books: [Book]) {
        self.books = books
    }

    // Finished books are the main completion metric for the snapshot grid.
    var finishedBooksCount: Int {
        books.filter { $0.status == .finished }.count
    }

    // Separates active reads from backlog and completed books.
    var currentlyReadingCount: Int {
        books.filter { $0.status == .reading }.count
    }

    // Tracks backlog size for the reader's future queue.
    var wantToReadCount: Int {
        books.filter { $0.status == .wantToRead }.count
    }

    // Counts only pages the user could have actually read for each book.
    var totalPagesRead: Int {
        books.reduce(0) { total, book in
            total + min(book.currentPage, book.totalPages)
        }
    }

    // Formats the rating for display and handles the empty state in the view model.
    var averageRatingText: String {
        let ratings = books.compactMap { $0.rating }
        guard !ratings.isEmpty else { return "No ratings yet" }

        let average = Double(ratings.reduce(0, +)) / Double(ratings.count)
        return String(format: "%.1f", average)
    }

    // Preview and temporary runtime data until real storage is added.
    static let sample = StatsViewModel(books: SampleData.books)
}
