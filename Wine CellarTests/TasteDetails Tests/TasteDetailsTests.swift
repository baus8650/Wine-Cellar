//
//  VineyardTests.swift
//  Wine CellarTests
//
//  Created by Tim Bausch on 10/23/22.
//

import CoreData
@testable import Wine_Cellar
import XCTest

final class TasteDetailsTest: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var tasteDetailsService: TasteDetailsService!
    let newTasteDetails = TasteDetailsBuilder().build()
    let secondTasteDetails = TasteDetailsBuilder()
        .body(Constants.WineBody.light)
        .build()
    
    override func setUpWithError() throws {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        tasteDetailsService = TasteDetailsService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        coreDataStack = nil
        tasteDetailsService = nil
    }
    
    func testAddTasteDetails() throws {
        let tasteDetails = tasteDetailsService.add(body: newTasteDetails.body.rawValue, sweetness: newTasteDetails.sweetness.rawValue, alcohol: newTasteDetails.alcohol.rawValue, acidityLevel: newTasteDetails.acidityLevel.rawValue, tanninLevel: newTasteDetails.tanninLevel.rawValue)
        XCTAssertEqual(tasteDetails.body, 3)
    }
    
    func testGetAllTasteDetails() throws {
        let _ = tasteDetailsService.add(body: newTasteDetails.body.rawValue, sweetness: newTasteDetails.sweetness.rawValue, alcohol: newTasteDetails.alcohol.rawValue, acidityLevel: newTasteDetails.acidityLevel.rawValue, tanninLevel: newTasteDetails.tanninLevel.rawValue)
        let _ = tasteDetailsService.add(body: secondTasteDetails.body.rawValue, sweetness: secondTasteDetails.sweetness.rawValue, alcohol: secondTasteDetails.alcohol.rawValue, acidityLevel: secondTasteDetails.acidityLevel.rawValue, tanninLevel: secondTasteDetails.tanninLevel.rawValue)
        let tasteDetails = tasteDetailsService.getTasteDetails()
        XCTAssertEqual(tasteDetails?.count, 2)
    }
    
    func testGetSingleTasteDetail() throws {
        let tasteDetails1 = tasteDetailsService.add(
            body: newTasteDetails.body.rawValue,
            sweetness: newTasteDetails.sweetness.rawValue,
            alcohol: newTasteDetails.alcohol.rawValue,
            acidityLevel: newTasteDetails.acidityLevel.rawValue,
            tanninLevel: newTasteDetails.tanninLevel.rawValue)
        let tasteDetails2 = tasteDetailsService.add(
            body: secondTasteDetails.body.rawValue,
            sweetness: secondTasteDetails.sweetness.rawValue,
            alcohol: secondTasteDetails.alcohol.rawValue,
            acidityLevel: secondTasteDetails.acidityLevel.rawValue,
            tanninLevel: secondTasteDetails.tanninLevel.rawValue)
        
        let fetchedTasteDetails1 = tasteDetailsService.getTasteDetails(with: tasteDetails1.objectID)
        let fetchedTasteDetails2 = tasteDetailsService.getTasteDetails(with: tasteDetails2.objectID)
        XCTAssertEqual(fetchedTasteDetails1?.body, 3)
        XCTAssertEqual(fetchedTasteDetails2?.body, 0)
    }
    
    func testUpdateTasteDetails() throws {
        let tasteDetails1 = tasteDetailsService.add(body: newTasteDetails.body.rawValue, sweetness: newTasteDetails.sweetness.rawValue, alcohol: newTasteDetails.alcohol.rawValue, acidityLevel: newTasteDetails.acidityLevel.rawValue, tanninLevel: newTasteDetails.tanninLevel.rawValue)
        let oldTasteDetails = tasteDetailsService.getTasteDetails(with: tasteDetails1.objectID)
        XCTAssertEqual(oldTasteDetails?.body, 3)
        
        let updatedTasteDetails = tasteDetailsService.getTasteDetails(with: tasteDetails1.objectID)
        updatedTasteDetails?.body = 2
        tasteDetailsService.update(updatedTasteDetails!)
        
        let newTasteDetails = tasteDetailsService.getTasteDetails(with: tasteDetails1.objectID)
        XCTAssertEqual(newTasteDetails?.body, 2)
    }
    
    func testDeleteTasteDetails() throws {
        let _ = tasteDetailsService.add(body: newTasteDetails.body.rawValue, sweetness: newTasteDetails.sweetness.rawValue, alcohol: newTasteDetails.alcohol.rawValue, acidityLevel: newTasteDetails.acidityLevel.rawValue, tanninLevel: newTasteDetails.tanninLevel.rawValue)
        let tasteDetails2 = tasteDetailsService.add(body: secondTasteDetails.body.rawValue, sweetness: secondTasteDetails.sweetness.rawValue, alcohol: secondTasteDetails.alcohol.rawValue, acidityLevel: secondTasteDetails.acidityLevel.rawValue, tanninLevel: secondTasteDetails.tanninLevel.rawValue)
        
        var tasteDetails = tasteDetailsService.getTasteDetails()
        XCTAssertEqual(tasteDetails?.count, 2)
        
        let tasteDetailsToDelete = tasteDetailsService.getTasteDetails(with: tasteDetails2.objectID)
        tasteDetailsService.delete(tasteDetailsToDelete!)
        tasteDetails = tasteDetailsService.getTasteDetails()
        XCTAssertEqual(tasteDetails?.count, 1)
        XCTAssertEqual(tasteDetails?[0].body, 3)
    }
    
}
