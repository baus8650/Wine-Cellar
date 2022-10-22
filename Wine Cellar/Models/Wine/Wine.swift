import Foundation
import UIKit

struct Wine {
    let name: String
    let type: Constants.WineType
    let wineColor: Constants.WineColor
    let vintage: Int
    let varietal: Constants.Varietal
    let company: String
    let vineyard: Vineyard?
    let ava: String?
    let abv: Double
    let visualDetails: VisualDetails?
    let tasteDetails: TasteDetails?
    let smellDetails: SmellDetails?
    let notes: Note?
    let personalDetails: PersonalDetails
    var historicalWeather: WeatherData
    let numberOwned: Int
    let image: UIImage
    var isFavorited: Bool = false
}
