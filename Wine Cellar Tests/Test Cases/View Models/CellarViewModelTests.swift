//
//  CellarViewModelTests.swift
//  Wine CellarTests
//
//  Created by Tim Bausch on 10/25/22.
//
import Combine
import CoreData
@testable import Wine_Cellar
import XCTest

final class CellarViewModelTests: XCTestCase {

    var coreDataStack: CoreDataStack!
    var cellarViewModel: CellarViewModel!
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        cellarViewModel = CellarViewModel(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        coreDataStack = nil
        cellarViewModel = nil
    }

    func testAddAndPopulateWines() throws {
        let newWine = WineBuilder().build()
        cellarViewModel.addWine(abv: newWine.abv, ava: newWine.ava!, company: newWine.company, isFavorited: newWine.isFavorited, numberOwned: Int16(newWine.numberOwned), type: newWine.type.rawValue, varietal: newWine.varietal.rawValue, vintage: Int16(newWine.vintage), wineColor: newWine.wineColor.rawValue)
        
        cellarViewModel.$wines.sink { wines in
            XCTAssertEqual(wines.count, 1)
        }.store(in: &cancellables)
    }
    
    func testDeleteSingleWine() throws {
        var wineList = [Wine]()
        var wineToDelete: Wine? = nil
        var wineToKeep: Wine? = nil
        let newWine1 = WineBuilder().build()
        cellarViewModel.addWine(abv: newWine1.abv, ava: newWine1.ava!, company: newWine1.company, isFavorited: newWine1.isFavorited, numberOwned: Int16(newWine1.numberOwned), type: newWine1.type.rawValue, varietal: newWine1.varietal.rawValue, vintage: Int16(newWine1.vintage), wineColor: newWine1.wineColor.rawValue)
        
        let newWine2 = WineBuilder().build()
        cellarViewModel.addWine(abv: newWine2.abv, ava: newWine2.ava!, company: newWine2.company, isFavorited: newWine2.isFavorited, numberOwned: Int16(newWine2.numberOwned), type: newWine2.type.rawValue, varietal: newWine2.varietal.rawValue, vintage: Int16(newWine2.vintage), wineColor: newWine2.wineColor.rawValue)
        
        cellarViewModel.$wines.sink { wines in
            wineList = wines
        }.store(in: &cancellables)
        XCTAssertEqual(wineList.count, 2)
        
        wineToDelete = wineList.first!
        wineToKeep = wineList.last!
        cellarViewModel.deleteSingle(wineToDelete!)
        XCTAssertEqual(wineList.count, 1)
        XCTAssertEqual(wineList.first!.objectID, wineToKeep!.objectID)
    }
    
    func testDeleteMultipleWines() throws {
        var wineList = [Wine]()
        let newWine1 = WineBuilder().build()
        cellarViewModel.addWine(abv: newWine1.abv, ava: newWine1.ava!, company: newWine1.company, isFavorited: newWine1.isFavorited, numberOwned: Int16(newWine1.numberOwned), type: newWine1.type.rawValue, varietal: newWine1.varietal.rawValue, vintage: Int16(newWine1.vintage), wineColor: newWine1.wineColor.rawValue)
        
        let newWine2 = WineBuilder().build()
        cellarViewModel.addWine(abv: newWine2.abv, ava: newWine2.ava!, company: newWine2.company, isFavorited: newWine2.isFavorited, numberOwned: Int16(newWine2.numberOwned), type: newWine2.type.rawValue, varietal: newWine2.varietal.rawValue, vintage: Int16(newWine2.vintage), wineColor: newWine2.wineColor.rawValue)
        
        cellarViewModel.$wines.sink { wines in
            wineList = wines
        }.store(in: &cancellables)
        
        XCTAssertEqual(wineList.count, 2)
        
        cellarViewModel.deleteMultiple(wineList)
        
        XCTAssertEqual(wineList.count, 0)
    }
}
