import SwiftUI

// Simple greeting block used at the top of the home dashboard.
struct HeaderGreetingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Good evening")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text("Ready to turn pages into progress?")
                .font(.title2)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
