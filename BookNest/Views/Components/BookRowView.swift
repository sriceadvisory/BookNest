import SwiftUI

// Full-width library row used when browsing or searching books.
struct BookRowView: View {
    let book: Book

    var body: some View {
        HStack(spacing: 14) {
            // Keep the cover small so the row remains easy to scan in a list.
            BookCoverPlaceholderView(title: book.title)
                .frame(width: 48, height: 68)

            VStack(alignment: .leading, spacing: 5) {
                Text(book.title)
                    .font(.headline)
                    .lineLimit(1)

                Text(book.author)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                // Status and genre give quick context without opening the detail screen.
                HStack {
                    Label(book.status.rawValue, systemImage: book.status.iconName)
                    Text("•")
                    Text(book.genre)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
