//
//  WeatherData.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 10/21/22.
//

import Foundation

struct HourlyDataBuilderModel {
    let time: [String]
    let temperature_2m: [Double]
    let relativehumidity_2m: [Int]
    let dewpoint_2m: [Double]
    let precipitation: [Double]
    let rain: [Double]
    let snowfall: [Double]
    let cloudcover: [Int]
    let soil_temperature_0_to_7cm: [Double]
    let soil_temperature_7_to_28cm: [Double]
    let soil_temperature_28_to_100cm: [Double]
    let soil_temperature_100_to_255cm: [Double]
    let soil_moisture_0_to_7cm: [Double]
    let soil_moisture_7_to_28cm: [Double]
    let soil_moisture_28_to_100cm: [Double]
    let soil_moisture_100_to_255cm: [Double]
}
