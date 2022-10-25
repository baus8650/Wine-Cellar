import CoreData
@testable import Wine_Cellar
import XCTest

class WineTastingTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var wineTastingService: WineTastingService!
    let newWineTasting = WineTastingBuilder().build()
    let secondWineTasting = WineTastingBuilder()
        .winery("Second Winery")
        .build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineTastingService = WineTastingService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineTastingService = nil
    }
    
    func testAddWineTastingToCoreData() throws {
        let wineTasting = wineTastingService.add(date: newWineTasting.date, winery: newWineTasting.winery)
        XCTAssertEqual(wineTasting.winery, "Test Winery")
    }
    
    func testFetchAllWineTastings() throws {
        let _ = wineTastingService.add(date: newWineTasting.date, winery: newWineTasting.winery)
        
        let _ = wineTastingService.add(date: secondWineTasting.date, winery: secondWineTasting.winery)
        
        let wineTastings = wineTastingService.getWineTastings()
        
        XCTAssertEqual(wineTastings?.count, 2)
    }
    
    func testFetchSingleWineTasting() throws {
        let wineTasting1 = wineTastingService.add(date: newWineTasting.date, winery: newWineTasting.winery)
        
        let wineTasting2 = wineTastingService.add(date: secondWineTasting.date, winery: secondWineTasting.winery)
        
        let fetchedWineTasting1 = wineTastingService.getWineTasting(with: wineTasting1.objectID)
        let fetchedWineTasting2 = wineTastingService.getWineTasting(with: wineTasting2.objectID)
        
        XCTAssertEqual(fetchedWineTasting1?.winery, "Test Winery")
        XCTAssertEqual(fetchedWineTasting2?.winery, "Second Winery")
    }
    
    func testUpdateWineTasting() throws {
        let wineTasting = wineTastingService.add(date: newWineTasting.date, winery: newWineTasting.winery)
        
        wineTasting.winery = "Updated Winery"
        let updatedWineTasting = wineTastingService.update(wineTasting)
        XCTAssertEqual(updatedWineTasting.winery, "Updated Winery")
    }
    
    func testDeleteWineTasting() {
        let wineTasting1 = wineTastingService.add(date: newWineTasting.date, winery: newWineTasting.winery)
        
        var fetchedWineTastings = wineTastingService.getWineTastings()
        XCTAssertEqual(fetchedWineTastings?.count, 1)
        
        let fetchedWineTasting = wineTastingService.getWineTasting(with: wineTasting1.objectID)
        wineTastingService.delete(fetchedWineTasting!)
        
        fetchedWineTastings = wineTastingService.getWineTastings()
        
        XCTAssertEqual(fetchedWineTastings?.count, 0)
    }
}
