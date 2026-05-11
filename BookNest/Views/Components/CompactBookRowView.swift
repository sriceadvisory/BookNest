import SwiftUI

// Compact row for dashboard-style lists where space is limited.
struct CompactBookRowView: View {
    let book: Book

    var body: some View {
        HStack(spacing: 12) {
            // The status icon makes recent books scannable without a full cover.
            Image(systemName: book.status.iconName)
                .font(.title3)
                .foregroundStyle(.brown)

            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(book.author)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(book.status.rawValue)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .cardStyle(cornerRadius: 14)
    }
}
