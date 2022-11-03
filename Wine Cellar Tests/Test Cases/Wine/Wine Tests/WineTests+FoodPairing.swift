import CoreData
@testable import Wine_Cellar
import XCTest

final class WineTests_FoodPairing: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var wineService: WineService!
    var foodPairingService: FoodPairingService!
    let newWine = WineBuilder().build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineService = WineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        foodPairingService = FoodPairingService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineService = nil
        foodPairingService = nil
    }
    
    func testAddSingleFoodPairingToWine() throws {
        let newFoodPairing = FoodPairingBuilder().build()
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
        
        let foodPairing = foodPairingService.add(name: newFoodPairing.name)
        
        let wineWithFoodPairing = wineService.addSingleFoodPairing(foodPairing, to: wine)
        
        XCTAssertEqual(wineWithFoodPairing.foodPairings?.count, 1)
        XCTAssertEqual(wineWithFoodPairing.foodPairings?.contains(foodPairing), true)
    }
    
    func testAddMultipleFoodPairingsToWine() throws {
        let foodPairing1 = FoodPairingBuilder().build()
        let foodPairing2 = FoodPairingBuilder()
            .name("Second Pairing")
            .build()
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
        
        let addedFoodPairing1 = foodPairingService.add(name: foodPairing1.name)
        
        let addedFoodPairing2 = foodPairingService.add(name: foodPairing2.name)
        
        let wineWithFoodPairings = wineService.addMultipleFoodPairings([addedFoodPairing1, addedFoodPairing2], to: wine)
        
        XCTAssertEqual(wineWithFoodPairings.foodPairings?.count, 2)
        XCTAssertEqual(wineWithFoodPairings.foodPairings?.contains(addedFoodPairing1), true)
        XCTAssertEqual(wineWithFoodPairings.foodPairings?.contains(addedFoodPairing2), true)
    }
    
    func testRemoveSingleFoodPairingFromWineAfterAddingSingularFoodPairing() throws {
        let newFoodPairing = FoodPairingBuilder().build()
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
        
        let foodPairing = foodPairingService.add(name: newFoodPairing.name)
        
        var wineWithFoodPairing = wineService.addSingleFoodPairing(foodPairing, to: wine)
        
        XCTAssertEqual(wineWithFoodPairing.foodPairings?.count, 1)
        wineWithFoodPairing = wineService.removeSingleFoodPairing(foodPairing, from: wine)
        XCTAssertEqual(wineWithFoodPairing.foodPairings?.count, 0)
    }
    
    func testRemoveSingleFoodPairingFromWineAfterAddingMultipleFoodPairings() throws {
        let foodPairing1 = FoodPairingBuilder().build()
        let foodPairing2 = FoodPairingBuilder()
            .name("Second Pairing")
            .build()
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
        
        let addedFoodPairing1 = foodPairingService.add(name: foodPairing1.name)
        
        let addedFoodPairing2 = foodPairingService.add(name: foodPairing2.name)
        
        var wineWithFoodPairings = wineService.addMultipleFoodPairings([addedFoodPairing1, addedFoodPairing2], to: wine)
        
        XCTAssertEqual(wineWithFoodPairings.foodPairings?.count, 2)
        wineWithFoodPairings = wineService.removeSingleFoodPairing(addedFoodPairing1, from: wine)
        XCTAssertEqual(wineWithFoodPairings.foodPairings?.count, 1)
        XCTAssertEqual(wineWithFoodPairings.foodPairings?.contains(addedFoodPairing1), false)
        XCTAssertEqual(wineWithFoodPairings.foodPairings?.contains(addedFoodPairing2), true)
    }
    
    func testRemoveMultipleFoodPairingsFromWine() throws {
        let foodPairing1 = FoodPairingBuilder().build()
        let foodPairing2 = FoodPairingBuilder()
            .name("Second Pairing")
            .build()
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
        
        let addedFoodPairing1 = foodPairingService.add(name: foodPairing1.name)
        
        let addedFoodPairing2 = foodPairingService.add(name: foodPairing2.name)
        
        var wineWithFoodPairings = wineService.addMultipleFoodPairings([addedFoodPairing1, addedFoodPairing2], to: wine)
        
        XCTAssertEqual(wineWithFoodPairings.foodPairings?.count, 2)
        wineWithFoodPairings = wineService.removeMultipleFoodPairings([addedFoodPairing1, addedFoodPairing2], from: wine)
        XCTAssertEqual(wineWithFoodPairings.foodPairings?.count, 0)
    }
}
