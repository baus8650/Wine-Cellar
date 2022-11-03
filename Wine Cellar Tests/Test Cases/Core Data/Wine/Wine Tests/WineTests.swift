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
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        XCTAssertEqual(wine.vintage, 2022)
    }
    
    func testFetchAllWinesWithDefaultDateDescending() throws {
        wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            dateAdded:Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue)

        let wines = wineService.getWines()
        XCTAssertEqual(wines?.count, 2)
        XCTAssertEqual(wines?.first!.company, "Test Wine Company")
    }
    
    func testFetchAllWinesSortedByDateAscending() throws {
        wineService.add(
            dateAdded: Date(),
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            dateAdded: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue)
        
        let wines = wineService.getWines(with: .dateAscending)
        XCTAssertEqual(wines?.count, 2)
        XCTAssertEqual(wines?.first!.company, "Second Wine Company")
    }
    
    func testFetchAllWinesSortedByABVAscending() throws {
        wineService.add(
            dateAdded: Date(),
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            dateAdded: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            abv: Float(80),
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue)
        
        let wines = wineService.getWines(with: .abvAscending)
        XCTAssertEqual(wines?.count, 2)
        XCTAssertEqual(wines?.first!.company, "Test Wine Company")
    }
    
    func testFetchAllWinesSortedByABVDescending() throws {
        wineService.add(
            dateAdded: Date(),
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            dateAdded: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            abv: Float(80),
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue)
        
        let wines = wineService.getWines(with: .abvDescending)
        XCTAssertEqual(wines?.count, 2)
        XCTAssertEqual(wines?.first!.company, "Second Wine Company")
    }
    
    func testFetchAllWinesSortedByCompanyAscending() throws {
        wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue)
        
        let wines = wineService.getWines(with: .companyAscending)
        XCTAssertEqual(wines?.count, 2)
        XCTAssertEqual(wines?.first!.company, "Second Wine Company")
    }
    
    func testFetchAllWinesSortedByCompanyDescending() throws {
        wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue)
        
        let wines = wineService.getWines(with: .companyDescending)
        XCTAssertEqual(wines?.count, 2)
        XCTAssertEqual(wines?.first!.company, "Test Wine Company")
    }
    
    func testFetchAllWinesSortedByVarietalAscending() throws {
        wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: Constants.Varietal.chardonnay.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue)
        
        let wines = wineService.getWines(with: .varietalAscending)
        XCTAssertEqual(wines?.count, 2)
        XCTAssertEqual(wines?.first!.varietal, "Chardonnay")
    }
    
    func testFetchAllWinesSortedByVarietalDescending() throws {
        wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: Constants.Varietal.chardonnay.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue)
        
        let wines = wineService.getWines(with: .varietalDescending)
        XCTAssertEqual(wines?.count, 2)
        XCTAssertEqual(wines?.first!.varietal, "Pinot Noir")
    }
    
    func testFetchAllWinesSortedByVintageAscending() throws {
        wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(2000),
            wineColor: secondWine.wineColor.rawValue)
        
        let wines = wineService.getWines(with: .vintageAscending)
        XCTAssertEqual(wines?.count, 2)
        XCTAssertEqual(wines?.first!.vintage, Int16(2000))
    }
    
    func testFetchAllWinesSortedByVintageDescending() throws {
        wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(2000),
            wineColor: secondWine.wineColor.rawValue)
        
        let wines = wineService.getWines(with: .vintageDescending)
        XCTAssertEqual(wines?.count, 2)
        XCTAssertEqual(wines?.first!.vintage, Int16(2022))
    }
    
    func testFilterWinesForStillWinesOnly() throws {
        wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: Constants.WineType.sparkling.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue)
        
        let wines = wineService.getWines(filteredFor: .stillOnly)
        XCTAssertEqual(wines?.count, 1)
        XCTAssertEqual(wines?.first!.type, "Still")
    }
    
    func testFilterWinesForSparklingWinesOnly() throws {
        wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wineService.add(
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: Constants.WineType.sparkling.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue)
        
        let wines = wineService.getWines(filteredFor: .sparklingOnly)
        XCTAssertEqual(wines?.count, 1)
        XCTAssertEqual(wines?.first!.type, "Sparkling")
    }
    
    func testFetchSingleWine() throws {
        let wine1 = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        let wine2 = wineService.add(
            abv: secondWine.abv,
            ava: secondWine.ava ?? "",
            company: secondWine.company,
            isFavorited: secondWine.isFavorited,
            numberOwned: Int16(secondWine.numberOwned),
            type: secondWine.type.rawValue,
            varietal: secondWine.varietal.rawValue,
            vintage: Int16(secondWine.vintage),
            wineColor: secondWine.wineColor.rawValue)
        
        let fetchedWine1 = wineService.getWine(with: wine1.objectID)
        XCTAssertEqual(fetchedWine1?.company, "Test Wine Company")
        let fetchedWine2 = wineService.getWine(with: wine2.objectID)
        XCTAssertEqual(fetchedWine2?.company, "Second Wine Company")
    }

    func testUpdateWine() throws {
        let wine = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        wine.company = "Updated Company"
        
        let updatedWine = wineService.update(wine)
        XCTAssertEqual(updatedWine.company, "Updated Company")
    }
    
    func testDeleteWine() {
        let wine1 = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue)
        
        var fetchedWines = wineService.getWines()
        XCTAssertEqual(fetchedWines?.count, 1)
        
        let fetchedWine = wineService.getWine(with: wine1.objectID)
        
        wineService.delete(fetchedWine!)       
        fetchedWines = wineService.getWines()
        XCTAssertEqual(fetchedWines?.count, 0)
    }
}
