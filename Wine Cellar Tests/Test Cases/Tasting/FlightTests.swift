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
        .numberOfWines("5")
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
        let flight = flightService.add(
            abv: newFlight.abv,
            ava: newFlight.ava ?? "",
            company: newFlight.company,
            isFavorited: newFlight.isFavorited,
            numberOwned: Int16(newFlight.numberOwned),
            type: newFlight.type.rawValue,
            varietal: newFlight.varietal.rawValue,
            vintage: Int16(newFlight.vintage),
            flightColor: newFlight.flightColor.rawValue
        )
        
        XCTAssertEqual(flight.vintage, 2022)
    }
    
    func testFetchAllFlights() throws {
        flightService.add(
            abv: newFlight.abv,
            ava: newFlight.ava ?? "",
            company: newFlight.company,
            isFavorited: newFlight.isFavorited,
            numberOwned: Int16(newFlight.numberOwned),
            type: newFlight.type.rawValue,
            varietal: newFlight.varietal.rawValue,
            vintage: Int16(newFlight.vintage),
            flightColor: newFlight.flightColor.rawValue
        )
        
        flightService.add(
            abv: secondFlight.abv,
            ava: secondFlight.ava ?? "",
            company: secondFlight.company,
            isFavorited: secondFlight.isFavorited,
            numberOwned: Int16(secondFlight.numberOwned),
            type: secondFlight.type.rawValue,
            varietal: secondFlight.varietal.rawValue,
            vintage: Int16(secondFlight.vintage),
            flightColor: secondFlight.flightColor.rawValue
        )
        
        let flights = flightService.getFlights()
        
        XCTAssertEqual(flights?.count, 2)
    }
    
    func testFetchSingleFlight() throws {
        let flight1 = flightService.add(
            abv: newFlight.abv,
            ava: newFlight.ava ?? "",
            company: newFlight.company,
            isFavorited: newFlight.isFavorited,
            numberOwned: Int16(newFlight.numberOwned),
            type: newFlight.type.rawValue,
            varietal: newFlight.varietal.rawValue,
            vintage: Int16(newFlight.vintage),
            flightColor: newFlight.flightColor.rawValue
        )
        
        let flight2 = flightService.add(
            abv: secondFlight.abv,
            ava: secondFlight.ava ?? "",
            company: secondFlight.company,
            isFavorited: secondFlight.isFavorited,
            numberOwned: Int16(secondFlight.numberOwned),
            type: secondFlight.type.rawValue,
            varietal: secondFlight.varietal.rawValue,
            vintage: Int16(secondFlight.vintage),
            flightColor: secondFlight.flightColor.rawValue
        )
        
        let fetchedFlight1 = flightService.getFlight(with: flight1.objectID)
        let fetchedFlight2 = flightService.getFlight(with: flight2.objectID)
        
        XCTAssertEqual(fetchedFlight1?.company, "Test Flight Company")
        XCTAssertEqual(fetchedFlight2?.company, "Second Flight Company")
    }
    
    func testUpdateFlight() throws {
        let flight = flightService.add(
            abv: newFlight.abv,
            ava: newFlight.ava ?? "",
            company: newFlight.company,
            isFavorited: newFlight.isFavorited,
            numberOwned: Int16(newFlight.numberOwned),
            type: newFlight.type.rawValue,
            varietal: newFlight.varietal.rawValue,
            vintage: Int16(newFlight.vintage),
            flightColor: newFlight.flightColor.rawValue
        )
        
        flight.company = "Updated Company"
        let updatedFlight = flightService.update(flight)
        XCTAssertEqual(updatedFlight.company, "Updated Company")
    }
    
    func testDeleteFlight() {
        let flight1 = flightService.add(
            abv: newFlight.abv,
            ava: newFlight.ava ?? "",
            company: newFlight.company,
            isFavorited: newFlight.isFavorited,
            numberOwned: Int16(newFlight.numberOwned),
            type: newFlight.type.rawValue,
            varietal: newFlight.varietal.rawValue,
            vintage: Int16(newFlight.vintage),
            flightColor: newFlight.flightColor.rawValue
        )
        
        var fetchedFlights = flightService.getFlights()
        XCTAssertEqual(fetchedFlights?.count, 1)
        
        let fetchedFlight = flightService.getFlight(with: flight1.objectID)
        flightService.delete(fetchedFlight!)
        
        fetchedFlights = flightService.getFlights()
        
        XCTAssertEqual(fetchedFlights?.count, 0)
    }
}
