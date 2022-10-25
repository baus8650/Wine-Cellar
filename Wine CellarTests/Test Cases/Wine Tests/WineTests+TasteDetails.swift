import CoreData
@testable import Wine_Cellar
import XCTest

final class WineTests_TasteDetails: XCTestCase {

    var coreDataStack: CoreDataStack!
    var wineService: WineService!
    var tasteDetailsService: TasteDetailsService!
    let newWine = WineBuilder().build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineService = WineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        tasteDetailsService = TasteDetailsService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineService = nil
        tasteDetailsService = nil
    }
    
    func testAddTasteDetailsToWine() throws {
        let tasteDetailsToAdd = TasteDetailsBuilder().build()
        let wine = wineService.add(
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
        
        let tasteDetails = tasteDetailsService.add(body: tasteDetailsToAdd.body.rawValue, sweetness: tasteDetailsToAdd.sweetness.rawValue, alcohol: tasteDetailsToAdd.alcohol.rawValue, acidityLevel: tasteDetailsToAdd.acidityLevel.rawValue, tanninLevel: tasteDetailsToAdd.tanninLevel.rawValue)
        
        let wineWithTasteDetails = wineService.addTasteDetails(tasteDetails, to: wine)
        XCTAssertEqual(wineWithTasteDetails.tasteDetails?.body, 3)
    }
    
    func testRemoveTasteDetailsFromWine() throws {
        let tasteDetailsToAdd = TasteDetailsBuilder().build()
        let wine = wineService.add(
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
        
        let tasteDetails = tasteDetailsService.add(body: tasteDetailsToAdd.body.rawValue, sweetness: tasteDetailsToAdd.sweetness.rawValue, alcohol: tasteDetailsToAdd.alcohol.rawValue, acidityLevel: tasteDetailsToAdd.acidityLevel.rawValue, tanninLevel: tasteDetailsToAdd.tanninLevel.rawValue)
        
        let wineWithTasteDetails = wineService.addTasteDetails(tasteDetails, to: wine)
        XCTAssertEqual(wineWithTasteDetails.tasteDetails?.body, 3)
        
        let wineWithoutTasteDetails = wineService.removeTasteDetails(tasteDetails, from: wine)
        
        XCTAssertNil(wineWithoutTasteDetails.tasteDetails)
    }

}
