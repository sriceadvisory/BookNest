import Foundation
import SwiftData

// Stores a short journal entry tied back to a book and optional page number.
@Model
final class BookNote {
    @Attribute(.unique) var id: UUID
    var bookTitle: String
    var text: String
    var pageNumber: Int?
    var createdAt: Date
    var book: Book?

    init(
        id: UUID = UUID(),
        bookTitle: String,
        text: String,
        pageNumber: Int? = nil,
        createdAt: Date = Date(),
        book: Book? = nil
    ) {
        self.id = id
        self.bookTitle = bookTitle
        self.text = text
        self.pageNumber = pageNumber
        self.createdAt = createdAt
        self.book = book
    }
}
