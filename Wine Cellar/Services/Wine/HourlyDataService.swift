import Foundation
import CoreData

public final class HourlyDataService {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
}

extension HourlyDataService {
    @discardableResult
    public func add(time: [String], temperature_2m: [Double], relativehumidity_2m: [Int], dewpoint_2m: [Double], precipitation: [Double], rain: [Double], snowfall: [Double], cloudcover: [Int], soil_temperature_0_to_7cm: [Double], soil_temperature_7_to_28cm: [Double], soil_temperature_28_to_100cm: [Double], soil_temperature_100_to_255cm: [Double], soil_moisture_0_to_7cm: [Double], soil_moisture_7_to_28cm: [Double], soil_moisture_28_to_100cm: [Double], soil_moisture_100_to_255cm: [Double]) -> HourlyData {
        let hourlyData = HourlyData(context: managedObjectContext)
        
        hourlyData.time = time
        hourlyData.temperature = temperature_2m
        hourlyData.humidity = relativehumidity_2m
        hourlyData.dewpoint = dewpoint_2m
        hourlyData.precipitation = precipitation
        hourlyData.rain = rain
        hourlyData.snowfall = snowfall
        hourlyData.cloudcover = cloudcover
        hourlyData.soilTemp0_7 = soil_temperature_0_to_7cm
        hourlyData.soilTemp7_28 = soil_temperature_7_to_28cm
        hourlyData.soilTemp28_100 = soil_temperature_28_to_100cm
        hourlyData.soilTemp100_255 = soil_temperature_100_to_255cm
        hourlyData.soilMoisture0_7 = soil_moisture_0_to_7cm
        hourlyData.soilMoisture7_28 = soil_moisture_7_to_28cm
        hourlyData.soilMoisture28_100 = soil_moisture_28_to_100cm
        hourlyData.soilMoisture100_255 = soil_moisture_100_to_255cm
        
        coreDataStack.saveContext(managedObjectContext)
        return hourlyData
    }
    
    public func getAllHourlyData() -> [HourlyData]? {
        let hourlyDataFetch: NSFetchRequest<HourlyData> = HourlyData.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(hourlyDataFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return nil
    }
    
    public func getHourlyData(with id: NSManagedObjectID) -> HourlyData? {
        let result = managedObjectContext.object(with: id)
        return result as? HourlyData
        
    }
    
    @discardableResult
    public func update(_ hourlyData: HourlyData) -> HourlyData {
        coreDataStack.saveContext(managedObjectContext)
        return hourlyData
    }
    
    public func delete(_ hourlyData: HourlyData) {
        managedObjectContext.delete(hourlyData)
        coreDataStack.saveContext(managedObjectContext)
    }
}
