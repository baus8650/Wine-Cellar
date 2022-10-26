import CoreData
@testable import Wine_Cellar
import XCTest

final class WineTests_DailyData: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var wineService: WineService!
    var dailyDataService: DailyDataService!
    let newWine = WineBuilder().build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineService = WineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        dailyDataService = DailyDataService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineService = nil
        dailyDataService = nil
    }
    
    func testAddDailyDataToWine() throws {
        let wine = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue
        )
        
        let newDailyData = DailyDataBuilder().build()
        let dailyData = dailyDataService.add(
            time: newDailyData.time,
            temperature_2m_max: newDailyData.temperature_2m_max,
            temperature_2m_min: newDailyData.temperature_2m_min,
            rain_sum: newDailyData.rain_sum,
            snowfall_sum: newDailyData.snowfall_sum,
            windspeed_10m_max: newDailyData.windspeed_10m_max,
            windgusts_10m_max: newDailyData.windgusts_10m_max)
        
        let wineWithDailyData = wineService.addDailyData(dailyData, to: wine)
        XCTAssertEqual(wineWithDailyData.dailyData?.tempMax, [62.7, 58.1, 62.1, 63.4, 67.3])
    }
    
    func testRemoveDailyDataFromWine() throws {
        let wine = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue
        )
        
        let newDailyData = DailyDataBuilder().build()
        let dailyData = dailyDataService.add(
            time: newDailyData.time,
            temperature_2m_max: newDailyData.temperature_2m_max,
            temperature_2m_min: newDailyData.temperature_2m_min,
            rain_sum: newDailyData.rain_sum,
            snowfall_sum: newDailyData.snowfall_sum,
            windspeed_10m_max: newDailyData.windspeed_10m_max,
            windgusts_10m_max: newDailyData.windgusts_10m_max)
        
        let wineWithDailyData = wineService.addDailyData(dailyData, to: wine)
        XCTAssertEqual(wineWithDailyData.dailyData?.tempMax, [62.7, 58.1, 62.1, 63.4, 67.3])
        
        wineService.removeDailyData(dailyData, from: wineWithDailyData)
        let wineWithoutDailyData = wineService.getWine(with: wineWithDailyData.objectID)
        XCTAssertNil(wineWithoutDailyData?.dailyData)
        
    }
    
    func testGetWineFromDailyData() throws {
        let wine = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue
        )
        let originalWineID = wine.objectID
        
        let newDailyData = DailyDataBuilder().build()
        let dailyData = dailyDataService.add(
            time: newDailyData.time,
            temperature_2m_max: newDailyData.temperature_2m_max,
            temperature_2m_min: newDailyData.temperature_2m_min,
            rain_sum: newDailyData.rain_sum,
            snowfall_sum: newDailyData.snowfall_sum,
            windspeed_10m_max: newDailyData.windspeed_10m_max,
            windgusts_10m_max: newDailyData.windgusts_10m_max)
        let wineWithDailyData = wineService.addDailyData(dailyData, to: wine)
        
        let retrievedWine = wineService.getWineFromDailyData(with: dailyData)
        let retrievedWineID = retrievedWine?.objectID
        XCTAssertEqual(originalWineID, retrievedWineID)
    }
    
    func testGetDailyDataFromWine() throws {
        let wine = wineService.add(
            abv: newWine.abv,
            ava: newWine.ava ?? "",
            company: newWine.company,
            isFavorited: newWine.isFavorited,
            numberOwned: Int16(newWine.numberOwned),
            type: newWine.type.rawValue,
            varietal: newWine.varietal.rawValue,
            vintage: Int16(newWine.vintage),
            wineColor: newWine.wineColor.rawValue
        )
        
        let newDailyData = DailyDataBuilder().build()
        let dailyData = dailyDataService.add(
            time: newDailyData.time,
            temperature_2m_max: newDailyData.temperature_2m_max,
            temperature_2m_min: newDailyData.temperature_2m_min,
            rain_sum: newDailyData.rain_sum,
            snowfall_sum: newDailyData.snowfall_sum,
            windspeed_10m_max: newDailyData.windspeed_10m_max,
            windgusts_10m_max: newDailyData.windgusts_10m_max)
        let originalDailyDataID = dailyData.objectID
        let wineWithDailyData = wineService.addDailyData(dailyData, to: wine)
        
        let retrievedDailyData = wineService.getDailyDataFromWine(with: wineWithDailyData)
        let retrievedDailyDataID = retrievedDailyData?.objectID
        XCTAssertEqual(originalDailyDataID, retrievedDailyDataID)
    }
}
