import Foundation

final class HourlyDataBuilder {
    private var time = [
        "2012-01-01T00:00",
        "2012-01-01T01:00",
        "2012-01-01T02:00",
        "2012-01-01T03:00",
        "2012-01-01T04:00"
    ]
    private var temperature_2m = [
        54.8,
        54.9,
        54.2,
        53.9,
        53.5
    ]
    private var relativehumidity_2m = [
        60,
        59,
        58,
        52,
        54
    ]
    private var dewpoint_2m = [
        41.3,
        40.9,
        39.9,
        36.9,
        37.4
    ]
    private var precipitation = [
        0.012,
        0.016,
        0.016,
        0.024,
        0.012
    ]
    private var rain = [
        0.020,
        0.020,
        0.031,
        0.039,
        0.047
    ]
    private var snowfall = [
        0.00,
        0.00,
        0.00,
        0.00,
        0.00
    ]
    private var cloudcover = [
        2,
        8,
        10,
        8,
        3
    ]
    private var soil_temperature_0_to_7cm = [
        53.1,
        53.1,
        52.3,
        52.0,
        51.4
    ]
    private var soil_temperature_7_to_28cm = [
        54.2,
        54.1,
        53.9,
        53.8,
        53.7
    ]
    private var soil_temperature_28_to_100cm = [
        53.3,
        53.3,
        53.3,
        53.4,
        53.4
    ]
    private var soil_temperature_100_to_255cm = [
        55.4,
        55.4,
        55.4,
        55.4,
        55.4
    ]
    private var soil_moisture_0_to_7cm = [
        0.119,
        0.147,
        0.163,
        0.163,
        0.163
    ]
    private var soil_moisture_7_to_28cm = [
        0.131,
        0.118,
        0.118,
        0.158,
        0.126
    ]
    private var soil_moisture_28_to_100cm = [
        0.134,
        0.123,
        0.115,
        0.121,
        0.140
    ]
    private var soil_moisture_100_to_255cm = [
        0.139,
        0.134,
        0.129,
        0.128,
        0.128
    ]
    
    func time(_ time: [String]) -> Self {
        self.time = time
        return self
    }
    
    func temperature_2m(_ temperature_2m: [Double]) -> Self {
        self.temperature_2m = temperature_2m
        return self
    }
    
    func relativehumidity_2m(_ relativehumidity_2m: [Int]) -> Self {
        self.relativehumidity_2m = relativehumidity_2m
        return self
    }
    
    func dewpoint_2m(_ dewpoint_2m: [Double]) -> Self {
        self.dewpoint_2m = dewpoint_2m
        return self
    }
    
    func precipitation(_ precipitation: [Double]) -> Self {
        self.precipitation = precipitation
        return self
    }
    
    func rain(_ rain: [Double]) -> Self {
        self.rain = rain
        return self
    }
    
    func snowfall(_ snowfall: [Double]) -> Self {
        self.snowfall = snowfall
        return self
    }
    
    func cloudcover(_ cloudcover: [Int]) -> Self {
        self.cloudcover = cloudcover
        return self
    }
    
    func soil_temperature_0_to_7cm(_ soil_temperature_0_to_7cm: [Double]) -> Self {
        self.soil_temperature_0_to_7cm = soil_temperature_0_to_7cm
        return self
    }
    
    func soil_temperature_7_to_28cm(_ soil_temperature_7_to_28cm: [Double]) -> Self {
        self.soil_temperature_7_to_28cm = soil_temperature_7_to_28cm
        return self
    }
    
    func soil_temperature_28_to_100cm(_ soil_temperature_28_to_100cm: [Double]) -> Self {
        self.soil_temperature_28_to_100cm = soil_temperature_28_to_100cm
        return self
    }
    
    func soil_temperature_100_to_255cm(_ soil_temperature_100_to_255cm: [Double]) -> Self {
        self.soil_temperature_100_to_255cm = soil_temperature_100_to_255cm
        return self
    }
    
    func soil_moisture_0_to_7cm(_ soil_moisture_0_to_7cm: [Double]) -> Self {
        self.soil_moisture_0_to_7cm = soil_moisture_0_to_7cm
        return self
    }
    
    func soil_moisture_7_to_28cm(_ soil_moisture_7_to_28cm: [Double]) -> Self {
        self.soil_moisture_7_to_28cm = soil_moisture_7_to_28cm
        return self
    }
    
    func soil_moisture_28_to_100cm(_ soil_moisture_28_to_100cm: [Double]) -> Self {
        self.soil_moisture_28_to_100cm = soil_moisture_28_to_100cm
        return self
    }
    
    func soil_moisture_100_to_255cm(_ soil_moisture_100_to_255cm: [Double]) -> Self {
        self.soil_moisture_100_to_255cm = soil_moisture_100_to_255cm
        return self
    }
    
    func build() -> HourlyDataBuilderModel {
        return HourlyDataBuilderModel(
            time: time,
            temperature_2m: temperature_2m,
            relativehumidity_2m: relativehumidity_2m,
            dewpoint_2m: dewpoint_2m,
            precipitation: precipitation,
            rain: rain,
            snowfall: snowfall,
            cloudcover: cloudcover,
            soil_temperature_0_to_7cm: soil_temperature_0_to_7cm,
            soil_temperature_7_to_28cm: soil_temperature_7_to_28cm,
            soil_temperature_28_to_100cm: soil_temperature_28_to_100cm,
            soil_temperature_100_to_255cm: soil_temperature_100_to_255cm,
            soil_moisture_0_to_7cm: soil_moisture_0_to_7cm,
            soil_moisture_7_to_28cm: soil_moisture_7_to_28cm,
            soil_moisture_28_to_100cm: soil_moisture_28_to_100cm,
            soil_moisture_100_to_255cm: soil_moisture_100_to_255cm)
    }
}
