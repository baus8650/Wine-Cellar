import CoreData
import Foundation

public final class WineTastingService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension WineTastingService {
    @discardableResult
    public func add(date: Date, winery: String) -> WineTasting {
        let wineTasting = WineTasting(context: managedObjectContext)
        wineTasting.date = date
        wineTasting.winery = winery
        
        coreDataStack.saveContext(managedObjectContext)
        return wineTasting
    }
    
    public func getWineTastings() -> [WineTasting]? {
        let wineTastingFetch: NSFetchRequest<WineTasting> = WineTasting.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(wineTastingFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    
    public func getWineTasting(with id: NSManagedObjectID) -> WineTasting? {
        let result = managedObjectContext.object(with: id)
        return result as? WineTasting
    }
    
    public func addFlight(_ flight: Flight, to wineTasting: WineTasting) -> WineTasting {
        wineTasting.addToFlight(flight)
        coreDataStack.saveContext(managedObjectContext)
        return wineTasting
    }
    
    public func removeFlight(_ flight: Flight, from wineTasting: WineTasting) {
        wineTasting.removeFromFlight(flight)
        coreDataStack.saveContext(managedObjectContext)
    }
    
    @discardableResult
    public func update(_ wineTasting: WineTasting) -> WineTasting {
        coreDataStack.saveContext(managedObjectContext)
        return wineTasting
    }
    
    public func delete(_ wineTasting: WineTasting) {
        managedObjectContext.delete(wineTasting)
        coreDataStack.saveContext(managedObjectContext)
    }
}
