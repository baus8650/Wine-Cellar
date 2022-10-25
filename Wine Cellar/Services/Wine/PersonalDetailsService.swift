import Foundation
import CoreData

public final class PersonalDetailsService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension PersonalDetailsService {
    @discardableResult
    public func add(opinion: String, mood: String) -> PersonalDetails {
        let personalDetails = PersonalDetails(context: managedObjectContext)
        personalDetails.opinion = opinion
        personalDetails.mood = mood
        
        coreDataStack.saveContext(managedObjectContext)
        return personalDetails
    }
    
    public func getPersonalDetails() -> [PersonalDetails]? {
        let personalDetailsFetch: NSFetchRequest<PersonalDetails> = PersonalDetails.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(personalDetailsFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    public func getPersonalDetails(with id: NSManagedObjectID) -> PersonalDetails? {
        let result = managedObjectContext.object(with: id)
        return result as? PersonalDetails
        
    }
    
    @discardableResult
    public func update(_ personalDetails: PersonalDetails) -> PersonalDetails {
        coreDataStack.saveContext(managedObjectContext)
        return personalDetails
    }
    
    public func delete(_ personalDetails: PersonalDetails) {
        managedObjectContext.delete(personalDetails)
        coreDataStack.saveContext(managedObjectContext)
    }
}
