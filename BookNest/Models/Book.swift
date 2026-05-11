import Foundation
import SwiftData

// Core model for a tracked book and its reading progress.
@Model
final class Book {
    @Attribute(.unique) var id: UUID
    var title: String
    var author: String
    var genre: String
    var format: BookFormat
    var status: ReadingStatus
    var totalPages: Int
    var currentPage: Int
    var rating: Int?
    var dateAdded: Date
    var dateStarted: Date?
    var dateFinished: Date?
    var notes: String
    @Relationship(deleteRule: .cascade, inverse: \BookNote.book) var journalNotes: [BookNote]

    init(
        id: UUID = UUID(),
        title: String,
        author: String,
        genre: String = "General",
        format: BookFormat = .physical,
        status: ReadingStatus = .wantToRead,
        totalPages: Int = 0,
        currentPage: Int = 0,
        rating: Int? = nil,
        dateAdded: Date = Date(),
        dateStarted: Date? = nil,
        dateFinished: Date? = nil,
        notes: String = "",
        journalNotes: [BookNote] = []
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.genre = genre
        self.format = format
        self.status = status
        self.totalPages = totalPages
        self.currentPage = currentPage
        self.rating = rating
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateFinished = dateFinished
        self.notes = notes
        self.journalNotes = journalNotes
    }

    // Clamp progress to 100% so over-entered pages do not break progress views.
    var progress: Double {
        guard totalPages > 0 else { return 0 }
        return min(Double(currentPage) / Double(totalPages), 1.0)
    }

    // Keeps the page-count display logic close to the data it describes.
    var progressText: String {
        guard totalPages > 0 else { return "No page count" }
        return "\(currentPage) of \(totalPages) pages"
    }
}
