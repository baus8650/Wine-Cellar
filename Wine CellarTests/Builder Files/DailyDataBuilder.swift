import Foundation

final class DailyDataBuilder {
    private var time = [
        "2012-01-01",
        "2012-01-02",
        "2012-01-03",
        "2012-01-04",
        "2012-01-05"
    ]
    private var temperature_2m_max = [
        62.7,
        58.1,
        62.1,
        63.4,
        67.3
    ]
    private var temperature_2m_min = [
        50.7,
        49.0,
        49.8,
        48.6,
        49.0
    ]
    private var rain_sum = [
        0.000,
        0.040,
        0.870,
        0.030,
        0.930,
    ]
    private var snowfall_sum = [
        0.00,
        0.00,
        0.00,
        0.00,
        0.00,
    ]
    private var windspeed_10m_max = [
        7.9,
        11.3,
        11.2,
        7.7,
        12.6
    ]
    private var windgusts_10m_max = [
        12.5,
        19.9,
        16.8,
        12.3,
        19.7
    ]
    
    func time(_ time: [String]) -> Self {
        self.time = time
        return self
    }
    
    func temperature_2m_max(_ temperature_2m_max: [Double]) -> Self {
        self.temperature_2m_max = temperature_2m_max
        return self
    }
    
    func temperature_2m_min(_ temperature_2m_min: [Double]) -> Self {
        self.temperature_2m_min = temperature_2m_min
        return self
    }
    
    func rain_sum(_ rain_sum: [Double]) -> Self {
        self.rain_sum = rain_sum
        return self
    }
    
    func snowfall_sum(_ snowfall_sum: [Double]) -> Self {
        self.snowfall_sum = snowfall_sum
        return self
    }
    
    func windspeed_10m_max(_ windspeed_10m_max: [Double]) -> Self {
        self.windspeed_10m_max = windspeed_10m_max
        return self
    }
    
    func windgusts_10m_max(_ windgusts_10m_max: [Double]) -> Self {
        self.windgusts_10m_max = windgusts_10m_max
        return self
    }
    
    func build() -> DailyDataBuilderModel {
        return DailyDataBuilderModel(
            time: time, 
            temperature_2m_max: temperature_2m_max, 
            temperature_2m_min: temperature_2m_min, 
            rain_sum: rain_sum, 
            snowfall_sum: snowfall_sum, 
            windspeed_10m_max: windspeed_10m_max, 
            windgusts_10m_max: windgusts_10m_max)
    }
}
