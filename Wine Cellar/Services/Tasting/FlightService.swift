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
    
    public func addSingleWine(_ wine: Wine, to flight: Flight) -> Flight {
        wine.addToFlight(flight)
        coreDataStack.saveContext(managedObjectContext)
        return flight
    }
    
    public func addMultipleWine(_ wines: [Wine], to flight: Flight) -> Flight {
        let _ = wines.map {
            $0.addToFlight(flight)
        }
        coreDataStack.saveContext(managedObjectContext)
        return flight
    }
    
    public func removeSingleWine(_ wine: Wine, from flight: Flight) {
        wine.removeFromFlight(flight)
        coreDataStack.saveContext(managedObjectContext)
    }
    
    public func removeMultipleWine(_ wines: [Wine], from flight: Flight) {
        let _ = wines.map {
            $0.removeFromFlight(flight)
        }
        coreDataStack.saveContext(managedObjectContext)
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
