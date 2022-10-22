import Foundation

struct Note {
    var tastingNotes: [TastingNote]?
}

struct TastingNote {
    let noteOrigin: TastingNotesOrigin
    let tastingNoteText: String
    
    enum TastingNotesOrigin {
        case userGenerated
        case wineryGenerated
    }
}
