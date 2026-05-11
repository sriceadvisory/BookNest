import SwiftUI

// Lightweight cover art stand-in until real book images are supported.
struct BookCoverPlaceholderView: View {
    let title: String

    var body: some View {
        ZStack {
            // The gradient gives every placeholder enough visual weight to read as a cover.
            LinearGradient(
                colors: [
                    Color.brown.opacity(0.85),
                    Color.orange.opacity(0.65)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(spacing: 8) {
                // Pair the generic book icon with the title so placeholders stay identifiable.
                Image(systemName: "book.closed.fill")
                    .font(.title2)

                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding(.horizontal, 6)
            }
            .foregroundStyle(.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}
