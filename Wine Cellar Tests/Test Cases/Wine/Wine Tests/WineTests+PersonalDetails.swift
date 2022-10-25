import CoreData
@testable import Wine_Cellar
import XCTest

final class WineTests_PersonalDetails: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var wineService: WineService!
    var personalDetailsService: PersonalDetailsService!
    let newWine = WineBuilder().build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineService = WineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        personalDetailsService = PersonalDetailsService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineService = nil
        personalDetailsService = nil
    }
    
    func testAddPersonalDetailsToWine() throws {
        let personalDetailsToAdd = PersonalDetailsBuilder().build()
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
        
        let personalDetails = personalDetailsService.add(opinion: personalDetailsToAdd.opinions, mood: personalDetailsToAdd.mood)
        
        let wineWithPersonalDetails = wineService.addPersonalDetails(personalDetails, to: wine)
        XCTAssertEqual(wineWithPersonalDetails.personalDetails?.mood, "Test Mood")
    }
    
    func testRemoveTasteDetailsFromWine() throws {
        let personalDetailsToAdd = PersonalDetailsBuilder().build()
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
        
        let personalDetails = personalDetailsService.add(opinion: personalDetailsToAdd.opinions, mood: personalDetailsToAdd.mood)
        
        let wineWithPersonalDetails = wineService.addPersonalDetails(personalDetails, to: wine)
        XCTAssertEqual(wineWithPersonalDetails.personalDetails?.mood, "Test Mood")
        wineService.removePersonalDetails(personalDetails, from: wineWithPersonalDetails)

        let wineWithoutPersonalDetails = wineService.getWine(with: wineWithPersonalDetails.objectID)
        XCTAssertNil(wineWithoutPersonalDetails?.personalDetails)
        
    }

}
