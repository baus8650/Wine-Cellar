import Foundation

final class NotesBuilder {
    private var tastingNotes = [TastingNoteBuilder().build()]
    
    func tastingNotes(_ tastingNotes: [TastingNoteBuilderModel]) -> Self {
        self.tastingNotes = tastingNotes
        return self
    }
    
    func build() -> NotesBuilderModel {
        NotesBuilderModel(tastingNotes: tastingNotes)
    }
}
