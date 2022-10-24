//
//  Wine_CellarTests.swift
//  Wine CellarTests
//
//  Created by Tim Bausch on 10/21/22.
//

import CoreData
@testable import Wine_Cellar
import XCTest

class WineTests: XCTestCase {

    var coreDataStack: CoreDataStack!
    var wineService: WineService!
    let newWine = WineBuilder().build()
    let secondWine = WineBuilder()
        .id(UUID())
        .company("Second Wine Company")
        .build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineService = WineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineService = nil
    }

    func testAddWineToCoreData() throws {
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
        
        XCTAssertEqual(wine.vintage, 2022)
    }
    
    func testFetchAllWines() throws {
        wineService.add(
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
        
        wineService.add(
            id: secondWine.id,
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue
        )
        
        let wines = wineService.getWines()
        
        XCTAssertEqual(wines?.count, 2)
    }
    
    func testFetchSingleWine() throws {
        wineService.add(
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
        
        wineService.add(
            id: secondWine.id,
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue
        )
        
        let wine1 = wineService.getWine(with: newWine.id)
        let wine2 = wineService.getWine(with: secondWine.id)
        
        XCTAssertEqual(wine1?.company, "Test Wine Company")
        XCTAssertEqual(wine2?.company, "Second Wine Company")
    }

    func testUpdateWine() throws {
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
        
        wine.company = "Updated Company"
        let updatedWine = wineService.update(wine)
        XCTAssertEqual(updatedWine.company, "Updated Company")
    }
    
    func testDeleteWine() {
        let _ = wineService.add(
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
        
        var fetchedWines = wineService.getWines()
        XCTAssertEqual(fetchedWines?.count, 1)
        
        let fetchedWine = wineService.getWine(with: newWine.id)
        wineService.delete(fetchedWine!)
        
        fetchedWines = wineService.getWines()
        
        XCTAssertEqual(fetchedWines?.count, 0)
    }
}
