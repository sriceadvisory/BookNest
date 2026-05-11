import SwiftUI
import SwiftData

// Detail screen for reviewing and updating one book.
struct BookDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var book: Book
    // Text field state mirrors currentPage so the user can edit it as text.
    @State private var currentPageText: String = ""
    @State private var showingInvalidPageAlert = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Large cover placeholder gives the detail page a clear visual anchor.
                BookCoverPlaceholderView(title: book.title)
                    .frame(maxWidth: .infinity)
                    .frame(height: 240)

                // Primary metadata is grouped before progress and notes.
                VStack(alignment: .leading, spacing: 12) {
                    TextField("Title", text: $book.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    TextField("Author", text: $book.author)
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    Picker("Status", selection: $book.status) {
                        ForEach(ReadingStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }

                    Picker("Format", selection: $book.format) {
                        ForEach(BookFormat.allCases, id: \.self) { format in
                            Text(format.rawValue).tag(format)
                        }
                    }

                    TextField("Genre", text: $book.genre)
                        .textFieldStyle(.roundedBorder)
                }
                .cardStyle()

                // Progress card is where page updates are saved.
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeaderView(title: "Progress")

                    ProgressView(value: book.progress)
                        .tint(.brown)

                    Text(book.progressText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    HStack {
                        TextField("Current page", text: $currentPageText)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)

                        Button("Save") {
                            saveProgress()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.brown)
                    }

                    Picker("Rating", selection: ratingBinding) {
                        Text("No rating").tag(0)
                        ForEach(1...5, id: \.self) { rating in
                            Text("\(rating) star\(rating == 1 ? "" : "s")").tag(rating)
                        }
                    }
                }
                .cardStyle()

                // Notes section handles both existing notes and the empty state.
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeaderView(title: "Notes")

                    TextEditor(text: $book.notes)
                        .frame(minHeight: 140)
                        .overlay {
                            if book.notes.isEmpty {
                                Text("No notes yet.")
                                    .foregroundStyle(.secondary)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    .padding(.top, 8)
                                    .padding(.leading, 5)
                                    .allowsHitTesting(false)
                            }
                        }
                }
                .cardStyle()
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Book Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Seed the editable field from the model when the detail view opens.
            currentPageText = "\(book.currentPage)"
        }
        .onChange(of: book.status) { _, newStatus in
            updateDates(for: newStatus)
        }
        .alert("Check the page number", isPresented: $showingInvalidPageAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Current page cannot be greater than the total page count.")
        }
    }

    private var ratingBinding: Binding<Int> {
        Binding(
            get: { book.rating ?? 0 },
            set: { book.rating = $0 == 0 ? nil : $0 }
        )
    }

    private func saveProgress() {
        let currentPage = Int(currentPageText) ?? 0
        guard book.totalPages == 0 || currentPage <= book.totalPages else {
            showingInvalidPageAlert = true
            return
        }

        book.currentPage = max(currentPage, 0)
        if book.currentPage > 0, book.dateStarted == nil {
            book.dateStarted = Date()
        }
        if book.totalPages > 0, book.currentPage >= book.totalPages {
            book.status = .finished
            book.dateFinished = Date()
        }
        try? modelContext.save()
    }

    private func updateDates(for status: ReadingStatus) {
        switch status {
        case .reading:
            if book.dateStarted == nil {
                book.dateStarted = Date()
            }
        case .finished:
            book.currentPage = max(book.currentPage, book.totalPages)
            currentPageText = "\(book.currentPage)"
            book.dateFinished = Date()
        case .wantToRead:
            book.dateStarted = nil
            book.dateFinished = nil
            book.currentPage = 0
            currentPageText = "0"
        case .didNotFinish:
            book.dateFinished = nil
        }
    }
}

#Preview {
    NavigationStack {
        BookDetailView(book: SampleData.books[0])
    }
    .modelContainer(for: [Book.self, BookNote.self, ReadingGoal.self], inMemory: true)
}
