import Foundation

struct NotesBuilderModel {
    var tastingNotes: [TastingNoteBuilderModel]?
}

struct TastingNoteBuilderModel {
    let noteOrigin: Constants.TastingNotesOrigin
    let tastingNoteText: String
}
