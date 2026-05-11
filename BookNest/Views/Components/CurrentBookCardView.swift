import SwiftUI

// Home screen card focused on the user's active read and progress.
struct CurrentBookCardView: View {
    let book: Book

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Top section shows the book identity before the progress controls.
            HStack(alignment: .top, spacing: 16) {
                BookCoverPlaceholderView(title: book.title)
                    .frame(width: 88, height: 124)

                VStack(alignment: .leading, spacing: 8) {
                    Text(book.title)
                        .font(.headline)
                        .lineLimit(2)

                    Text(book.author)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Label(book.format.rawValue, systemImage: book.format.iconName)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()
                }
            }

            // Progress is derived from the book model so every screen uses the same math.
            VStack(alignment: .leading, spacing: 8) {
                ProgressView(value: book.progress)
                    .tint(.brown)

                HStack {
                    Text(book.progressText)
                    Spacer()
                    Text("\(Int(book.progress * 100))%")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Label("Open Details", systemImage: "arrow.right.circle.fill")
                .font(.headline)
                .foregroundStyle(.brown)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .cardStyle(cornerRadius: 20)
    }
}
