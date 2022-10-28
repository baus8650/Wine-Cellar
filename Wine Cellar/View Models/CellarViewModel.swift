import Combine
import CoreData
import Foundation

final class CellarViewModel {
    @Published var wines = [Wine]()
    @Published var redWines = [Wine]()
    @Published var roseWines = [Wine]()
    @Published var whiteWines = [Wine]()
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    let wineService: WineService!
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.wineService = WineService(managedObjectContext: managedObjectContext, coreDataStack: coreDataStack)
        fetchWines()
    }
    
    func fetchWines() {
        wines = wineService.getWines() ?? []
        redWines = wines.filter {
            $0.wineColor! == Constants.WineColor.red.rawValue
        }
        roseWines = wines.filter {
            $0.wineColor! == Constants.WineColor.rose.rawValue
        }
        whiteWines = wines.filter {
            $0.wineColor! == Constants.WineColor.white.rawValue
        }
    }
    
    func addWine(abv: Float,
                 ava: String,
                 company: String,
                 isFavorited: Bool,
                 numberOwned: Int16,
                 type: String,
                 varietal: String,
                 vintage: Int16,
                 wineColor: String) {
        let _ = wineService.add(abv: abv, ava: ava, company: company, isFavorited: isFavorited, numberOwned: numberOwned, type: type, varietal: varietal, vintage: vintage, wineColor: wineColor)
        fetchWines()
    }
}
