import Foundation

final class TastingNoteBuilder {
    private var noteOrigin = Constants.TastingNotesOrigin.userGenerated
    private var tastingNoteText = "Tasting Note Text"
    
    func noteOrigin(_ noteOrigin: Constants.TastingNotesOrigin) -> Self {
        self.noteOrigin = noteOrigin
        return self
    }
    
    func testingNoteText(_ tastingNoteText: String) -> Self {
        self.tastingNoteText = tastingNoteText
        return self
    }
    
    func build() -> TastingNoteBuilderModel {
        TastingNoteBuilderModel(noteOrigin: noteOrigin, tastingNoteText: tastingNoteText)
    }
}
