import Combine
import Foundation

// Provides the journal note list for the journal screen.
final class JournalViewModel: ObservableObject {
    @Published var notes: [BookNote]

    init(notes: [BookNote]) {
        self.notes = notes
    }

    // Preview and temporary runtime data until real storage is added.
    static let sample = JournalViewModel(notes: SampleData.notes)
}
