import SwiftUI

// Shared section title with an optional trailing action button.
struct SectionHeaderView: View {
    let title: String
    var actionTitle: String?
    var action: (() -> Void)?

    init(
        title: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.actionTitle = actionTitle
        self.action = action
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)

            Spacer()

            // Only render the action when both the label and callback are provided.
            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.brown)
            }
        }
    }
}
