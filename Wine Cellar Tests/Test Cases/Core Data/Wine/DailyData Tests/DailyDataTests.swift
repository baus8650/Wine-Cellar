import CoreData
@testable import Wine_Cellar
import XCTest

final class DailyDataTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var dailyDataService: DailyDataService!
    let newDailyData = DailyDataBuilder().build()
    let secondDailyData = DailyDataBuilder()
        .temperature_2m_max([0.0, 1.0, 2.0])
        .build()
    
    override func setUpWithError() throws {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        dailyDataService = DailyDataService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        coreDataStack = nil
        dailyDataService = nil
    }
    
    func testAddDailyData() throws {
        let dailyData = dailyDataService.add(
            time: newDailyData.time,
            temperature_2m_max: newDailyData.temperature_2m_max,
            temperature_2m_min: newDailyData.temperature_2m_min,
            rain_sum: newDailyData.rain_sum,
            snowfall_sum: newDailyData.snowfall_sum,
            windspeed_10m_max: newDailyData.windspeed_10m_max,
            windgusts_10m_max: newDailyData.windgusts_10m_max)
        XCTAssertEqual(dailyData.tempMax, [62.7, 58.1, 62.1, 63.4, 67.3])
    }
    
    func testGetAllHourlyDetails() throws {
        let _ = dailyDataService.add(
            time: newDailyData.time,
            temperature_2m_max: newDailyData.temperature_2m_max,
            temperature_2m_min: newDailyData.temperature_2m_min,
            rain_sum: newDailyData.rain_sum,
            snowfall_sum: newDailyData.snowfall_sum,
            windspeed_10m_max: newDailyData.windspeed_10m_max,
            windgusts_10m_max: newDailyData.windgusts_10m_max)
        let _ = dailyDataService.add(
            time: secondDailyData.time,
            temperature_2m_max: secondDailyData.temperature_2m_max,
            temperature_2m_min: secondDailyData.temperature_2m_min,
            rain_sum: secondDailyData.rain_sum,
            snowfall_sum: secondDailyData.snowfall_sum,
            windspeed_10m_max: secondDailyData.windspeed_10m_max,
            windgusts_10m_max: secondDailyData.windgusts_10m_max)
        
        let dailyData = dailyDataService.getAllDailyData()
        XCTAssertEqual(dailyData?.count, 2)
    }
    
    func testGetSingleTasteDetail() throws {
        let dailyData1 = dailyDataService.add(
            time: newDailyData.time,
            temperature_2m_max: newDailyData.temperature_2m_max,
            temperature_2m_min: newDailyData.temperature_2m_min,
            rain_sum: newDailyData.rain_sum,
            snowfall_sum: newDailyData.snowfall_sum,
            windspeed_10m_max: newDailyData.windspeed_10m_max,
            windgusts_10m_max: newDailyData.windgusts_10m_max)
        let dailyData2 = dailyDataService.add(
            time: secondDailyData.time,
            temperature_2m_max: secondDailyData.temperature_2m_max,
            temperature_2m_min: secondDailyData.temperature_2m_min,
            rain_sum: secondDailyData.rain_sum,
            snowfall_sum: secondDailyData.snowfall_sum,
            windspeed_10m_max: secondDailyData.windspeed_10m_max,
            windgusts_10m_max: secondDailyData.windgusts_10m_max)
        
        let fetchedDailyData1 = dailyDataService.getDailyData(with: dailyData1.objectID)
        let fetchedDailyData2 = dailyDataService.getDailyData(with: dailyData2.objectID)
        XCTAssertEqual(fetchedDailyData1?.tempMax, [62.7, 58.1, 62.1, 63.4, 67.3])
        XCTAssertEqual(fetchedDailyData2?.tempMax, [0.0, 1.0, 2.0])
    }
    
    func testUpdateTasteDetails() throws {
        let dailyData1 = dailyDataService.add(
            time: newDailyData.time,
            temperature_2m_max: newDailyData.temperature_2m_max,
            temperature_2m_min: newDailyData.temperature_2m_min,
            rain_sum: newDailyData.rain_sum,
            snowfall_sum: newDailyData.snowfall_sum,
            windspeed_10m_max: newDailyData.windspeed_10m_max,
            windgusts_10m_max: newDailyData.windgusts_10m_max)
        let oldDailyData = dailyDataService.getDailyData(with: dailyData1.objectID)
        XCTAssertEqual(oldDailyData?.tempMax, [62.7, 58.1, 62.1, 63.4, 67.3])
        
        let updatedDailyData = dailyDataService.getDailyData(with: dailyData1.objectID)
        updatedDailyData?.tempMax = [0.0, 1.0]
        dailyDataService.update(updatedDailyData!)
        
        let newDailyData = dailyDataService.getDailyData(with: dailyData1.objectID)
        XCTAssertEqual(newDailyData?.tempMax, [0.0, 1.0])
    }
    
    func testDeleteTasteDetails() throws {
        let _ = dailyDataService.add(
            time: newDailyData.time,
            temperature_2m_max: newDailyData.temperature_2m_max,
            temperature_2m_min: newDailyData.temperature_2m_min,
            rain_sum: newDailyData.rain_sum,
            snowfall_sum: newDailyData.snowfall_sum,
            windspeed_10m_max: newDailyData.windspeed_10m_max,
            windgusts_10m_max: newDailyData.windgusts_10m_max)
        let dailyData2 = dailyDataService.add(
            time: secondDailyData.time,
            temperature_2m_max: secondDailyData.temperature_2m_max,
            temperature_2m_min: secondDailyData.temperature_2m_min,
            rain_sum: secondDailyData.rain_sum,
            snowfall_sum: secondDailyData.snowfall_sum,
            windspeed_10m_max: secondDailyData.windspeed_10m_max,
            windgusts_10m_max: secondDailyData.windgusts_10m_max)
        
        var dailyData = dailyDataService.getAllDailyData()
        XCTAssertEqual(dailyData?.count, 2)
        
        let dailyDataToDelete = dailyDataService.getDailyData(with: dailyData2.objectID)
        dailyDataService.delete(dailyDataToDelete!)
        dailyData = dailyDataService.getAllDailyData()
        XCTAssertEqual(dailyData?.count, 1)
        XCTAssertEqual(dailyData?[0].tempMax, [62.7, 58.1, 62.1, 63.4, 67.3])
    }
    
}
