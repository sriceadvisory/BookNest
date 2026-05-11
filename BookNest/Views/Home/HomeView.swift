import SwiftUI
import SwiftData

// Dashboard screen that surfaces the current book, goal progress, and recent activity.
struct HomeView: View {
    // SwiftData queries keep the dashboard in sync with local storage.
    @Query(sort: \Book.dateAdded, order: .reverse) private var books: [Book]
    @Query private var goals: [ReadingGoal]
    @State private var showingAddBook = false

    private var currentBook: Book? {
        books.first { $0.status == .reading }
    }

    private var yearlyGoal: ReadingGoal? {
        goals.first
    }

    private var recentBooks: [Book] {
        Array(books.prefix(3))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HeaderGreetingView()

                    // Show the active reading card when a current book exists.
                    if let currentBook {
                        SectionHeaderView(title: "Currently Reading")
                        NavigationLink {
                            BookDetailView(book: currentBook)
                        } label: {
                            CurrentBookCardView(book: currentBook)
                        }
                        .buttonStyle(.plain)
                    } else {
                        EmptyStateView(
                            title: "No current book",
                            message: "Add a book or mark one as Reading to start tracking progress.",
                            systemImage: "book"
                        )
                    }

                    // The yearly goal is optional so the home screen can work before goals exist.
                    if let yearlyGoal {
                        SectionHeaderView(title: "Reading Goal")
                        GoalProgressCardView(
                            goal: yearlyGoal,
                            currentCountOverride: currentCount(for: yearlyGoal)
                        )
                    }

                    if !recentBooks.isEmpty {
                        // Recent books provide a quick path back into library items.
                        SectionHeaderView(title: "Recent Books")
                        VStack(spacing: 12) {
                            ForEach(recentBooks) { book in
                                NavigationLink {
                                    BookDetailView(book: book)
                                } label: {
                                    CompactBookRowView(book: book)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("BookNest")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    // This is the entry point for adding a new book.
                    Button {
                        showingAddBook = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView()
            }
        }
    }

    private func currentCount(for goal: ReadingGoal) -> Int {
        switch goal.goalType {
        case .booksFinished:
            return books.filter { $0.status == .finished }.count
        case .pagesRead:
            return books.reduce(0) { total, book in
                total + min(book.currentPage, book.totalPages)
            }
        case .minutesRead:
            return goal.currentCount
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [Book.self, BookNote.self, ReadingGoal.self], inMemory: true)
}
