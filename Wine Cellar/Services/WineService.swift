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
        vineyard.addToWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeVineyard(_ vineyard: Vineyard, from wine: Wine) -> Wine {
        vineyard.removeFromWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func addSmellDetails(_ smellDetails: SmellDetails, to wine: Wine) -> Wine {
        smellDetails.addToWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeSmellDetails(_ smellDetails: SmellDetails, from wine: Wine) -> Wine {
        smellDetails.removeFromWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func addVisualDetails(_ visualDetails: VisualDetails, to wine: Wine) -> Wine {
        visualDetails.addToWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeVisualDetails(_ visualDetails: VisualDetails, from wine: Wine) -> Wine {
        visualDetails.removeFromWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func addTasteDetails(_ tasteDetails: TasteDetails, to wine: Wine) -> Wine {
        tasteDetails.addToWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeTasteDetails(_ tasteDetails: TasteDetails, from wine: Wine) -> Wine {
        tasteDetails.removeFromWine(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func addSingleTastingNotes(_ tastingNotes: TastingNote, to wine: Wine) -> Wine {
        wine.addToTastingNotes(tastingNotes)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func addMultipleTastingNotes(_ tastingNotes: [TastingNote], to wine: Wine) -> Wine {
        let _ = tastingNotes.map {
            wine.addToTastingNotes($0)
        }
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }

    public func removeSingleTastingNote(_ tastingNote: TastingNote, from wine: Wine) -> Wine {
        wine.removeFromTastingNotes(tastingNote)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeMultipleTastingNote(_ tastingNotes: [TastingNote], from wine: Wine) -> Wine {
        let _ = tastingNotes.map {
            wine.removeFromTastingNotes($0)
        }
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
