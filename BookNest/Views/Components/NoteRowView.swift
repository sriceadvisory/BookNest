import SwiftUI

// Journal list row that shows the book, note text, and note metadata.
struct NoteRowView: View {
    let note: BookNote

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.bookTitle)
                .font(.headline)

            Text(note.text)
                .font(.body)
                .foregroundStyle(.primary)
                .lineLimit(3)

            // Page number is optional because some notes are general thoughts.
            HStack {
                if let pageNumber = note.pageNumber {
                    Label("Page \(pageNumber)", systemImage: "number")
                }

                Spacer()

                Text(note.createdAt.formatted(date: .abbreviated, time: .omitted))
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}
