//
//  Wine_CellarTests.swift
//  Wine CellarTests
//
//  Created by Tim Bausch on 10/21/22.
//

import CoreData
@testable import Wine_Cellar
import XCTest

class WineTests_SmellDetails: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var wineService: WineService!
    var smellDetailsService: SmellDetailsService!
    let newWine = WineBuilder().build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineService = WineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        smellDetailsService = SmellDetailsService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineService = nil
        smellDetailsService = nil
    }
    
    func testAddSmellDetailsToWine() throws {
        let smellDetailsToAdd = SmellDetailsBuilder().build()
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
        
        let smellDetails = smellDetailsService.add(id: smellDetailsToAdd.id, date: smellDetailsToAdd.date, primaryAroma: smellDetailsToAdd.primaryAroma!, secondaryAroma: smellDetailsToAdd.secondaryAroma!, tertiaryAroma: smellDetailsToAdd.tertiaryAroma!)
        
        let wineWithSmellDetails = wineService.addSmellDetails(smellDetails, to: wine)
        XCTAssertEqual(wineWithSmellDetails.smellDetails?.primaryAroma, ["Primary Aroma"])
    }
    
    func testRemoveSmallDetailsFromWine() throws {
        let smellDetailsToAdd = SmellDetailsBuilder().build()
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
        
        let smellDetails = smellDetailsService.add(id: smellDetailsToAdd.id, date: smellDetailsToAdd.date, primaryAroma: smellDetailsToAdd.primaryAroma!, secondaryAroma: smellDetailsToAdd.secondaryAroma!, tertiaryAroma: smellDetailsToAdd.tertiaryAroma!)
        
        let wineWithSmellDetails = wineService.addSmellDetails(smellDetails, to: wine)
        XCTAssertEqual(wineWithSmellDetails.smellDetails?.primaryAroma, ["Primary Aroma"])
        
        let wineWithoutSmellDetails = wineService.removeSmellDetails(smellDetails, from: wine)
        XCTAssertNil(wineWithoutSmellDetails.smellDetails)
    }
    
}
