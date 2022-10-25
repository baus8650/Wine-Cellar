import Foundation
import CoreData

public final class DailyDataService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension DailyDataService {
    @discardableResult
    public func add(
        time: [String],
        temperature_2m_max: [Double],
        temperature_2m_min: [Double],
        rain_sum: [Double],
        snowfall_sum: [Double],
        windspeed_10m_max: [Double],
        windgusts_10m_max: [Double]) -> DailyData {
            let dailyData = DailyData(context: managedObjectContext)
            dailyData.time = time
            dailyData.tempMax = temperature_2m_max
            dailyData.tempMin = temperature_2m_min
            dailyData.rain = rain_sum
            dailyData.snow = snowfall_sum
            dailyData.windspeed = windspeed_10m_max
            dailyData.windgusts = windgusts_10m_max
            coreDataStack.saveContext(managedObjectContext)
            return dailyData
        }
    
    public func getAllDailyData() -> [DailyData]? {
        let dailyDataFetch: NSFetchRequest<DailyData> = DailyData.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(dailyDataFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    public func getDailyData(with id: NSManagedObjectID) -> DailyData? {
        let result = managedObjectContext.object(with: id)
        return result as? DailyData
        
    }
    
    @discardableResult
    public func update(_ dailyData: DailyData) -> DailyData {
        coreDataStack.saveContext(managedObjectContext)
        return dailyData
    }
    
    public func delete(_ dailyData: DailyData) {
        managedObjectContext.delete(dailyData)
        coreDataStack.saveContext(managedObjectContext)
    }
}
