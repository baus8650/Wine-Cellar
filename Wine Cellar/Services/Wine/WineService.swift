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
    public func add(dateAdded: Date = Date(), abv: Float, ava: String, company: String, isFavorited: Bool, numberOwned: Int16, type: String, varietal: String, vintage: Int16, wineColor: String) -> Wine {
        let wine = Wine(context: managedObjectContext)
        wine.dateAdded = dateAdded
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
    
    func getWines(with sortingOption: Constants.SortingOptions = .dateDescending, filteredFor filterOption: Constants.FilterOptions = .allWines) -> [Wine]? {
        let wineFetch: NSFetchRequest<Wine> = Wine.fetchRequest()
        wineFetch.sortDescriptors = [sortWintes(with: sortingOption)]
        wineFetch.predicate = filterWines(with: filterOption)
        do {
            let results = try managedObjectContext.fetch(wineFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    private func filterWines(with filterOption: Constants.FilterOptions) -> NSPredicate? {
        switch filterOption {
        case .allWines:
            return nil
        case .stillOnly:
            return NSPredicate(format: "type = %@", Constants.WineType.still.rawValue)
        case .sparklingOnly:
            return NSPredicate(format: "type = %@", Constants.WineType.sparkling.rawValue)
        }
    }
    
    private func sortWintes(with sortingOption: Constants.SortingOptions) -> NSSortDescriptor {
        switch sortingOption {
        case .abvAscending:
            return NSSortDescriptor(key: "abv", ascending: true)
        case .abvDescending:
            return NSSortDescriptor(key: "abv", ascending: false)
        case .dateAscending:
            return NSSortDescriptor(key: "dateAdded", ascending: true)
        case .dateDescending:
            return NSSortDescriptor(key: "dateAdded", ascending: false)
        case .companyAscending:
            return NSSortDescriptor(key: "company", ascending: true)
        case .companyDescending:
            return NSSortDescriptor(key: "company", ascending: false)
        case .varietalAscending:
            return NSSortDescriptor(key: "varietal", ascending: true)
        case .varietalDescending:
            return NSSortDescriptor(key: "varietal", ascending: false)
        case .vintageAscending:
            return NSSortDescriptor(key: "vintage", ascending: true)
        case .vintageDescending:
            return NSSortDescriptor(key: "vintage", ascending: false)
        }
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
    
    public func addPersonalDetails(_ personalDetails: PersonalDetails, to wine: Wine) -> Wine {
        wine.personalDetails = personalDetails
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removePersonalDetails(_ personalDetails: PersonalDetails, from wine: Wine) {
        wine.personalDetails = nil
        coreDataStack.saveContext(managedObjectContext)
    }
    
    public func addSingleFoodPairing(_ foodPairing: FoodPairing, to wine: Wine) -> Wine {
        foodPairing.addToWines(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func addMultipleFoodPairings(_ foodPairings: [FoodPairing], to wine: Wine) -> Wine {
        let _ = foodPairings.map {
            $0.addToWines(wine)
        }
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeSingleFoodPairing(_ foodPairing: FoodPairing, from wine: Wine) -> Wine {
        foodPairing.removeFromWines(wine)
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeMultipleFoodPairings(_ foodPairings: [FoodPairing], from wine: Wine) -> Wine {
        let _ = foodPairings.map {
            $0.removeFromWines(wine)
        }
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func addHourlyData(_ hourlyData: HourlyData, to wine: Wine) -> Wine {
        wine.hourlyData = hourlyData
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeHourlyData(_ hourlyData: HourlyData, from wine: Wine) {
        wine.hourlyData = nil
        coreDataStack.saveContext(managedObjectContext)
    }
    
    public func getWineFromHourlyData(with hourlyData: HourlyData) -> Wine? {
        let hourlyData = managedObjectContext.object(with: hourlyData.objectID) as? HourlyData
        return hourlyData?.wine ?? nil
    }
    
    public func getHourlyDataFromWine(with wine: Wine) -> HourlyData? {
        let wine = managedObjectContext.object(with: wine.objectID) as? Wine
        return wine?.hourlyData ?? nil
    }
    
    public func addDailyData(_ dailyData: DailyData, to wine: Wine) -> Wine {
        wine.dailyData = dailyData
        coreDataStack.saveContext(managedObjectContext)
        return wine
    }
    
    public func removeDailyData(_ dailyData: DailyData, from wine: Wine) {
        wine.dailyData = nil
        coreDataStack.saveContext(managedObjectContext)
    }
    
    public func getWineFromDailyData(with dailyData: DailyData) -> Wine? {
        let dailyData = managedObjectContext.object(with: dailyData.objectID) as? DailyData
        return dailyData?.wine ?? nil
    }
    
    public func getDailyDataFromWine(with wine: Wine) -> DailyData? {
        let wine = managedObjectContext.object(with: wine.objectID) as? Wine
        return wine?.dailyData ?? nil
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
