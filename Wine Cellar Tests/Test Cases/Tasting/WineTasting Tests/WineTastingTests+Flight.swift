import CoreData
@testable import Wine_Cellar
import XCTest

class WineTastingTests_Flight: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var wineTastingService: WineTastingService!
    var flightService: FlightService!
    let newWineTasting = WineTastingBuilder().build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineTastingService = WineTastingService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        flightService = FlightService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineTastingService = nil
        flightService = nil
    }
    
    func testAddFlightToWineTasting() throws {
        let wineTasting = wineTastingService.add(date: newWineTasting.date, winery: newWineTasting.winery)
        
        let newFlight = FlightBuilder().build()
        let flight = flightService.add(numberOfWines: newFlight.numberOfWines)
        
        let _ = wineTastingService.addFlight(flight, to: wineTasting)
        XCTAssertEqual(wineTasting.flight?.count, 1)
        XCTAssertEqual(wineTasting.flight?.contains(flight), true)
    }
    
    func testRemoveFlightFromWineTasting() throws {
        let wineTasting = wineTastingService.add(date: newWineTasting.date, winery: newWineTasting.winery)
        
        let newFlight = FlightBuilder().build()
        let flight = flightService.add(numberOfWines: newFlight.numberOfWines)
        
        let _ = wineTastingService.addFlight(flight, to: wineTasting)
        XCTAssertEqual(wineTasting.flight?.count, 1)
        XCTAssertEqual(wineTasting.flight?.contains(flight), true)
        
        let _ = wineTastingService.removeFlight(flight, from: wineTasting)
        
        XCTAssertEqual(wineTasting.flight?.count, 0)
    }
}
