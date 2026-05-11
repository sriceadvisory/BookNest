import SwiftUI
import SwiftData

// Main library screen with status filtering, search, navigation, and add-book presentation.
struct LibraryView: View {
    @Environment(\.modelContext) private var modelContext
    // SwiftData keeps this list synced with local device storage.
    @Query(sort: \Book.dateAdded, order: .reverse) private var books: [Book]
    @State private var selectedStatus: ReadingStatus?
    @State private var searchText = ""
    // Controls whether the add-book sheet is shown.
    @State private var showingAddBook = false

    private var filteredBooks: [Book] {
        books.filter { book in
            let matchesStatus = selectedStatus == nil || book.status == selectedStatus
            let matchesSearch = searchText.isEmpty ||
            book.title.localizedCaseInsensitiveContains(searchText) ||
            book.author.localizedCaseInsensitiveContains(searchText)

            return matchesStatus && matchesSearch
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Status filter writes into local view state, then filteredBooks applies it.
                StatusFilterBarView(selectedStatus: $selectedStatus)

                // Show an empty state after filters are applied, not only when the library is empty.
                if filteredBooks.isEmpty {
                    EmptyStateView(
                        title: books.isEmpty ? "No books yet" : "No books found",
                        message: books.isEmpty ? "Add your first book to start building your offline library." : "Try adjusting your filters or search text.",
                        systemImage: books.isEmpty ? "books.vertical" : "magnifyingglass"
                    )
                    .padding()
                    Spacer()
                } else {
                    List {
                        // NavigationLink opens the detail screen for the selected book.
                        ForEach(filteredBooks) { book in
                            NavigationLink {
                                BookDetailView(book: book)
                            } label: {
                                BookRowView(book: book)
                            }
                        }
                        .onDelete(perform: deleteBooks)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Library")
            // Search text feeds into filteredBooks.
            .searchable(text: $searchText, prompt: "Search books or authors")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    // The plus button presents the book creation form.
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

    private func deleteBooks(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(filteredBooks[index])
        }
    }
}

#Preview {
    LibraryView()
        .modelContainer(for: [Book.self, BookNote.self, ReadingGoal.self], inMemory: true)
}
