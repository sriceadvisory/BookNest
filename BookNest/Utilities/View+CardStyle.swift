import SwiftUI

extension View {
    // Common card treatment used across dashboard, goal, and stats sections.
    func cardStyle(cornerRadius: CGFloat = 18) -> some View {
        self
            .padding()
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
