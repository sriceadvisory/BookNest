import Combine
import Foundation

// Manages the library list plus the active search and status filters.
final class LibraryViewModel: ObservableObject {
    @Published var books: [Book]
    @Published var selectedStatus: ReadingStatus?
    @Published var searchText: String = ""

    init(books: [Book]) {
        self.books = books
    }

    // Applies both filters in one place so the view only renders the final list.
    var filteredBooks: [Book] {
        books.filter { book in
            let matchesStatus = selectedStatus == nil || book.status == selectedStatus
            let matchesSearch = searchText.isEmpty ||
            book.title.localizedCaseInsensitiveContains(searchText) ||
            book.author.localizedCaseInsensitiveContains(searchText)

            return matchesStatus && matchesSearch
        }
    }

    // Preview and temporary runtime data until real storage is added.
    static let sample = LibraryViewModel(books: SampleData.books)
}
