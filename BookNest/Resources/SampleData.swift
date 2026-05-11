import Foundation

// Shared mock data keeps previews and early screens populated before persistence is wired up.
enum SampleData {
    static let books: [Book] = [
        Book(
            title: "Atomic Habits",
            author: "James Clear",
            genre: "Self Improvement",
            format: .physical,
            status: .reading,
            totalPages: 320,
            currentPage: 84,
            rating: nil,
            notes: "Good examples about identity-based habits."
        ),
        Book(
            title: "The Creative Act",
            author: "Rick Rubin",
            genre: "Creativity",
            format: .ebook,
            status: .finished,
            totalPages: 432,
            currentPage: 432,
            rating: 5,
            notes: "A slow, thoughtful read about creativity."
        ),
        Book(
            title: "Deep Work",
            author: "Cal Newport",
            genre: "Productivity",
            format: .audiobook,
            status: .wantToRead,
            totalPages: 296,
            currentPage: 0,
            rating: nil
        ),
        Book(
            title: "Project Hail Mary",
            author: "Andy Weir",
            genre: "Sci-Fi",
            format: .physical,
            status: .finished,
            totalPages: 496,
            currentPage: 496,
            rating: 5
        ),
        Book(
            title: "The Psychology of Money",
            author: "Morgan Housel",
            genre: "Finance",
            format: .ebook,
            status: .didNotFinish,
            totalPages: 256,
            currentPage: 90,
            rating: nil
        )
    ]

    static let notes: [BookNote] = [
        BookNote(
            bookTitle: "Atomic Habits",
            text: "Small habits compound when they are tied to identity, not just outcomes.",
            pageNumber: 41
        ),
        BookNote(
            bookTitle: "The Creative Act",
            text: "Creativity feels less like forcing ideas and more like creating room for them to show up.",
            pageNumber: 88
        ),
        BookNote(
            bookTitle: "Project Hail Mary",
            text: "Great pacing. The problem-solving makes the story feel like a puzzle box.",
            pageNumber: 210
        )
    ]

    static let goals: [ReadingGoal] = [
        ReadingGoal(
            title: "Read 12 books this year",
            goalType: .booksFinished,
            targetCount: 12,
            currentCount: 7
        ),
        ReadingGoal(
            title: "Read 1,000 pages this month",
            goalType: .pagesRead,
            targetCount: 1000,
            currentCount: 640
        ),
        ReadingGoal(
            title: "Read 30 minutes daily",
            goalType: .minutesRead,
            targetCount: 30,
            currentCount: 20
        )
    ]
}
