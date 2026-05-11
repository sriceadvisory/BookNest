import SwiftUI

// Horizontal filter control that lets LibraryView narrow books by reading status.
struct StatusFilterBarView: View {
    // Binding keeps the selected filter owned by LibraryViewModel.
    @Binding var selectedStatus: ReadingStatus?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                // Nil means no status filter, so all books are included.
                FilterPillView(
                    title: "All",
                    isSelected: selectedStatus == nil
                ) {
                    selectedStatus = nil
                }

                // Build one pill per status so enum changes automatically update the UI.
                ForEach(ReadingStatus.allCases, id: \.self) { status in
                    FilterPillView(
                        title: status.rawValue,
                        isSelected: selectedStatus == status
                    ) {
                        selectedStatus = status
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
    }
}
