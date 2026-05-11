import SwiftUI
import SwiftData
import Charts

struct StatsView: View {
    // Stats are derived from the same locally stored books used by the library.
    @Query private var books: [Book]

    // Two flexible columns keep the stat cards balanced across different screen sizes.
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    private var finishedBooksCount: Int {
        books.filter { $0.status == .finished }.count
    }

    private var currentlyReadingCount: Int {
        books.filter { $0.status == .reading }.count
    }

    private var wantToReadCount: Int {
        books.filter { $0.status == .wantToRead }.count
    }

    private var totalPagesRead: Int {
        books.reduce(0) { total, book in
            total + min(book.currentPage, book.totalPages)
        }
    }

    private var averageRatingText: String {
        let ratings = books.compactMap { $0.rating }
        guard !ratings.isEmpty else { return "No ratings yet" }

        let average = Double(ratings.reduce(0, +)) / Double(ratings.count)
        return String(format: "%.1f", average)
    }

    private var genreCounts: [(genre: String, count: Int)] {
        let grouped = Dictionary(grouping: books) { book in
            book.genre.isEmpty ? "General" : book.genre
        }

        return grouped
            .map { (genre: $0.key, count: $0.value.count) }
            .sorted { $0.count > $1.count }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    if books.isEmpty {
                        EmptyStateView(
                            title: "No stats yet",
                            message: "Add books and update progress to build your reading stats.",
                            systemImage: "chart.bar"
                        )
                    } else {
                        SectionHeaderView(title: "Reading Snapshot")

                        // Summary cards pull calculated values from local storage.
                        LazyVGrid(columns: columns, spacing: 16) {
                            StatCardView(
                                title: "Finished",
                                value: "\(finishedBooksCount)",
                                systemImage: "checkmark.circle.fill"
                            )

                            StatCardView(
                                title: "Reading",
                                value: "\(currentlyReadingCount)",
                                systemImage: "book.fill"
                            )

                            StatCardView(
                                title: "Want to Read",
                                value: "\(wantToReadCount)",
                                systemImage: "bookmark.fill"
                            )

                            StatCardView(
                                title: "Pages Read",
                                value: "\(totalPagesRead)",
                                systemImage: "doc.text.fill"
                            )
                        }

                        // This card highlights rating quality separately from count-based stats.
                        VStack(alignment: .leading, spacing: 12) {
                            SectionHeaderView(title: "Average Rating")

                            HStack(alignment: .firstTextBaseline, spacing: 8) {
                                Text(averageRatingText)
                                    .font(.system(size: 44, weight: .bold))

                                if averageRatingText != "No ratings yet" {
                                    Text("stars")
                                        .font(.headline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .cardStyle()

                        VStack(alignment: .leading, spacing: 12) {
                            SectionHeaderView(title: "Genres")

                            // Chart turns stored books into a quick genre distribution.
                            Chart(genreCounts, id: \.genre) { item in
                                BarMark(
                                    x: .value("Books", item.count),
                                    y: .value("Genre", item.genre)
                                )
                                .foregroundStyle(.brown)
                            }
                            .frame(height: max(CGFloat(genreCounts.count) * 44, 160))
                        }
                        .cardStyle()
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Stats")
        }
    }
}

#Preview {
    StatsView()
        .modelContainer(for: [Book.self, BookNote.self, ReadingGoal.self], inMemory: true)
}
