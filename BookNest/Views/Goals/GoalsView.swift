import SwiftUI
import SwiftData

// Lists reading goals and presents the add-goal flow.
struct GoalsView: View {
    @Environment(\.modelContext) private var modelContext
    // Goals are loaded from local device storage.
    @Query(sort: \ReadingGoal.title) private var goals: [ReadingGoal]
    @Query private var books: [Book]
    // Tracks whether the add-goal sheet is currently visible.
    @State private var showingAddGoal = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Each goal uses the same progress card component as the home dashboard.
                    ForEach(goals) { goal in
                        GoalProgressCardView(
                            goal: goal,
                            currentCountOverride: currentCount(for: goal)
                        )
                        .contextMenu {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(goal)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Goals")
            .overlay {
                // Empty state sits above the scroll view when there are no goals.
                if goals.isEmpty {
                    EmptyStateView(
                        title: "No goals yet",
                        message: "Set a yearly, monthly, or custom reading goal.",
                        systemImage: "target"
                    )
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    // The plus button opens the modal form instead of navigating away.
                    Button {
                        showingAddGoal = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddGoal) {
                AddGoalView()
            }
        }
    }

    private func currentCount(for goal: ReadingGoal) -> Int {
        switch goal.goalType {
        case .booksFinished:
            return books.filter { $0.status == .finished }.count
        case .pagesRead:
            return books.reduce(0) { total, book in
                total + min(book.currentPage, book.totalPages)
            }
        case .minutesRead:
            return goal.currentCount
        }
    }
}

#Preview {
    GoalsView()
        .modelContainer(for: [Book.self, BookNote.self, ReadingGoal.self], inMemory: true)
}
