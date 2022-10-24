//
//  VineyardTests.swift
//  Wine CellarTests
//
//  Created by Tim Bausch on 10/23/22.
//

import CoreData
@testable import Wine_Cellar
import XCTest

final class VisualDetailsTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var visualDetailsService: VisualDetailsService!
    let newVisualDetails = VisualDetailsBuilder().build()
    let secondVisualDetails = VisualDetailsBuilder()
        .viscosity(Constants.ViscosityLevel.high)
        .build()
    
    override func setUpWithError() throws {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        visualDetailsService = VisualDetailsService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        coreDataStack = nil
        visualDetailsService = nil
    }
    
    func testAddVisualDetails() throws {
        let visualDetails = visualDetailsService.add(color: newVisualDetails.Color, viscosity: newVisualDetails.viscosity.rawValue, clarity: newVisualDetails.clarity.rawValue)
        XCTAssertEqual(visualDetails.viscosity, 3)
    }
    
    func testGetAllVisualDetails() throws {
        let _ = visualDetailsService.add(color: newVisualDetails.Color, viscosity: newVisualDetails.viscosity.rawValue, clarity: newVisualDetails.clarity.rawValue)
        let _ = visualDetailsService.add(color: secondVisualDetails.Color, viscosity: secondVisualDetails.viscosity.rawValue, clarity: secondVisualDetails.clarity.rawValue)
        let visualDetails = visualDetailsService.getVisualDetails()
        XCTAssertEqual(visualDetails?.count, 2)
    }

    func testGetSingleVisualDetail() throws {
        let detail1 = visualDetailsService.add(color: newVisualDetails.Color, viscosity: newVisualDetails.viscosity.rawValue, clarity: newVisualDetails.clarity.rawValue)
        let detail2 = visualDetailsService.add(color: secondVisualDetails.Color, viscosity: secondVisualDetails.viscosity.rawValue, clarity: secondVisualDetails.clarity.rawValue)
        
        let visualDetails1 = visualDetailsService.getVisualDetails(with: detail1.objectID)
        let visualDetails2 = visualDetailsService.getVisualDetails(with: detail2.objectID)
        XCTAssertEqual(visualDetails1?.viscosity, 3)
        XCTAssertEqual(visualDetails2?.viscosity, 2)
    }

    func testUpdateVisualDetails() throws {
        let detail = visualDetailsService.add(color: newVisualDetails.Color, viscosity: newVisualDetails.viscosity.rawValue, clarity: newVisualDetails.clarity.rawValue)
        let oldVisualDetails = visualDetailsService.getVisualDetails(with: detail.objectID)
        XCTAssertEqual(oldVisualDetails?.viscosity, 3)

        let updatedVisualDetails = visualDetailsService.getVisualDetails(with: detail.objectID)
        updatedVisualDetails?.viscosity = 2
        visualDetailsService.update(updatedVisualDetails!)

        let newVisualDetails = visualDetailsService.getVisualDetails(with: detail.objectID)
        XCTAssertEqual(newVisualDetails?.viscosity, 2)
    }

    func testDeleteVineyard() throws {
        let _ = visualDetailsService.add(color: newVisualDetails.Color, viscosity: newVisualDetails.viscosity.rawValue, clarity: newVisualDetails.clarity.rawValue)
        let detail2 = visualDetailsService.add(color: secondVisualDetails.Color, viscosity: secondVisualDetails.viscosity.rawValue, clarity: secondVisualDetails.clarity.rawValue)

        var visualDetails = visualDetailsService.getVisualDetails()
        XCTAssertEqual(visualDetails?.count, 2)

        let visualDetailsToDelete = visualDetailsService.getVisualDetails(with: detail2.objectID)
        visualDetailsService.delete(visualDetailsToDelete!)
        visualDetails = visualDetailsService.getVisualDetails()
        XCTAssertEqual(visualDetails?.count, 1)
        XCTAssertEqual(visualDetails?[0].viscosity, 3)
    }
    
}
