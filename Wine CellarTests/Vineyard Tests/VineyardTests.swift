//
//  VineyardTests.swift
//  Wine CellarTests
//
//  Created by Tim Bausch on 10/23/22.
//

import CoreData
@testable import Wine_Cellar
import XCTest

final class VineyardTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var vineyardService: VineyardService!
    let newVineyard = VineyardBuilder().build()
    let secondVineyard = VineyardBuilder()
        .id(UUID())
        .name("Second Vineyard")
        .build()

    override func setUpWithError() throws {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        vineyardService = VineyardService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        coreDataStack = nil
        vineyardService = nil
    }

    func testAddVineyard() throws {
        let vineyard = vineyardService.add(id: newVineyard.id, name: newVineyard.name, address: newVineyard.address, latitude: newVineyard.latitude!, longitude: newVineyard.longitude!)
        XCTAssertEqual(vineyard.name, "Test Vineyard")
    }
    
    func testGetAllVineyards() throws {
        let _ = vineyardService.add(id: newVineyard.id, name: newVineyard.name, address: newVineyard.address, latitude: newVineyard.latitude!, longitude: newVineyard.longitude!)
        let _ = vineyardService.add(id: secondVineyard.id, name: secondVineyard.name, address: secondVineyard.address, latitude: secondVineyard.latitude!, longitude: secondVineyard.longitude!)
        let vineyards = vineyardService.getVineyards()
        XCTAssertEqual(vineyards?.count, 2)
    }
    
    func testGetSingleVineyard() throws {
        let _ = vineyardService.add(id: newVineyard.id, name: newVineyard.name, address: newVineyard.address, latitude: newVineyard.latitude!, longitude: newVineyard.longitude!)
        let _ = vineyardService.add(id: secondVineyard.id, name: secondVineyard.name, address: secondVineyard.address, latitude: secondVineyard.latitude!, longitude: secondVineyard.longitude!)
        let vineyard1 = vineyardService.getVineyard(with: newVineyard.id)
        let vineyard2 = vineyardService.getVineyard(with: secondVineyard.id)
        XCTAssertEqual(vineyard1?.name, "Test Vineyard")
        XCTAssertEqual(vineyard2?.name, "Second Vineyard")
    }
    
    func testUpdateVineyard() throws {
        let _ = vineyardService.add(id: newVineyard.id, name: newVineyard.name, address: newVineyard.address, latitude: newVineyard.latitude!, longitude: newVineyard.longitude!)
        let oldVineyard = vineyardService.getVineyard(with: newVineyard.id)
        XCTAssertEqual(oldVineyard?.name, "Test Vineyard")
        
        let updatedVineyard = vineyardService.getVineyard(with: newVineyard.id)
        updatedVineyard?.name = "Updated Name"
        vineyardService.update(updatedVineyard!)
        
        let newVineyard = vineyardService.getVineyard(with: newVineyard.id)
        XCTAssertEqual(newVineyard?.name, "Updated Name")
    }

    func testDeleteVineyard() throws {
        let _ = vineyardService.add(id: newVineyard.id, name: newVineyard.name, address: newVineyard.address, latitude: newVineyard.latitude!, longitude: newVineyard.longitude!)
        let _ = vineyardService.add(id: secondVineyard.id, name: secondVineyard.name, address: secondVineyard.address, latitude: secondVineyard.latitude!, longitude: secondVineyard.longitude!)
        
        var vineyards = vineyardService.getVineyards()
        XCTAssertEqual(vineyards?.count, 2)
        
        let wineToDelete = vineyardService.getVineyard(with: secondVineyard.id)
        vineyardService.delete(wineToDelete!)
        vineyards = vineyardService.getVineyards()
        XCTAssertEqual(vineyards?.count, 1)
        XCTAssertEqual(vineyards?[0].name, "Test Vineyard")
    }

}
