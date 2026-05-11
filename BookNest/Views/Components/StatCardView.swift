import SwiftUI

// Small metric card used by the stats dashboard grid.
struct StatCardView: View {
    let title: String
    let value: String
    let systemImage: String

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Icon, value, and label are stacked for quick comparison in a grid.
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(.brown)

            Text(value)
                .font(.title)
                .fontWeight(.bold)

            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}
