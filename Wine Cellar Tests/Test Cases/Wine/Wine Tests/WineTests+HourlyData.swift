import CoreData
@testable import Wine_Cellar
import XCTest

final class WineTests_HourlyData: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var wineService: WineService!
    var hourlyDataService: HourlyDataService!
    let newWine = WineBuilder().build()
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        wineService = WineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        hourlyDataService = HourlyDataService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        wineService = nil
        hourlyDataService = nil
    }
    
    func testAddHourlyDataToWine() throws {
        let newHourlyData = HourlyDataBuilder().build()
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
        
        let wineWithHourlyData = wineService.addHourlyData(hourlyData, to: wine)
        XCTAssertEqual(wineWithHourlyData.hourlyData?.cloudcover, [2, 8, 10, 8, 3])
    }
    
    func testRemoveHourlyDataFromWine() throws {
        let newHourlyData = HourlyDataBuilder().build()
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
        
        let wineWithHourlyData = wineService.addHourlyData(hourlyData, to: wine)
        XCTAssertEqual(wineWithHourlyData.hourlyData?.cloudcover, [2, 8, 10, 8, 3])
        wineService.removeHourlyData(hourlyData, from: wineWithHourlyData)
        
        let wineWithoutHourlyData = wineService.getWine(with: wineWithHourlyData.objectID)
        XCTAssertNil(wineWithoutHourlyData?.hourlyData)
        
    }
    
    func testGetWineFromHourlyData() throws {
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
        
        let newHourlyData = HourlyDataBuilder().build()
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
        
        let wineWithHourlyData = wineService.addHourlyData(hourlyData, to: wine)
        let retrievedWine = wineService.getWineFromHourlyData(with: hourlyData)
        let retrievedWineID = retrievedWine?.objectID
        
        XCTAssertEqual(originalWineID, retrievedWineID)
        
    }
    
    func testGetHourlyDataFromWine() throws {
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
        
        let newHourlyData = HourlyDataBuilder().build()
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
        
        let originalHourlyDataID = hourlyData.objectID
        
        let wineWithHourlyData = wineService.addHourlyData(hourlyData, to: wine)
        let retrievedHourlyData = wineService.getHourlyDataFromWine(with: wineWithHourlyData)
        let retrievedHourlyDataID = retrievedHourlyData?.objectID
        
        XCTAssertEqual(originalHourlyDataID, retrievedHourlyDataID)
        
    }
    
}
