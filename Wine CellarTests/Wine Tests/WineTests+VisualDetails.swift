//
//  WineTests+VisualDetails.swift
//  Wine CellarTests
//
//  Created by Tim Bausch on 10/23/22.
//

import CoreData
@testable import Wine_Cellar
import XCTest

final class WineTests_VisualDetails: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var wineService: WineService!
    var visualDetailsService: VisualDetailsService!
    let newWine = WineBuilder().build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineService = WineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        visualDetailsService = VisualDetailsService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineService = nil
        visualDetailsService = nil
    }
    
    func testAddSmellDetailsToWine() throws {
        let visualDetailsToAdd = VisualDetailsBuilder().build()
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
        
        let visualDetails = visualDetailsService.add(color: visualDetailsToAdd.Color, viscosity: visualDetailsToAdd.viscosity.rawValue, clarity: visualDetailsToAdd.clarity.rawValue)
        
        let wineWithVisualDetails = wineService.addVisualDetails(visualDetails, to: wine)
        XCTAssertEqual(wineWithVisualDetails.visualDetails?.viscosity, 3)
    }
    
    func testRemoveSmallDetailsFromWine() throws {
        let visualDetailsToAdd = VisualDetailsBuilder().build()
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
        
        let visualDetails = visualDetailsService.add(color: visualDetailsToAdd.Color, viscosity: visualDetailsToAdd.viscosity.rawValue, clarity: visualDetailsToAdd.clarity.rawValue)
        
        let wineWithVisualDetails = wineService.addVisualDetails(visualDetails, to: wine)
        XCTAssertEqual(wineWithVisualDetails.visualDetails?.viscosity, 3)
        
        let wineWithoutVisualDetails = wineService.removeVisualDetails(visualDetails, from: wine)
        XCTAssertNil(wineWithVisualDetails.smellDetails)
    }
}
