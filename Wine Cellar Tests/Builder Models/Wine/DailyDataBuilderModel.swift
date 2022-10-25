import Foundation

struct DailyDataBuilderModel {
    let time: [String]
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let rain_sum: [Double]
    let snowfall_sum: [Double]
    let windspeed_10m_max: [Double]
    let windgusts_10m_max: [Double]
}
