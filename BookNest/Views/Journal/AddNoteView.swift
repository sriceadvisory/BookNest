import SwiftUI
import SwiftData

// Modal form for capturing a reading note.
struct AddNoteView: View {
    // Allows toolbar actions to close the sheet.
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Book.title) private var books: [Book]

    // Draft fields live locally until the note is saved.
    @State private var selectedBookID: UUID?
    @State private var bookTitle = ""
    @State private var noteText = ""
    @State private var pageNumber = ""

    private var selectedBook: Book? {
        guard let selectedBookID else { return nil }
        return books.first { $0.id == selectedBookID }
    }

    var body: some View {
        NavigationStack {
            Form {
                // Book metadata helps connect the note back to its source.
                Section("Book") {
                    if books.isEmpty {
                        TextField("Book Title", text: $bookTitle)
                    } else {
                        Picker("Book", selection: $selectedBookID) {
                            Text("No linked book").tag(UUID?.none)
                            ForEach(books) { book in
                                Text(book.title).tag(Optional(book.id))
                            }
                        }

                        TextField("Custom title", text: $bookTitle)
                    }

                    TextField("Page Number", text: $pageNumber)
                        .keyboardType(.numberPad)
                }

                // TextEditor gives enough room for longer thoughts or quotes.
                Section("Note") {
                    TextEditor(text: $noteText)
                        .frame(minHeight: 160)
                }
            }
            .navigationTitle("Add Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    // Cancel drops the draft and closes the form.
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    // Require note text so empty journal entries are not saved.
                    Button("Save") {
                        addNote()
                        dismiss()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }

    private var canSave: Bool {
        let hasNote = !noteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let hasBook = selectedBook != nil || !bookTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return hasNote && hasBook
    }

    private func addNote() {
        let linkedBook = selectedBook
        let note = BookNote(
            bookTitle: linkedBook?.title ?? bookTitle.trimmingCharacters(in: .whitespacesAndNewlines),
            text: noteText.trimmingCharacters(in: .whitespacesAndNewlines),
            pageNumber: Int(pageNumber),
            book: linkedBook
        )

        modelContext.insert(note)
    }
}

#Preview {
    AddNoteView()
        .modelContainer(for: [Book.self, BookNote.self, ReadingGoal.self], inMemory: true)
}
