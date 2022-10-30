import Foundation
import UIKit

struct WineBuilderModel {
    let date: Date
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
    let tastingNotes: [TastingNoteBuilderModel]?
    let personalDetails: PersonalDetailsBuilderModel
    var hourlyData: HourlyDataBuilderModel
    var dailyData: DailyDataBuilderModel
    let numberOwned: Int
    let image: UIImage?
    let foodPairings: [FoodPairingBuilderModel]?
    var isFavorited: Bool = false
}
