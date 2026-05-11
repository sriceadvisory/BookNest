import SwiftUI
import SwiftData

// Modal form for collecting the fields needed to create a reading goal.
struct AddGoalView: View {
    // Dismiss comes from SwiftUI so this form can close itself after cancel or save.
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    // Form state stays local until persistence is connected.
    @State private var title = ""
    @State private var selectedGoalType: GoalType = .booksFinished
    @State private var targetCount = ""

    var body: some View {
        NavigationStack {
            Form {
                // Group all goal fields together because this form is intentionally short.
                Section("Goal") {
                    TextField("Goal Title", text: $title)

                    Picker("Type", selection: $selectedGoalType) {
                        ForEach(GoalType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }

                    TextField("Target Count", text: $targetCount)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    // Cancel exits without creating a goal.
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    // Save is disabled until the minimum required field is present.
                    Button("Save") {
                        addGoal()
                        dismiss()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }

    private var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && (Int(targetCount) ?? 0) > 0
    }

    private func addGoal() {
        let goal = ReadingGoal(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            goalType: selectedGoalType,
            targetCount: max(Int(targetCount) ?? 0, 0)
        )

        modelContext.insert(goal)
    }
}

#Preview {
    AddGoalView()
}
