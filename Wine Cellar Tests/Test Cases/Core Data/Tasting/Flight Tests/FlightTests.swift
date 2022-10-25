//
//  Flight_CellarTests.swift
//  Flight CellarTests
//
//  Created by Tim Bausch on 10/21/22.
//

import CoreData
@testable import Wine_Cellar
import XCTest

class FlightTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var flightService: FlightService!
    let newFlight = FlightBuilder().build()
    let secondFlight = FlightBuilder()
        .numberOfWines(5)
        .build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        flightService = FlightService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        flightService = nil
    }
    
    func testAddFlightToCoreData() throws {
        let flight = flightService.add(numberOfWines: newFlight.numberOfWines)
        XCTAssertEqual(flight.numberOfWines, 1)
    }
    
    func testFetchAllFlights() throws {
        let _ = flightService.add(numberOfWines: newFlight.numberOfWines)
        let _ = flightService.add(numberOfWines: secondFlight.numberOfWines)
        
        let flights = flightService.getFlights()
        XCTAssertEqual(flights?.count, 2)
    }
    
    func testFetchSingleFlight() throws {
        let flight1 = flightService.add(numberOfWines: newFlight.numberOfWines)
        let flight2 = flightService.add(numberOfWines: secondFlight.numberOfWines)
        
        let fetchedFlight1 = flightService.getFlight(with: flight1.objectID)
        let fetchedFlight2 = flightService.getFlight(with: flight2.objectID)
        XCTAssertEqual(fetchedFlight1?.numberOfWines, 1)
        XCTAssertEqual(fetchedFlight2?.numberOfWines, 5)
    }
    
    func testUpdateFlight() throws {
        let flight = flightService.add(numberOfWines: newFlight.numberOfWines)
        flight.numberOfWines = 0
        
        let updatedFlight = flightService.update(flight)
        XCTAssertEqual(updatedFlight.numberOfWines, 0)
    }
    
    func testDeleteFlight() {
        let flight1 = flightService.add(numberOfWines: newFlight.numberOfWines)
        
        var fetchedFlights = flightService.getFlights()
        XCTAssertEqual(fetchedFlights?.count, 1)
        
        let fetchedFlight = flightService.getFlight(with: flight1.objectID)
        
        flightService.delete(fetchedFlight!)
        fetchedFlights = flightService.getFlights()
        XCTAssertEqual(fetchedFlights?.count, 0)
    }
}
