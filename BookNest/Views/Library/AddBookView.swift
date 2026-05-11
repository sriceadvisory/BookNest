import SwiftUI
import SwiftData

// Modal form for entering the first version of a book record.
struct AddBookView: View {
    // Dismiss lets toolbar buttons close the sheet.
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    // Draft book fields stay local until save creates a model object.
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var selectedFormat: BookFormat = .physical
    @State private var selectedStatus: ReadingStatus = .wantToRead
    @State private var totalPages = ""
    @State private var notes = ""

    var body: some View {
        NavigationStack {
            Form {
                // Main book metadata drives library rows, filters, and detail views.
                Section("Book Info") {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    TextField("Genre", text: $genre)

                    Picker("Format", selection: $selectedFormat) {
                        ForEach(BookFormat.allCases, id: \.self) { format in
                            Text(format.rawValue).tag(format)
                        }
                    }

                    Picker("Status", selection: $selectedStatus) {
                        ForEach(ReadingStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                }

                // Progress starts with total pages; current page can be updated later.
                Section("Progress") {
                    TextField("Total Pages", text: $totalPages)
                        .keyboardType(.numberPad)
                }

                // Notes are optional context stored with the book.
                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 120)
                }
            }
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    // Cancel exits without creating a book.
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    // Title is the minimum useful field for creating a book.
                    Button("Save") {
                        addBook()
                        dismiss()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }

    private var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func addBook() {
        let pageCount = Int(totalPages) ?? 0
        let cleanedGenre = genre.trimmingCharacters(in: .whitespacesAndNewlines)
        let book = Book(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            author: author.trimmingCharacters(in: .whitespacesAndNewlines),
            genre: cleanedGenre.isEmpty ? "General" : cleanedGenre,
            format: selectedFormat,
            status: selectedStatus,
            totalPages: max(pageCount, 0),
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines)
        )

        modelContext.insert(book)
    }
}

#Preview {
    AddBookView()
}
