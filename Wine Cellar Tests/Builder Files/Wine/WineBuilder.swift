import Foundation
import UIKit

final class WineBuilder {
    private var date = Date()
    private var type = Constants.WineType.still
    private var wineColor = Constants.WineColor.red
    private var vintage = 2022
    private var varietal = Constants.Varietal.pinotNoir
    private var company = "Test Wine Company"
    private var vineyard = VineyardBuilder().build()
    private var ava = "Test AVA"
    private var abv: Float = 12.5
    private var tastingNotes = [TastingNoteBuilder().build()]
    private var visualDetails = VisualDetailsBuilder().build()
    private var tasteDetails = TasteDetailsBuilder().build()
    private var smellDetails = SmellDetailsBuilder().build()
    private var personalDetails = PersonalDetailsBuilder().build()
    private var hourlyData = HourlyDataBuilder().build()
    private var dailyData = DailyDataBuilder().build()
    private var foodPairings = [FoodPairingBuilder().build()]
    private var numberOwned = 1
    private var image: UIImage? = nil
    private var isFavorited: Bool = true
    
    func date(_ date: Date) -> Self {
        self.date = date
        return self
    }
    
    func type(_ type: Constants.WineType) -> Self {
        self.type = type
        return self
    }
    
    func wineColor(_ wineColor: Constants.WineColor) -> Self {
        self.wineColor = wineColor
        return self
    }
    
    func vintage(_ vintage: Int) -> Self {
        self.vintage = vintage
        return self
    }
    
    func varietal(_ varietal: Constants.Varietal) -> Self {
        self.varietal = varietal
        return self
    }
    
    func company(_ company: String) -> Self {
        self.company = company
        return self
    }
    
    func ava(_ ava: String) -> Self {
        self.ava = ava
        return self
    }
    
    func abv(_ abv: Float) -> Self {
        self.abv = abv
        return self
    }
    
    func visualDetails(_ visualDetails: VisualDetailsBuilderModel) -> Self {
        self.visualDetails = visualDetails
        return self
    }
    
    func tasteDetails(_ tasteDetails: TasteDetailsBuilderModel) -> Self {
        self.tasteDetails = tasteDetails
        return self
    }
    
    func smellDetails(_ smellDetails: SmellDetailsBuilderModel) -> Self {
        self.smellDetails = smellDetails
        return self
    }
    
    func tastingNotes(_ tastingNotes: [TastingNoteBuilderModel]) -> Self {
        self.tastingNotes = tastingNotes
        return self
    }
    
    func personalDetails(_ personalDetails: PersonalDetailsBuilderModel) -> Self {
        self.personalDetails = personalDetails
        return self
    }
    
    func hourlyData(_ hourlyData: HourlyDataBuilderModel) -> Self {
        self.hourlyData = hourlyData
        return self
    }
    
    func dailyData(_ dailyData: DailyDataBuilderModel) -> Self {
        self.dailyData = dailyData
        return self
    }
    
    func numberOwned(_ numberOwned: Int) -> Self {
        self.numberOwned = numberOwned
        return self
    }
    
    func image(_ image: UIImage) -> Self {
        self.image = image
        return self
    }
    
    func foodPairings(_ foodPairings: [FoodPairingBuilderModel]) -> Self {
        self.foodPairings = foodPairings
        return self
    }
    
    func isFavorited(_ isFavorited: Bool) -> Self {
        self.isFavorited = isFavorited
        return self
    }
    
    func build() -> WineBuilderModel {
        return WineBuilderModel(date: date, type: type, wineColor: wineColor, vintage: vintage, varietal: varietal, company: company, vineyard: vineyard, ava: ava, abv: abv, visualDetails: visualDetails, tasteDetails: tasteDetails, smellDetails: smellDetails, tastingNotes: tastingNotes, personalDetails: personalDetails, hourlyData: hourlyData, dailyData: dailyData, numberOwned: numberOwned, image: image,foodPairings: foodPairings, isFavorited: isFavorited)
    }
}
