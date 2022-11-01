import Combine
import CoreData
import Foundation

final class CellarViewModel: ObservableObject {
    @Published var wines = [Wine]()
    @Published var redWines = [Wine]()
    @Published var roseWines = [Wine]()
    @Published var whiteWines = [Wine]()
    @Published var bubbleScaleValue = CGFloat.random(in: 0.1...0.6)
    @Published var bubbleFrameWidth = CGFloat.random(in: 1...100)
    @Published var bubbleFrameHeight = CGFloat.random(in: 20...100)
    @Published var bubbleXPosition = CGFloat.random(in: 0...1000)
    @Published var bubbleYPosition = CGFloat.random(in: 0...200)
    @Published var bubbles = [Bubble]()
    @Published var filterParameter: Constants.FilterOptions = .allWines
    @Published var sortParameter: Constants.SortingOptions = .dateDescending
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    let wineService: WineService!
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.wineService = WineService(managedObjectContext: managedObjectContext, coreDataStack: coreDataStack)
        fetchWines()
        /// Bubbles need to be generated here so that they don't re-render when toggling edit and selected modes in the CollectionViewCells
        self.bubbles = makeBubbles()
    }
    
    func fetchWines() {
        wines = []
        wines = wineService.getWines(with: sortParameter, filteredFor: filterParameter) ?? []
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
    
    func deleteSingle(_ wine: Wine) {
        wineService.delete(wine)
        fetchWines()
    }
    
    func deleteMultiple(_ wines: [Wine]) {
        let _ = wines.map {
            wineService.delete($0)
        }
        fetchWines()
    }
    
    func addWine(dateAdded: Date = Date(),
                 abv: Float,
                 ava: String,
                 company: String,
                 isFavorited: Bool,
                 numberOwned: Int16,
                 type: String,
                 varietal: String,
                 vintage: Int16,
                 wineColor: String) {
        let _ = wineService.add(dateAdded: dateAdded, abv: abv, ava: ava, company: company, isFavorited: isFavorited, numberOwned: numberOwned, type: type, varietal: varietal, vintage: vintage, wineColor: wineColor)
        fetchWines()
    }
    
    func updateWine(_ wine: Wine) {
        print("Updating")
        wineService.update(wine)
        fetchWines()
    }
    
    func makeBubbles() -> [Bubble] {
        var bubbles = [Bubble]()
        for _ in 0..<150 {
            bubbles.append(Bubble())
        }
        return bubbles
    }
}
