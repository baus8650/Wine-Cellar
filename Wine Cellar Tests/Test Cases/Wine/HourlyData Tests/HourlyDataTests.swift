import CoreData
@testable import Wine_Cellar
import XCTest

final class HourlyDataTests: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var hourlyDataService: HourlyDataService!
    let newHourlyData = HourlyDataBuilder().build()
    let secondHourlyData = HourlyDataBuilder()
        .cloudcover([0,1,2])
        .build()
    
    override func setUpWithError() throws {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        hourlyDataService = HourlyDataService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        coreDataStack = nil
        hourlyDataService = nil
    }
    
    func testAddHourlyData() throws {
        let hourlyData = hourlyDataService.add(
            time: newHourlyData.time,
            temperature_2m: newHourlyData.temperature_2m,
            relativehumidity_2m: newHourlyData.relativehumidity_2m,
            dewpoint_2m: newHourlyData.dewpoint_2m,
            precipitation: newHourlyData.precipitation,
            rain: newHourlyData.rain,
            snowfall: newHourlyData.snowfall,
            cloudcover: newHourlyData.cloudcover,
            soil_temperature_0_to_7cm: newHourlyData.soil_temperature_0_to_7cm,
            soil_temperature_7_to_28cm: newHourlyData.soil_temperature_7_to_28cm,
            soil_temperature_28_to_100cm: newHourlyData.soil_temperature_28_to_100cm,
            soil_temperature_100_to_255cm: newHourlyData.soil_temperature_100_to_255cm,
            soil_moisture_0_to_7cm: newHourlyData.soil_moisture_0_to_7cm,
            soil_moisture_7_to_28cm: newHourlyData.soil_moisture_7_to_28cm,
            soil_moisture_28_to_100cm: newHourlyData.soil_moisture_28_to_100cm,
            soil_moisture_100_to_255cm: newHourlyData.soil_moisture_100_to_255cm)
        XCTAssertEqual(hourlyData.cloudcover, [2, 8, 10, 8, 3])
    }
    
    func testGetAllHourlyDetails() throws {
        let _ = hourlyDataService.add(
            time: newHourlyData.time,
            temperature_2m: newHourlyData.temperature_2m,
            relativehumidity_2m: newHourlyData.relativehumidity_2m,
            dewpoint_2m: newHourlyData.dewpoint_2m,
            precipitation: newHourlyData.precipitation,
            rain: newHourlyData.rain,
            snowfall: newHourlyData.snowfall,
            cloudcover: newHourlyData.cloudcover,
            soil_temperature_0_to_7cm: newHourlyData.soil_temperature_0_to_7cm,
            soil_temperature_7_to_28cm: newHourlyData.soil_temperature_7_to_28cm,
            soil_temperature_28_to_100cm: newHourlyData.soil_temperature_28_to_100cm,
            soil_temperature_100_to_255cm: newHourlyData.soil_temperature_100_to_255cm,
            soil_moisture_0_to_7cm: newHourlyData.soil_moisture_0_to_7cm,
            soil_moisture_7_to_28cm: newHourlyData.soil_moisture_7_to_28cm,
            soil_moisture_28_to_100cm: newHourlyData.soil_moisture_28_to_100cm,
            soil_moisture_100_to_255cm: newHourlyData.soil_moisture_100_to_255cm)
        let _ = hourlyDataService.add(
            time: secondHourlyData.time,
            temperature_2m: secondHourlyData.temperature_2m,
            relativehumidity_2m: secondHourlyData.relativehumidity_2m,
            dewpoint_2m: secondHourlyData.dewpoint_2m,
            precipitation: secondHourlyData.precipitation,
            rain: secondHourlyData.rain,
            snowfall: secondHourlyData.snowfall,
            cloudcover: secondHourlyData.cloudcover,
            soil_temperature_0_to_7cm: secondHourlyData.soil_temperature_0_to_7cm,
            soil_temperature_7_to_28cm: secondHourlyData.soil_temperature_7_to_28cm,
            soil_temperature_28_to_100cm: secondHourlyData.soil_temperature_28_to_100cm,
            soil_temperature_100_to_255cm: secondHourlyData.soil_temperature_100_to_255cm,
            soil_moisture_0_to_7cm: secondHourlyData.soil_moisture_0_to_7cm,
            soil_moisture_7_to_28cm: secondHourlyData.soil_moisture_7_to_28cm,
            soil_moisture_28_to_100cm: secondHourlyData.soil_moisture_28_to_100cm,
            soil_moisture_100_to_255cm: secondHourlyData.soil_moisture_100_to_255cm)
        
        let hourlyData = hourlyDataService.getAllHourlyData()
        XCTAssertEqual(hourlyData?.count, 2)
    }
    
    func testGetSingleTasteDetail() throws {
        let hourlyData1 = hourlyDataService.add(
            time: newHourlyData.time,
            temperature_2m: newHourlyData.temperature_2m,
            relativehumidity_2m: newHourlyData.relativehumidity_2m,
            dewpoint_2m: newHourlyData.dewpoint_2m,
            precipitation: newHourlyData.precipitation,
            rain: newHourlyData.rain,
            snowfall: newHourlyData.snowfall,
            cloudcover: newHourlyData.cloudcover,
            soil_temperature_0_to_7cm: newHourlyData.soil_temperature_0_to_7cm,
            soil_temperature_7_to_28cm: newHourlyData.soil_temperature_7_to_28cm,
            soil_temperature_28_to_100cm: newHourlyData.soil_temperature_28_to_100cm,
            soil_temperature_100_to_255cm: newHourlyData.soil_temperature_100_to_255cm,
            soil_moisture_0_to_7cm: newHourlyData.soil_moisture_0_to_7cm,
            soil_moisture_7_to_28cm: newHourlyData.soil_moisture_7_to_28cm,
            soil_moisture_28_to_100cm: newHourlyData.soil_moisture_28_to_100cm,
            soil_moisture_100_to_255cm: newHourlyData.soil_moisture_100_to_255cm)
        let hourlyData2 = hourlyDataService.add(
            time: secondHourlyData.time,
            temperature_2m: secondHourlyData.temperature_2m,
            relativehumidity_2m: secondHourlyData.relativehumidity_2m,
            dewpoint_2m: secondHourlyData.dewpoint_2m,
            precipitation: secondHourlyData.precipitation,
            rain: secondHourlyData.rain,
            snowfall: secondHourlyData.snowfall,
            cloudcover: secondHourlyData.cloudcover,
            soil_temperature_0_to_7cm: secondHourlyData.soil_temperature_0_to_7cm,
            soil_temperature_7_to_28cm: secondHourlyData.soil_temperature_7_to_28cm,
            soil_temperature_28_to_100cm: secondHourlyData.soil_temperature_28_to_100cm,
            soil_temperature_100_to_255cm: secondHourlyData.soil_temperature_100_to_255cm,
            soil_moisture_0_to_7cm: secondHourlyData.soil_moisture_0_to_7cm,
            soil_moisture_7_to_28cm: secondHourlyData.soil_moisture_7_to_28cm,
            soil_moisture_28_to_100cm: secondHourlyData.soil_moisture_28_to_100cm,
            soil_moisture_100_to_255cm: secondHourlyData.soil_moisture_100_to_255cm)
        
        let fetchedHourlyData1 = hourlyDataService.getHourlyData(with: hourlyData1.objectID)
        let fetchedHourlyData2 = hourlyDataService.getHourlyData(with: hourlyData2.objectID)
        XCTAssertEqual(fetchedHourlyData1?.cloudcover, [2, 8, 10, 8, 3])
        XCTAssertEqual(fetchedHourlyData2?.cloudcover, [0, 1, 2])
    }
    
    func testUpdateTasteDetails() throws {
        let hourlyData1 = hourlyDataService.add(
            time: newHourlyData.time,
            temperature_2m: newHourlyData.temperature_2m,
            relativehumidity_2m: newHourlyData.relativehumidity_2m,
            dewpoint_2m: newHourlyData.dewpoint_2m,
            precipitation: newHourlyData.precipitation,
            rain: newHourlyData.rain,
            snowfall: newHourlyData.snowfall,
            cloudcover: newHourlyData.cloudcover,
            soil_temperature_0_to_7cm: newHourlyData.soil_temperature_0_to_7cm,
            soil_temperature_7_to_28cm: newHourlyData.soil_temperature_7_to_28cm,
            soil_temperature_28_to_100cm: newHourlyData.soil_temperature_28_to_100cm,
            soil_temperature_100_to_255cm: newHourlyData.soil_temperature_100_to_255cm,
            soil_moisture_0_to_7cm: newHourlyData.soil_moisture_0_to_7cm,
            soil_moisture_7_to_28cm: newHourlyData.soil_moisture_7_to_28cm,
            soil_moisture_28_to_100cm: newHourlyData.soil_moisture_28_to_100cm,
            soil_moisture_100_to_255cm: newHourlyData.soil_moisture_100_to_255cm)
        let oldHourlyData = hourlyDataService.getHourlyData(with: hourlyData1.objectID)
        XCTAssertEqual(oldHourlyData?.cloudcover, [2, 8, 10, 8, 3])
        
        let updatedHourlyData = hourlyDataService.getHourlyData(with: hourlyData1.objectID)
        updatedHourlyData?.cloudcover = [0, 1]
        hourlyDataService.update(updatedHourlyData!)
        
        let newHourlyData = hourlyDataService.getHourlyData(with: hourlyData1.objectID)
        XCTAssertEqual(newHourlyData?.cloudcover, [0, 1])
    }
    
    func testDeleteTasteDetails() throws {
        let _ = hourlyDataService.add(
            time: newHourlyData.time,
            temperature_2m: newHourlyData.temperature_2m,
            relativehumidity_2m: newHourlyData.relativehumidity_2m,
            dewpoint_2m: newHourlyData.dewpoint_2m,
            precipitation: newHourlyData.precipitation,
            rain: newHourlyData.rain,
            snowfall: newHourlyData.snowfall,
            cloudcover: newHourlyData.cloudcover,
            soil_temperature_0_to_7cm: newHourlyData.soil_temperature_0_to_7cm,
            soil_temperature_7_to_28cm: newHourlyData.soil_temperature_7_to_28cm,
            soil_temperature_28_to_100cm: newHourlyData.soil_temperature_28_to_100cm,
            soil_temperature_100_to_255cm: newHourlyData.soil_temperature_100_to_255cm,
            soil_moisture_0_to_7cm: newHourlyData.soil_moisture_0_to_7cm,
            soil_moisture_7_to_28cm: newHourlyData.soil_moisture_7_to_28cm,
            soil_moisture_28_to_100cm: newHourlyData.soil_moisture_28_to_100cm,
            soil_moisture_100_to_255cm: newHourlyData.soil_moisture_100_to_255cm)
        let hourlyData2 = hourlyDataService.add(
            time: secondHourlyData.time,
            temperature_2m: secondHourlyData.temperature_2m,
            relativehumidity_2m: secondHourlyData.relativehumidity_2m,
            dewpoint_2m: secondHourlyData.dewpoint_2m,
            precipitation: secondHourlyData.precipitation,
            rain: secondHourlyData.rain,
            snowfall: secondHourlyData.snowfall,
            cloudcover: secondHourlyData.cloudcover,
            soil_temperature_0_to_7cm: secondHourlyData.soil_temperature_0_to_7cm,
            soil_temperature_7_to_28cm: secondHourlyData.soil_temperature_7_to_28cm,
            soil_temperature_28_to_100cm: secondHourlyData.soil_temperature_28_to_100cm,
            soil_temperature_100_to_255cm: secondHourlyData.soil_temperature_100_to_255cm,
            soil_moisture_0_to_7cm: secondHourlyData.soil_moisture_0_to_7cm,
            soil_moisture_7_to_28cm: secondHourlyData.soil_moisture_7_to_28cm,
            soil_moisture_28_to_100cm: secondHourlyData.soil_moisture_28_to_100cm,
            soil_moisture_100_to_255cm: secondHourlyData.soil_moisture_100_to_255cm)
        
        var hourlyData = hourlyDataService.getAllHourlyData()
        XCTAssertEqual(hourlyData?.count, 2)
        
        let hourlyDataToDelete = hourlyDataService.getHourlyData(with: hourlyData2.objectID)
        hourlyDataService.delete(hourlyDataToDelete!)
        hourlyData = hourlyDataService.getAllHourlyData()
        XCTAssertEqual(hourlyData?.count, 1)
        XCTAssertEqual(hourlyData?[0].cloudcover, [2, 8, 10, 8, 3])
    }
    
}
