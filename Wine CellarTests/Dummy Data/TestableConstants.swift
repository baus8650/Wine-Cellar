import Foundation

final class TestableConstants {
    
    static let testableWeather = WeatherData(
        hourly:
            HourlyData(
                time: [
                    "2012-01-01T00:00",
                    "2012-01-01T01:00",
                    "2012-01-01T02:00",
                    "2012-01-01T03:00",
                    "2012-01-01T04:00"
                ],
                temperature_2m: [
                    54.8,
                    54.9,
                    54.2,
                    53.9,
                    53.5
                ],
                relativehumidity_2m: [
                    60,
                    59,
                    58,
                    52,
                    54
                ],
                dewpoint_2m: [
                    41.3,
                    40.9,
                    39.9,
                    36.9,
                    37.4
                ],
                precipitation: [
                    0.012,
                    0.016,
                    0.016,
                    0.024,
                    0.012
                ],
                rain: [
                    0.020,
                    0.020,
                    0.031,
                    0.039,
                    0.047
                ],
                snowfall: [
                    0.00,
                    0.00,
                    0.00,
                    0.00,
                    0.00
                ],
                cloudcover: [
                    2,
                    8,
                    10,
                    8,
                    3
                ],
                soil_temperature_0_to_7cm: [
                    53.1,
                    53.1,
                    52.3,
                    52.0,
                    51.4
                ],
                soil_temperature_7_to_28cm: [
                    54.2,
                    54.1,
                    53.9,
                    53.8,
                    53.7
                ],
                soil_temperature_28_to_100cm: [
                    53.3,
                    53.3,
                    53.3,
                    53.4,
                    53.4
                ],
                soil_temperature_100_to_255cm: [
                    55.4,
                    55.4,
                    55.4,
                    55.4,
                    55.4
                ],
                soil_moisture_0_to_7cm: [
                    0.119,
                    0.147,
                    0.163,
                    0.163,
                    0.163
                ],
                soil_moisture_7_to_28cm: [
                    0.131,
                    0.118,
                    0.118,
                    0.158,
                    0.126
                ],
                soil_moisture_28_to_100cm: [
                    0.134,
                    0.123,
                    0.115,
                    0.121,
                    0.140
                ],
                soil_moisture_100_to_255cm: [
                    0.139,
                    0.134,
                    0.129,
                    0.128,
                    0.128
                ]),
        daily:
            DailyData(
                time: [
                    "2012-01-01",
                    "2012-01-02",
                    "2012-01-03",
                    "2012-01-04",
                    "2012-01-05"
                ],
                temperature_2m_max: [
                    62.7,
                    58.1,
                    62.1,
                    63.4,
                    67.3
                ],
                temperature_2m_min: [
                    50.7,
                    49.0,
                    49.8,
                    48.6,
                    49.0
                ],
                rain_sum: [
                    0.000,
                    0.040,
                    0.870,
                    0.030,
                    0.930,
                ],
                snowfall_sum: [
                    0.00,
                    0.00,
                    0.00,
                    0.00,
                    0.00,
                ],
                windspeed_10m_max: [
                    7.9,
                    11.3,
                    11.2,
                    7.7,
                    12.6
                ],
                windgusts_10m_max: [
                    12.5,
                    19.9,
                    16.8,
                    12.3,
                    19.7
                ]))
}
