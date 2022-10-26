import CoreData
@testable import Wine_Cellar
import XCTest

final class WineTests_TastingNotes: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var wineService: WineService!
    var tastingNotesService: TastingNotesService!
    let newWine = WineBuilder().build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineService = WineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        tastingNotesService = TastingNotesService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineService = nil
        tastingNotesService = nil
    }
    
    func testAddSingleTastingNoteToWine() throws {
        let tastingNote = TastingNoteBuilder().build()
        let wine = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue
        )
        
        let tastingNotes = tastingNotesService.add(noteOrigin: tastingNote.noteOrigin.rawValue, tastingNoteText: tastingNote.tastingNoteText)
        
        let wineWithTastingNotes = wineService.addSingleTastingNotes(tastingNotes, to: wine)
        
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.count, 1)
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.contains(tastingNotes), true)
    }
    
    func testAddMultipleTastingNotesToWine() throws {
        let tastingNote1 = TastingNoteBuilder().build()
        let tastingNote2 = TastingNoteBuilder()
            .testingNoteText("Second Tasting Note Text")
            .build()
        let wine = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue
        )
        
        let addedTastingNote1 = tastingNotesService.add(noteOrigin: tastingNote1.noteOrigin.rawValue, tastingNoteText: tastingNote1.tastingNoteText)
        
        let addedTastingNote2 = tastingNotesService.add(noteOrigin: tastingNote2.noteOrigin.rawValue, tastingNoteText: tastingNote2.tastingNoteText)
        
        let wineWithTastingNotes = wineService.addMultipleTastingNotes([addedTastingNote1, addedTastingNote2], to: wine)
        
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.count, 2)
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.contains(addedTastingNote1), true)
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.contains(addedTastingNote2), true)
    }
    
    func testRemoveSingleTastingNoteFromWineAfterAddingSingularTastingNote() throws {
        let tastingNote1 = TastingNoteBuilder().build()
        let wine = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue
        )
        
        let addedTastingNote1 = tastingNotesService.add(noteOrigin: tastingNote1.noteOrigin.rawValue, tastingNoteText: tastingNote1.tastingNoteText)
        
        var wineWithTastingNotes = wineService.addSingleTastingNotes(addedTastingNote1, to: wine)
        
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.count, 1)
        wineWithTastingNotes = wineService.removeSingleTastingNote(addedTastingNote1, from: wine)
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.count, 0)
    }
    
    func testRemoveSingleTastingNoteFromWineAfterAddingMultipleTastingNotes() throws {
        let tastingNote1 = TastingNoteBuilder().build()
        let tastingNote2 = TastingNoteBuilder()
            .testingNoteText("Second Tasting Note Text")
            .build()
        let wine = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue
        )
        
        let addedTastingNote1 = tastingNotesService.add(noteOrigin: tastingNote1.noteOrigin.rawValue, tastingNoteText: tastingNote1.tastingNoteText)
        
        let addedTastingNote2 = tastingNotesService.add(noteOrigin: tastingNote2.noteOrigin.rawValue, tastingNoteText: tastingNote2.tastingNoteText)
        
        var wineWithTastingNotes = wineService.addMultipleTastingNotes([addedTastingNote1, addedTastingNote2], to: wine)
        
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.count, 2)
        wineWithTastingNotes = wineService.removeSingleTastingNote(addedTastingNote1, from: wine)
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.count, 1)
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.contains(addedTastingNote1), false)
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.contains(addedTastingNote2), true)
    }
    
    func testRemoveMultipleTastingNotesFromWine() throws {
        let tastingNote1 = TastingNoteBuilder().build()
        let tastingNote2 = TastingNoteBuilder()
            .testingNoteText("Second Tasting Note Text")
            .build()
        let wine = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue
        )
        
        let addedTastingNote1 = tastingNotesService.add(noteOrigin: tastingNote1.noteOrigin.rawValue, tastingNoteText: tastingNote1.tastingNoteText)
        
        let addedTastingNote2 = tastingNotesService.add(noteOrigin: tastingNote2.noteOrigin.rawValue, tastingNoteText: tastingNote2.tastingNoteText)
        
        var wineWithTastingNotes = wineService.addMultipleTastingNotes([addedTastingNote1, addedTastingNote2], to: wine)
        
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.count, 2)
        wineWithTastingNotes = wineService.removeMultipleTastingNote([addedTastingNote1, addedTastingNote2], from: wine)
        XCTAssertEqual(wineWithTastingNotes.tastingNotes?.count, 0)
    }
}
