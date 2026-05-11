import SwiftUI
import SwiftData

// Shows saved notes and opens the add-note form.
struct JournalView: View {
    @Environment(\.modelContext) private var modelContext
    // Journal notes are loaded from local device storage.
    @Query(sort: \BookNote.createdAt, order: .reverse) private var notes: [BookNote]
    // Controls presentation of the add-note sheet.
    @State private var showingAddNote = false

    var body: some View {
        NavigationStack {
            List {
                // Notes render in newest-first order from the SwiftData query.
                ForEach(notes) { note in
                    NoteRowView(note: note)
                }
                .onDelete(perform: deleteNotes)
            }
            .navigationTitle("Journal")
            .overlay {
                // Empty state explains what belongs in the journal.
                if notes.isEmpty {
                    EmptyStateView(
                        title: "No notes yet",
                        message: "Save quotes, thoughts, and chapter notes here.",
                        systemImage: "square.and.pencil"
                    )
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    // The plus button presents the note composer.
                    Button {
                        showingAddNote = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddNote) {
                AddNoteView()
            }
        }
    }

    private func deleteNotes(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(notes[index])
        }
    }
}

#Preview {
    JournalView()
        .modelContainer(for: [Book.self, BookNote.self, ReadingGoal.self], inMemory: true)
}
