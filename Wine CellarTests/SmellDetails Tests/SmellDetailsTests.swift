//
//  VineyardTests.swift
//  Wine CellarTests
//
//  Created by Tim Bausch on 10/23/22.
//

import CoreData
@testable import Wine_Cellar
import XCTest

final class SmellDetailsTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var smellDetailsService: SmellDetailsService!
    let newSmellDetails = SmellDetailsBuilder().build()
    let secondSmellDetails = SmellDetailsBuilder()
        .id(UUID())
        .primaryAroma(["Second Primary Aroma"])
        .build()
    
    override func setUpWithError() throws {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        smellDetailsService = SmellDetailsService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        coreDataStack = nil
        smellDetailsService = nil
    }
    
    func testAddVineyard() throws {
        let smellDetails = smellDetailsService.add(id: newSmellDetails.id, date: newSmellDetails.date, primaryAroma: newSmellDetails.primaryAroma!, secondaryAroma: newSmellDetails.secondaryAroma!, tertiaryAroma: newSmellDetails.tertiaryAroma!)
        XCTAssertEqual(smellDetails.primaryAroma, ["Primary Aroma"])
    }
    
    func testGetAllVineyards() throws {
        let _ = smellDetailsService.add(id: newSmellDetails.id, date: newSmellDetails.date, primaryAroma: newSmellDetails.primaryAroma!, secondaryAroma: newSmellDetails.secondaryAroma!, tertiaryAroma: newSmellDetails.tertiaryAroma!)
        let _ = smellDetailsService.add(id: secondSmellDetails.id, date: secondSmellDetails.date, primaryAroma: secondSmellDetails.primaryAroma!, secondaryAroma: secondSmellDetails.secondaryAroma!, tertiaryAroma: secondSmellDetails.tertiaryAroma!)
        let smellDetails = smellDetailsService.getSmellDetails()
        XCTAssertEqual(smellDetails?.count, 2)
    }
    
    func testGetSingleVineyard() throws {
        let _ = smellDetailsService.add(id: newSmellDetails.id, date: newSmellDetails.date, primaryAroma: newSmellDetails.primaryAroma!, secondaryAroma: newSmellDetails.secondaryAroma!, tertiaryAroma: newSmellDetails.tertiaryAroma!)
        let _ = smellDetailsService.add(id: secondSmellDetails.id, date: secondSmellDetails.date, primaryAroma: secondSmellDetails.primaryAroma!, secondaryAroma: secondSmellDetails.secondaryAroma!, tertiaryAroma: secondSmellDetails.tertiaryAroma!)
        let smellDetails = smellDetailsService.getSmellDetails()
        let smellDetails1 = smellDetailsService.getSmellDetails(with: newSmellDetails.id)
        let smellDetails2 = smellDetailsService.getSmellDetails(with: secondSmellDetails.id)
        XCTAssertEqual(smellDetails1?.primaryAroma, ["Primary Aroma"])
        XCTAssertEqual(smellDetails2?.primaryAroma, ["Second Primary Aroma"])
    }
    
    func testUpdateVineyard() throws {
        let _ = smellDetailsService.add(id: newSmellDetails.id, date: newSmellDetails.date, primaryAroma: newSmellDetails.primaryAroma!, secondaryAroma: newSmellDetails.secondaryAroma!, tertiaryAroma: newSmellDetails.tertiaryAroma!)
        let oldSmellDetails = smellDetailsService.getSmellDetails(with: newSmellDetails.id)
        XCTAssertEqual(oldSmellDetails?.primaryAroma, ["Primary Aroma"])
        
        let updatedSmellDetails = smellDetailsService.getSmellDetails(with: newSmellDetails.id)
        updatedSmellDetails?.primaryAroma = ["Updated Primary Aroma"]
        smellDetailsService.update(updatedSmellDetails!)
        
        let newSmellDetails = smellDetailsService.getSmellDetails(with: newSmellDetails.id)
        XCTAssertEqual(newSmellDetails?.primaryAroma, ["Updated Primary Aroma"])
    }
    
    func testDeleteVineyard() throws {
        let _ = smellDetailsService.add(id: newSmellDetails.id, date: newSmellDetails.date, primaryAroma: newSmellDetails.primaryAroma!, secondaryAroma: newSmellDetails.secondaryAroma!, tertiaryAroma: newSmellDetails.tertiaryAroma!)
        let _ = smellDetailsService.add(id: secondSmellDetails.id, date: secondSmellDetails.date, primaryAroma: secondSmellDetails.primaryAroma!, secondaryAroma: secondSmellDetails.secondaryAroma!, tertiaryAroma: secondSmellDetails.tertiaryAroma!)
        
        var smellDetails = smellDetailsService.getSmellDetails()
        XCTAssertEqual(smellDetails?.count, 2)
        
        let smellDetailsToDelete = smellDetailsService.getSmellDetails(with: secondSmellDetails.id)
        smellDetailsService.delete(smellDetailsToDelete!)
        smellDetails = smellDetailsService.getSmellDetails()
        XCTAssertEqual(smellDetails?.count, 1)
        XCTAssertEqual(smellDetails?[0].primaryAroma, ["Primary Aroma"])
    }
    
}
