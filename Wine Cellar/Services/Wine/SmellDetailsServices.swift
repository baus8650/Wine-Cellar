import Foundation
import CoreData

public final class SmellDetailsService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension SmellDetailsService {
    @discardableResult
    public func add(date: Date, primaryAroma: [String], secondaryAroma: [String], tertiaryAroma: [String]) -> SmellDetails {
        let smellDetails = SmellDetails(context: managedObjectContext)
        smellDetails.date = date
        smellDetails.primaryAroma = primaryAroma
        smellDetails.secondaryAroma = secondaryAroma
        smellDetails.tertiaryAroma = tertiaryAroma
        
        coreDataStack.saveContext(managedObjectContext)
        return smellDetails
    }
    
    public func getSmellDetails() -> [SmellDetails]? {
        let smellDetailsFetch: NSFetchRequest<SmellDetails> = SmellDetails.fetchRequest()
        do {
            let results = try managedObjectContext.fetch(smellDetailsFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    public func getSmellDetails(with id: NSManagedObjectID) -> SmellDetails? {
        let result = managedObjectContext.object(with: id)
        return result as? SmellDetails
    }
    
    @discardableResult
    public func update(_ smellDetails: SmellDetails) -> SmellDetails {
        coreDataStack.saveContext(managedObjectContext)
        return smellDetails
    }
    
    public func delete(_ smellDetails: SmellDetails) {
        managedObjectContext.delete(smellDetails)
        coreDataStack.saveContext(managedObjectContext)
    }
}
