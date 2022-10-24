import Foundation
import CoreData

public final class VineyardService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension VineyardService {
    @discardableResult
    public func add(name: String, address: String, latitude: Double, longitude: Double) -> Vineyard {
        let vineyard = Vineyard(context: managedObjectContext)
        vineyard.name = name
        vineyard.address = address
        vineyard.latitude = latitude
        vineyard.longitude = longitude
        
        coreDataStack.saveContext(managedObjectContext)
        return vineyard
    }
    
    public func getVineyards() -> [Vineyard]? {
        let vineyardFetch: NSFetchRequest<Vineyard> = Vineyard.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(vineyardFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    public func getVineyard(with id: NSManagedObjectID) -> Vineyard? {
        let result = managedObjectContext.object(with: id)
        return result as? Vineyard
    }
    
    @discardableResult
    public func update(_ vineyard: Vineyard) -> Vineyard {
        coreDataStack.saveContext(managedObjectContext)
        return vineyard
    }
    
    public func delete(_ vineyard: Vineyard) {
        managedObjectContext.delete(vineyard)
        coreDataStack.saveContext(managedObjectContext)
    }
}
