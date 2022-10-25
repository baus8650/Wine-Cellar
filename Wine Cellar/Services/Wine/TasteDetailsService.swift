import Foundation
import CoreData

public final class TasteDetailsService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension TasteDetailsService {
    @discardableResult
    public func add(body: Int16, sweetness: Int16, alcohol: Int16, acidityLevel: Int16, tanninLevel: Int16) -> TasteDetails {
        let tasteDetails = TasteDetails(context: managedObjectContext)
        tasteDetails.body = body
        tasteDetails.sweetness = sweetness
        tasteDetails.alcohol = alcohol
        tasteDetails.acidity = acidityLevel
        tasteDetails.tannin = tanninLevel
        
        coreDataStack.saveContext(managedObjectContext)
        return tasteDetails
    }
    
    public func getTasteDetails() -> [TasteDetails]? {
        let tasteDetailsFetch: NSFetchRequest<TasteDetails> = TasteDetails.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(tasteDetailsFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    public func getTasteDetails(with id: NSManagedObjectID) -> TasteDetails? {
        let result = managedObjectContext.object(with: id)
        return result as? TasteDetails
        
    }
    
    @discardableResult
    public func update(_ tasteDetails: TasteDetails) -> TasteDetails {
        coreDataStack.saveContext(managedObjectContext)
        return tasteDetails
    }
    
    public func delete(_ tasteDetails: TasteDetails) {
        managedObjectContext.delete(tasteDetails)
        coreDataStack.saveContext(managedObjectContext)
    }
}
