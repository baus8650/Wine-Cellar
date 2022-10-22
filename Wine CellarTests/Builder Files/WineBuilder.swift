import Foundation

final class WineBuilder {
    private var name = "Test Wine"
    private var type = Constants.WineType.still
    private var wineColor = Constants.WineColor.red
    private var vintage = 2022
    private var varietal = Constants.Varietal
    private var company = "Test Wine Company"
    private var vineyard = VineyardBuilder().build()
    private var ava = "Test AVA"
    private var abv = 12.5
    private var visualDetails = VisualDetails(
        Color: .red,
        viscosity: Constants.ViscosityLevel.medium,
        clarity: Constants.ClarityLevel.brilliant)
    private var tasteDetails = TasteDetails(
        body: Constants.WineBody.full,
        sweetness: Constants.Sweetness.dry,
        alcohol: Constants.AlcoholLevel.neutral,
        acidityLevel: Constants.AcidityLevel.neutral,
        tanninLevel: Constants.TanninLevel.neutral)
    private var smellDetails = SmellDetails(
        primaryAroma: [Scent(name: "Primary Aroma")],
        secondaryAroma: [Scent(name: "Secondary Aroma")],
        tertiaryAroma: [Scent(name: "Tertiary Aroma")])
    private var notes = Note(
        tastingNotes: [
            TastingNote(
                noteOrigin: Constants.TastingNotesOrigin.userGenerated,
                tastingNoteText: "Test Tasting Note")
        ])
    private var personalDetails = PersonalDetails(
        opinions: "Test Opinion",
        mood: "Test Mood")
    private var historicalWeather = WeatherData(hourly: [], daily: [])
    private var numberOwned = 1
    private var image = nil
    private var isFavorited: Bool = true
    
    
    func name(_ name: String) -> Self {
        self.name = name
        return self
    }
    
    func type(_ type: Constants.WineType) -> Self {
        self.type = type
        return self
    }
    func wineColor(_ wineColor: UIColor) -> Self {
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
    func abv(_ abv: Double) -> Self {
        self.abv = abv
        return self
    }
    func visualDetails(_ visualDetails: VisualDetails) -> Self {
        self.visualDetails = visualDetails
        return self
    }
    func tasteDetails(_ tasteDetails: TasteDetails) -> Self {
        self.tasteDetails = tasteDetails
        return self
    }
    func smellDetails(_ smellDetails: SmellDetails) -> Self {
        self.smellDetails = smellDetails
        return self
    }
    func notes(_ notes: Note) -> Self {
        self.notes = notes
        return self
    }
    func personalDetails(_ personalDetails: PersonalDetails) -> Self {
        self.personalDetails = personalDetails
        return self
    }
    func historicalWeather(_ historicalWeather: WeatherData) -> Self {
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
    func isFavorited(_ isFavorited: Bool) -> Self {
        self.isFavorited = isFavorited
        return self
    }
    
    
    func build() -> Wine {
        return Wine(name: name, type: type, wineColor: wineColor, vintage: vintage, varietal: varietal, company: company, vineyard: vineyard, ava: ava, abv: abv, visualDetails: visualDetails, tasteDetails: tasteDetails, smellDetails: smellDetails, notes: notes, personalDetails: personalDetails, historicalWeather: historicalWeather, numberOwned: numberOwned, image: image, isFavorited: isFavorited)
    }
}
