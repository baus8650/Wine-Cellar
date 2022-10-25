import Foundation
import CoreData

public final class FoodPairingService{
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension FoodPairingService {
    @discardableResult
    public func add(name: String) -> FoodPairing {
        let foodPairing = FoodPairing(context: managedObjectContext)
        foodPairing.name = name
        
        coreDataStack.saveContext(managedObjectContext)
        return foodPairing
    }
    
    public func getFoodPairings() -> [FoodPairing]? {
        let foodPairingsFetch: NSFetchRequest<FoodPairing> = FoodPairing.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(foodPairingsFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    public func getFoodPairing(with id: NSManagedObjectID) -> FoodPairing? {
        let result = managedObjectContext.object(with: id)
        return result as? FoodPairing
        
    }
    
    @discardableResult
    public func update(_ foodPairing: FoodPairing) -> FoodPairing {
        coreDataStack.saveContext(managedObjectContext)
        return foodPairing
    }
    
    public func delete(_ foodPairing: FoodPairing) {
        managedObjectContext.delete(foodPairing)
        coreDataStack.saveContext(managedObjectContext)
    }
}
