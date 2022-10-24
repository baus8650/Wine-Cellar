//
//  Wine_CellarTests.swift
//  Wine CellarTests
//
//  Created by Tim Bausch on 10/21/22.
//

import CoreData
@testable import Wine_Cellar
import XCTest

final class WineTests_Vineyard: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var wineService: WineService!
    var vineyardService: VineyardService!
    let newWine = WineBuilder().build()
    let secondWine = WineBuilder()
        .id(UUID())
        .company("Second Wine Company")
        .build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineService = WineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        vineyardService = VineyardService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineService = nil
        vineyardService = nil
    }
    
    func testAddVineyardToWine() throws {
        let vineyardToAdd = VineyardBuilder().build()
        let wine = wineService.add(
            id: newWine.id,
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
        
        let vineyard = vineyardService.add(id: vineyardToAdd.id, name: vineyardToAdd.name, address: vineyardToAdd.address, latitude: vineyardToAdd.latitude!, longitude: vineyardToAdd.longitude!)
        
        let wineWithVineyard = wineService.addVineyard(vineyard, to: wine)
        XCTAssertEqual(wineWithVineyard.vineyard?.name, "Test Vineyard")
    }
    
    func testRemoveVineyardFromWine() throws {
        let vineyardToAdd = VineyardBuilder().build()
        let wine = wineService.add(
            id: newWine.id,
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
        
        let vineyard = vineyardService.add(id: vineyardToAdd.id, name: vineyardToAdd.name, address: vineyardToAdd.address, latitude: vineyardToAdd.latitude!, longitude: vineyardToAdd.longitude!)
        
        let wineWithVineyard = wineService.addVineyard(vineyard, to: wine)
        XCTAssertEqual(wineWithVineyard.vineyard?.name, "Test Vineyard")
        
        let wineWithoutVineyard = wineService.removeVineyard(vineyard, from: wine)
        XCTAssertNil(wineWithoutVineyard.vineyard)
    }
}
