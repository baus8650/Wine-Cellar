import CoreData
@testable import Wine_Cellar
import XCTest

final class FoodPairingTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var foodPairingService: FoodPairingService!
    let newFoodPairing = FoodPairingBuilder().build()
    let secondFoodPairing = FoodPairingBuilder()
        .name("Second Pairing")
        .build()
    
    override func setUpWithError() throws {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        foodPairingService = FoodPairingService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        coreDataStack = nil
        foodPairingService = nil
    }
    
    func testAddFoodPairing() throws {
        let foodPairing = foodPairingService.add(name: newFoodPairing.name)
        XCTAssertEqual(foodPairing.name, "Food Pairing")
    }
    
    func testGetAllFoodPairings() throws {
        let _ = foodPairingService.add(name: newFoodPairing.name)
        let _ = foodPairingService.add(name: secondFoodPairing.name)
        let foodPairings = foodPairingService.getFoodPairings()
        XCTAssertEqual(foodPairings?.count, 2)
    }
    
    func testGetSingleFoodPairing() throws {
        let foodPairing1 = foodPairingService.add(name: newFoodPairing.name)
        let foodPairing2 = foodPairingService.add(name: secondFoodPairing.name)
        
        let fetchedFoodPairing1 = foodPairingService.getFoodPairing(with: foodPairing1.objectID)
        let fetchedFoodPairing2 = foodPairingService.getFoodPairing(with: foodPairing2.objectID)
        XCTAssertEqual(fetchedFoodPairing1?.name, "Food Pairing")
        XCTAssertEqual(fetchedFoodPairing2?.name, "Second Pairing")
    }
    
    func testUpdateFoodPairing() throws {
        let foodPairing1 = foodPairingService.add(name: newFoodPairing.name)
        let oldFoodPairing = foodPairingService.getFoodPairing(with: foodPairing1.objectID)
        XCTAssertEqual(oldFoodPairing?.name, "Food Pairing")
        
        let updatedFoodPairing = foodPairingService.getFoodPairing(with: foodPairing1.objectID)
        updatedFoodPairing?.name = "Updated Pairing"
        foodPairingService.update(updatedFoodPairing!)
        
        let newFoodPairing = foodPairingService.getFoodPairing(with: foodPairing1.objectID)
        XCTAssertEqual(newFoodPairing?.name, "Updated Pairing")
    }
    
    func testDeleteSingleFoodPairing() throws {
        let _ = foodPairingService.add(name: newFoodPairing.name)
        let foodPairing2 = foodPairingService.add(name: secondFoodPairing.name)
        
        var foodPairings = foodPairingService.getFoodPairings()
        XCTAssertEqual(foodPairings?.count, 2)
        
        let foodPairingToDelete = foodPairingService.getFoodPairing(with: foodPairing2.objectID)
        foodPairingService.delete(foodPairingToDelete!)
        foodPairings = foodPairingService.getFoodPairings()
        XCTAssertEqual(foodPairings?.count, 1)
        XCTAssertEqual(foodPairings?[0].name, "Food Pairing")
    }
}
