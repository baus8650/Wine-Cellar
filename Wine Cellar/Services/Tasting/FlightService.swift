import CoreData
import Foundation

public final class FlightService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension FlightService {
    @discardableResult
    public func add(numberOfWines: Int16) -> Flight {
        let flight = Flight(context: managedObjectContext)
        flight.numberOfWines = numberOfWines
        
        coreDataStack.saveContext(managedObjectContext)
        return flight
    }
    
    public func getFlights() -> [Flight]? {
        let flightFetch: NSFetchRequest<Flight> = Flight.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(flightFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    public func getFlight(with id: NSManagedObjectID) -> Flight? {
        let result = managedObjectContext.object(with: id)
        return result as? Flight
    }
    
    @discardableResult
    public func update(_ flight: Flight) -> Flight {
        coreDataStack.saveContext(managedObjectContext)
        return flight
    }
    
    public func delete(_ flight: Flight) {
        managedObjectContext.delete(flight)
        coreDataStack.saveContext(managedObjectContext)
    }
}
