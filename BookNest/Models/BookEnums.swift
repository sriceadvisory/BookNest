import Foundation

// Book format drives both picker options and the matching system icon.
enum BookFormat: String, CaseIterable, Codable, Hashable {
    case physical = "Physical"
    case ebook = "Ebook"
    case audiobook = "Audiobook"

    var iconName: String {
        switch self {
        case .physical:
            return "book.closed.fill"
        case .ebook:
            return "ipad"
        case .audiobook:
            return "headphones"
        }
    }
}

// Reading status is shared by filters, rows, and progress summaries.
enum ReadingStatus: String, CaseIterable, Codable, Hashable {
    case wantToRead = "Want to Read"
    case reading = "Reading"
    case finished = "Finished"
    case didNotFinish = "DNF"

    var iconName: String {
        switch self {
        case .wantToRead:
            return "bookmark.fill"
        case .reading:
            return "book.fill"
        case .finished:
            return "checkmark.circle.fill"
        case .didNotFinish:
            return "xmark.circle.fill"
        }
    }
}

// Goal types define what a reading goal is measuring.
enum GoalType: String, CaseIterable, Codable, Hashable {
    case booksFinished = "Books Finished"
    case pagesRead = "Pages Read"
    case minutesRead = "Minutes Read"
}
