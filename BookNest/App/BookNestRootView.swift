import SwiftUI

struct BookNestRootView: View {
    var body: some View {
        // Each tab gets its own view model so the screen can manage its own display state.
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "books.vertical.fill")
                }

            JournalView()
                .tabItem {
                    Label("Journal", systemImage: "text.book.closed.fill")
                }

            GoalsView()
                .tabItem {
                    Label("Goals", systemImage: "target")
                }

            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
        }
        .tint(.brown)
    }
}

#Preview {
    BookNestRootView()
}
