import SwiftUI
import SwiftData

@main
struct BookNestApp: App {
    var body: some Scene {
        WindowGroup {
            // The root view owns the tab-based layout for the whole app.
            BookNestRootView()
        }
        .modelContainer(for: [Book.self, BookNote.self, ReadingGoal.self])
    }
}
