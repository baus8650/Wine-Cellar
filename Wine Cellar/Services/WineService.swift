import Foundation
import CoreData

public final class WineService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension WineService {
    @discardableResult
    public func add(abv: Float, ava: String, company: String, isFavorited: Bool, numberOwned: Int16, type: String, varietal: String, vintage: Int16, wineColor: String) -> Wine {
        let wine = Wine(context: managedObjectContext)
        wine.abv = abv
        wine.ava = ava
        wine.company = company
        wine.isFavorited = isFavorited
        wine.numberOwned = numberOwned
        wine.type = type
        wine.varietal = varietal
        wine.vintage = vintage
        wine.wineColor = wineColor
        
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func getWines() -> [Wine]? {
        let wineFetch: NSFetchRequest<Wine> = Wine.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(wineFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    public func getWine(with id: NSManagedObjectID) -> Wine? {
        let result = managedObjectContext.object(with: id)
        return result as? Wine
    }
    
    public func addVineyard(_ vineyard: Vineyard, to wine: Wine) -> Wine {
        let originalWine = Wine(context: managedObjectContext)
        originalWine.abv = wine.abv
        originalWine.ava = wine.ava
        originalWine.company = wine.company
        originalWine.isFavorited = wine.isFavorited
        originalWine.numberOwned = wine.numberOwned
        originalWine.type = wine.type
        originalWine.varietal = wine.varietal
        originalWine.vintage = wine.vintage
        originalWine.wineColor = wine.wineColor
        
        vineyard.addToWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeVineyard(_ vineyard: Vineyard, from wine: Wine) -> Wine {
        let originalWine = Wine(context: managedObjectContext)
        originalWine.abv = wine.abv
        originalWine.ava = wine.ava
        originalWine.company = wine.company
        originalWine.isFavorited = wine.isFavorited
        originalWine.numberOwned = wine.numberOwned
        originalWine.type = wine.type
        originalWine.varietal = wine.varietal
        originalWine.vintage = wine.vintage
        originalWine.wineColor = wine.wineColor
        
        vineyard.removeFromWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func addSmellDetails(_ smellDetails: SmellDetails, to wine: Wine) -> Wine {
        let originalWine = Wine(context: managedObjectContext)
        originalWine.abv = wine.abv
        originalWine.ava = wine.ava
        originalWine.company = wine.company
        originalWine.isFavorited = wine.isFavorited
        originalWine.numberOwned = wine.numberOwned
        originalWine.type = wine.type
        originalWine.varietal = wine.varietal
        originalWine.vintage = wine.vintage
        originalWine.wineColor = wine.wineColor
        
        smellDetails.addToWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeSmellDetails(_ smellDetails: SmellDetails, from wine: Wine) -> Wine {
        let originalWine = Wine(context: managedObjectContext)
        originalWine.abv = wine.abv
        originalWine.ava = wine.ava
        originalWine.company = wine.company
        originalWine.isFavorited = wine.isFavorited
        originalWine.numberOwned = wine.numberOwned
        originalWine.type = wine.type
        originalWine.varietal = wine.varietal
        originalWine.vintage = wine.vintage
        originalWine.wineColor = wine.wineColor
        
        smellDetails.removeFromWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func addVisualDetails(_ visualDetails: VisualDetails, to wine: Wine) -> Wine {
        let originalWine = Wine(context: managedObjectContext)
        originalWine.abv = wine.abv
        originalWine.ava = wine.ava
        originalWine.company = wine.company
        originalWine.isFavorited = wine.isFavorited
        originalWine.numberOwned = wine.numberOwned
        originalWine.type = wine.type
        originalWine.varietal = wine.varietal
        originalWine.vintage = wine.vintage
        originalWine.wineColor = wine.wineColor
        
        visualDetails.addToWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeVisualDetails(_ visualDetails: VisualDetails, from wine: Wine) -> Wine {
        let originalWine = Wine(context: managedObjectContext)
        originalWine.abv = wine.abv
        originalWine.ava = wine.ava
        originalWine.company = wine.company
        originalWine.isFavorited = wine.isFavorited
        originalWine.numberOwned = wine.numberOwned
        originalWine.type = wine.type
        originalWine.varietal = wine.varietal
        originalWine.vintage = wine.vintage
        originalWine.wineColor = wine.wineColor
        
        visualDetails.removeFromWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func addTasteDetails(_ tasteDetails: TasteDetails, to wine: Wine) -> Wine {
        let originalWine = Wine(context: managedObjectContext)
        originalWine.abv = wine.abv
        originalWine.ava = wine.ava
        originalWine.company = wine.company
        originalWine.isFavorited = wine.isFavorited
        originalWine.numberOwned = wine.numberOwned
        originalWine.type = wine.type
        originalWine.varietal = wine.varietal
        originalWine.vintage = wine.vintage
        originalWine.wineColor = wine.wineColor
        
        tasteDetails.addToWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeTasteDetails(_ tasteDetails: TasteDetails, from wine: Wine) -> Wine {
        let originalWine = Wine(context: managedObjectContext)
        originalWine.abv = wine.abv
        originalWine.ava = wine.ava
        originalWine.company = wine.company
        originalWine.isFavorited = wine.isFavorited
        originalWine.numberOwned = wine.numberOwned
        originalWine.type = wine.type
        originalWine.varietal = wine.varietal
        originalWine.vintage = wine.vintage
        originalWine.wineColor = wine.wineColor
        
        tasteDetails.removeFromWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
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
