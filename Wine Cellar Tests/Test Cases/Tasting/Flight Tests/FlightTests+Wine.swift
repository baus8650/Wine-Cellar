import CoreData
@testable import Wine_Cellar
import XCTest

class FlightTests_Wine: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var flightService: FlightService!
    var wineService: WineService!
    let flight = FlightBuilder().build()
    
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        flightService = FlightService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        wineService = WineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        flightService = nil
        wineService = nil
    }
    
    func testAddSingleWineToFlight() throws {
        let flight = flightService.add(numberOfWines: flight.numberOfWines)
        
        let newWine = WineBuilder().build()
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
        
        
        let flightWithWine = flightService.addSingleWine(wine, to: flight)
        XCTAssertEqual(flight.wines?.count, 1)
        XCTAssertEqual(flight.wines?.contains(wine), true)
    }
    
    func testAddMultipleWinesToFlight() throws {
        let flight = flightService.add(numberOfWines: flight.numberOfWines)
        
        let newWine1 = WineBuilder().build()
        let newWine2 = WineBuilder()
            .company("Second Wine")
            .build()
        let wine1 = wineService.add(
            abv: newWine1.abv,
            ava: newWine1.ava ?? "",
            company: newWine1.company,
            isFavorited: newWine1.isFavorited,
            numberOwned: Int16(newWine1.numberOwned),
            type: newWine1.type.rawValue,
            varietal: newWine1.varietal.rawValue,
            vintage: Int16(newWine1.vintage),
            wineColor: newWine1.wineColor.rawValue
        )
        
        let wine2 = wineService.add(
            abv: newWine2.abv,
            ava: newWine2.ava ?? "",
            company: newWine2.company,
            isFavorited: newWine2.isFavorited,
            numberOwned: Int16(newWine2.numberOwned),
            type: newWine2.type.rawValue,
            varietal: newWine2.varietal.rawValue,
            vintage: Int16(newWine2.vintage),
            wineColor: newWine2.wineColor.rawValue
        )
        
        
        let flightWithWine = flightService.addMultipleWine([wine1, wine2], to: flight)
        XCTAssertEqual(flight.wines?.count, 2)
        XCTAssertEqual(flight.wines?.contains(wine1), true)
        XCTAssertEqual(flight.wines?.contains(wine2), true)
    }
    
    func testRemoveSingleWineFromFlight() throws {
        let flight = flightService.add(numberOfWines: flight.numberOfWines)
        
        let newWine = WineBuilder().build()
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
        
        
        let flightWithWine = flightService.addSingleWine(wine, to: flight)
        XCTAssertEqual(flight.wines?.count, 1)
        
        flightService.removeSingleWine(wine, from: flight)
        XCTAssertEqual(flight.wines?.count, 0)
    }
    
    func testRemoveSingleWineFromFlightWithMultipleWines() throws {
        let flight = flightService.add(numberOfWines: flight.numberOfWines)
        
        let newWine1 = WineBuilder().build()
        let newWine2 = WineBuilder()
            .company("Second Wine")
            .build()
        let wine1 = wineService.add(
            abv: newWine1.abv,
            ava: newWine1.ava ?? "",
            company: newWine1.company,
            isFavorited: newWine1.isFavorited,
            numberOwned: Int16(newWine1.numberOwned),
            type: newWine1.type.rawValue,
            varietal: newWine1.varietal.rawValue,
            vintage: Int16(newWine1.vintage),
            wineColor: newWine1.wineColor.rawValue
        )
        
        let wine2 = wineService.add(
            abv: newWine2.abv,
            ava: newWine2.ava ?? "",
            company: newWine2.company,
            isFavorited: newWine2.isFavorited,
            numberOwned: Int16(newWine2.numberOwned),
            type: newWine2.type.rawValue,
            varietal: newWine2.varietal.rawValue,
            vintage: Int16(newWine2.vintage),
            wineColor: newWine2.wineColor.rawValue
        )
        
        
        let flightWithWine = flightService.addMultipleWine([wine1, wine2], to: flight)
        XCTAssertEqual(flight.wines?.count, 2)
        XCTAssertEqual(flight.wines?.contains(wine1), true)
        XCTAssertEqual(flight.wines?.contains(wine2), true)
        
        flightService.removeSingleWine(wine1, from: flight)
        XCTAssertEqual(flight.wines?.count, 1)
        XCTAssertEqual(flight.wines?.contains(wine1), false)
        XCTAssertEqual(flight.wines?.contains(wine2), true)
    }
    
    func testRemoveMultipleWinesFromFlightWithMultipleWines() throws {
        let flight = flightService.add(numberOfWines: flight.numberOfWines)
        
        let newWine1 = WineBuilder().build()
        let newWine2 = WineBuilder()
            .company("Second Wine")
            .build()
        let wine1 = wineService.add(
            abv: newWine1.abv,
            ava: newWine1.ava ?? "",
            company: newWine1.company,
            isFavorited: newWine1.isFavorited,
            numberOwned: Int16(newWine1.numberOwned),
            type: newWine1.type.rawValue,
            varietal: newWine1.varietal.rawValue,
            vintage: Int16(newWine1.vintage),
            wineColor: newWine1.wineColor.rawValue
        )
        
        let wine2 = wineService.add(
            abv: newWine2.abv,
            ava: newWine2.ava ?? "",
            company: newWine2.company,
            isFavorited: newWine2.isFavorited,
            numberOwned: Int16(newWine2.numberOwned),
            type: newWine2.type.rawValue,
            varietal: newWine2.varietal.rawValue,
            vintage: Int16(newWine2.vintage),
            wineColor: newWine2.wineColor.rawValue
        )
        
        
        let flightWithWine = flightService.addMultipleWine([wine1, wine2], to: flight)
        XCTAssertEqual(flight.wines?.count, 2)
        XCTAssertEqual(flight.wines?.contains(wine1), true)
        XCTAssertEqual(flight.wines?.contains(wine2), true)
        
        flightService.removeMultipleWine([wine1, wine2], from: flight)
        XCTAssertEqual(flight.wines?.count, 0)
    }
}
