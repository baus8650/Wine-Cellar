import Foundation
import UIKit

struct WineBuilderModel {
    let type: Constants.WineType
    let wineColor: Constants.WineColor
    let vintage: Int
    let varietal: Constants.Varietal
    let company: String
    let vineyard: VineyardBuilderModel?
    let ava: String?
    let abv: Float
    let visualDetails: VisualDetailsBuilderModel?
    let tasteDetails: TasteDetailsBuilderModel?
    let smellDetails: SmellDetailsBuilderModel?
    let notes: NotesBuilderModel?
    let personalDetails: PersonalDetailsBuilderModel
    var historicalWeather: WeatherDataBuilderModel
    let numberOwned: Int
    let image: UIImage?
    let foodPairings: FoodPairingsBuilderModel?
    var isFavorited: Bool = false
}
