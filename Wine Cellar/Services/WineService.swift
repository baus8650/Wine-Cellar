import Foundation
import CoreData

public final class WineService {
    // MARK: - Properties
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    // MARK: - Initializers
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

// MARK: - Public
extension ReportService {
    @discardableResult
    public func add(_ newWine: Wine) -> Wine {
        let wine = Wine(context: managedObjectContext)
        wine.abv = newWine.abv
        wine.ava = newWine.ava
        wine.company = newWine.company
        wine.image = newWine.image
        wine.isFavorited = newWine.isFavorited
        wine.numberOwned = newWine.numberOwned
        wine.type = newWine.type
        wine.varietal = newWine.varietal
        wine.vintage = newWine.vintage
        wine.wineColor = newWine.wineColor
        wine.weatherData = newWine.weatherData
        wine.visualDetails = newWine.visualDetails
        wine.vineyard = newWine.vineyard
        wine.tasteDetails = newWine.tasteDetails
        wine.smellDetails = newWine.smellDetails
        wine.personalDetails = newWine.personalDetails
        wine.notes = newWine.notes
        wine.foodPairing = newWine.foodPairing
        wine.flight = newWine.flight
        
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func getReports() -> [Wine]? {
        let wineFetch: NSFetchRequest<Wine> = Wine.fetchRequest()
        do {
            let results = try managedObjectContext.fetch(wineFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    @discardableResult
    public func update(_ wine: Wine) -> Wine {
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func delete(_ wine: Wine) {
        managedObjectContext.delete(wine)
        coreDataStack.saveContext(managedObjectContext)
    }
}
