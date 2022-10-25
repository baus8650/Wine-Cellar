import CoreData
@testable import Wine_Cellar
import XCTest

final class TastingNoteTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var tastingNoteService: TastingNoteService!
    let newTastingNote = TastingNoteBuilder().build()
    let secondTastingNote = TastingNoteBuilder()
        .testingNoteText("Second Text")
        .build()
    
    override func setUpWithError() throws {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        tastingNoteService = TastingNoteService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        coreDataStack = nil
        tastingNoteService = nil
    }
    
    func testAddTasteDetails() throws {
        let tastingNotes = tastingNoteService.add(noteOrigin: newTastingNote.noteOrigin.rawValue, tastingNoteText: newTastingNote.tastingNoteText)
        XCTAssertEqual(tastingNotes.tastingNoteText, "Tasting Note Text")
    }
    
    func testGetAllTasteDetails() throws {
        let _ = tastingNoteService.add(noteOrigin: newTastingNote.noteOrigin.rawValue, tastingNoteText: newTastingNote.tastingNoteText)
        let _ = tastingNoteService.add(noteOrigin: secondTastingNote.noteOrigin.rawValue, tastingNoteText: secondTastingNote.tastingNoteText)
        let tastingNotes = tastingNoteService.getTastingNotes()
        XCTAssertEqual(tastingNotes?.count, 2)
    }
    
    func testGetSingleTasteDetail() throws {
        let tastingNote1 = tastingNoteService.add(noteOrigin: newTastingNote.noteOrigin.rawValue, tastingNoteText: newTastingNote.tastingNoteText)
        let tastingNote2 = tastingNoteService.add(noteOrigin: secondTastingNote.noteOrigin.rawValue, tastingNoteText: secondTastingNote.tastingNoteText)
        
        let fetchedTastingNote1 = tastingNoteService.getTastingNote(with: tastingNote1.objectID)
        let fetchedTastingNote2 = tastingNoteService.getTastingNote(with: tastingNote2.objectID)
        XCTAssertEqual(fetchedTastingNote1?.tastingNoteText, "Tasting Note Text")
        XCTAssertEqual(fetchedTastingNote2?.tastingNoteText, "Second Text")
    }
    
    func testUpdateTasteDetails() throws {
        let tastingNote1 = tastingNoteService.add(noteOrigin: newTastingNote.noteOrigin.rawValue, tastingNoteText: newTastingNote.tastingNoteText)
        let oldTastingNote = tastingNoteService.getTastingNote(with: tastingNote1.objectID)
        XCTAssertEqual(oldTastingNote?.tastingNoteText, "Tasting Note Text")
        
        let updatedTastingNote = tastingNoteService.getTastingNote(with: tastingNote1.objectID)
        updatedTastingNote?.tastingNoteText = "Updated Text"
        tastingNoteService.update(updatedTastingNote!)
        
        let newTastingNote = tastingNoteService.getTastingNote(with: tastingNote1.objectID)
        XCTAssertEqual(newTastingNote?.tastingNoteText, "Updated Text")
    }
    
    func testDeleteTasteDetails() throws {
        let _ = tastingNoteService.add(noteOrigin: newTastingNote.noteOrigin.rawValue, tastingNoteText: newTastingNote.tastingNoteText)
        let tastingNote2 = tastingNoteService.add(noteOrigin: secondTastingNote.noteOrigin.rawValue, tastingNoteText: secondTastingNote.tastingNoteText)
        
        var tastingNotes = tastingNoteService.getTastingNotes()
        XCTAssertEqual(tastingNotes?.count, 2)
        
        let tastingNoteToDelete = tastingNoteService.getTastingNote(with: tastingNote2.objectID)
        tastingNoteService.delete(tastingNoteToDelete!)
        tastingNotes = tastingNoteService.getTastingNotes()
        XCTAssertEqual(tastingNotes?.count, 1)
        XCTAssertEqual(tastingNotes?[0].tastingNoteText, "Tasting Note Text")
    }
}
