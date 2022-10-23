import Foundation
import UIKit

final class WineBuilder {
    private var name = "Test Wine"
    private var type = Constants.WineType.still
    private var wineColor = Constants.WineColor.red
    private var vintage = 2022
    private var varietal = Constants.Varietal.pinoNoir
    private var company = "Test Wine Company"
    private var vineyard = VineyardBuilder().build()
    private var ava = "Test AVA"
    private var abv: Float = 12.5
    private var visualDetails = VisualDetailsBuilder().build()
    private var tasteDetails = TasteDetailsBuilder().build()
    private var smellDetails = SmellDetailsBuilder().build()
    private var notes = NotesBuilder().build()
    private var personalDetails = PersonalDetailsBuilder().build()
    private var historicalWeather = WeatherDataBuilder().build()
    private var foodPairings = FoodPairingsBuilder().build()
    private var numberOwned = 1
    private var image: UIImage? = nil
    private var isFavorited: Bool = true
    
    
    func name(_ name: String) -> Self {
        self.name = name
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
    func notes(_ notes: NotesBuilderModel) -> Self {
        self.notes = notes
        return self
    }
    func personalDetails(_ personalDetails: PersonalDetailsBuilderModel) -> Self {
        self.personalDetails = personalDetails
        return self
    }
    func historicalWeather(_ historicalWeather: WeatherDataBuilderModel) -> Self {
        self.historicalWeather = historicalWeather
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
    func foodPairings(_ foodPairings: FoodPairingsBuilderModel) -> Self {
        self.foodPairings = foodPairings
        return self
    }
    func isFavorited(_ isFavorited: Bool) -> Self {
        self.isFavorited = isFavorited
        return self
    }
    
    
    func build() -> WineBuilderModel {
        return WineBuilderModel(type: type, wineColor: wineColor, vintage: vintage, varietal: varietal, company: company, vineyard: vineyard, ava: ava, abv: abv, visualDetails: visualDetails, tasteDetails: tasteDetails, smellDetails: smellDetails, notes: notes, personalDetails: personalDetails, historicalWeather: historicalWeather, numberOwned: numberOwned, image: image,foodPairings: foodPairings, isFavorited: isFavorited)
    }
}
