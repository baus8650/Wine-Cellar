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
    public func add(id: UUID, primaryAroma: [String], secondaryAroma: [String], tertiaryAroma: [String]) -> SmellDetails {
        let smellDetails = SmellDetails(context: managedObjectContext)
        smellDetails.id = id
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
    
    public func getSmellDetails(with id: UUID) -> SmellDetails? {
        let smellDetails: NSFetchRequest<SmellDetails> = SmellDetails.fetchRequest()
        smellDetails.fetchLimit = 1
        smellDetails.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        do {
            let result = try managedObjectContext.fetch(smellDetails)
            return result.first ?? nil
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
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
