import Foundation
import CoreData

public final class VisualDetailsService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension VisualDetailsService {
    @discardableResult
    public func add(color: String, viscosity: Int16, clarity: Int16) -> VisualDetails {
        let visualDetails = VisualDetails(context: managedObjectContext)
        visualDetails.color = color
        visualDetails.viscosity = viscosity
        visualDetails.clarity = clarity
        
        coreDataStack.saveContext(managedObjectContext)
        return visualDetails
    }
    
    public func getVisualDetails() -> [VisualDetails]? {
        let visualDetailsFetch: NSFetchRequest<VisualDetails> = VisualDetails.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(visualDetailsFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    public func getVisualDetails(with id: NSManagedObjectID) -> VisualDetails? {
//        let visualDetails: NSFetchRequest<VisualDetails> = VisualDetails.fetchRequest()
//        visualDetails.fetchLimit = 1
//        visualDetails.predicate = NSPredicate(format: "id == %@", id as! CVarArg)
        
        let result = managedObjectContext.object(with: id)
        return result as? VisualDetails

    }
    
    @discardableResult
    public func update(_ visualDetails: VisualDetails) -> VisualDetails {
        coreDataStack.saveContext(managedObjectContext)
        return visualDetails
    }
    
    public func delete(_ visualDetails: VisualDetails) {
        managedObjectContext.delete(visualDetails)
        coreDataStack.saveContext(managedObjectContext)
    }
}
