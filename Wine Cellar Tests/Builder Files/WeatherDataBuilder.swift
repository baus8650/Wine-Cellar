import Foundation

final class WeatherDataBuilder {
    private var hourlyData = HourlyDataBuilder().build()
    private var dailyData = DailyDataBuilder().build()
    
    func hourlyData(_ hourlyData: HourlyDataBuilderModel) -> Self {
        self.hourlyData = hourlyData
        return self
    }
    
    func dailyData(_ dailyData: DailyDataBuilderModel) -> Self {
        self.dailyData = dailyData
        return self
    }
    
    func build() -> WeatherDataBuilderModel {
        return WeatherDataBuilderModel(hourly: hourlyData, daily: dailyData)
    }
}
