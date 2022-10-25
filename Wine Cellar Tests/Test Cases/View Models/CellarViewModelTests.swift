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
        
        cellarViewModel.fetchWines()
        cellarViewModel.$wines.sink { wines in
            XCTAssertEqual(wines.count, 1)
        }.store(in: &cancellables)
    }
}
