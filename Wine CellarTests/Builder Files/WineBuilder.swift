import Foundation

final class MainTaskBuilder {
    private var name = "Test Wine"
    private var type = Constants.WineType.still
    private var wineColor = Constants.WineColor.red
    private var vintage = 2022
    private var varietal = Constants.Varietal
    private var company = "Test Wine Company"
//    private var vineyard = VineyardBuilder().build()
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
    private var 
                             
    
    func name(_ name: String) -> Self {
        self.name = name
        return self
    }
    
    func isCompleted(_ isCompleted: Bool) -> Self {
        self.isCompleted = isCompleted
        return self
    }
    
    func dateCreated(_ dateCreated: Date) -> Self {
        self.dateCreated = dateCreated
        return self
    }
    
    func dateDue(_ dateDue: Date) -> Self {
        self.dateDue = dateDue
        return self
    }
    
    func id(_ id: UUID) -> Self {
        self.id = id
        return self
    }
    
    func build() -> TestMainTask {
        return TestMainTask(name: name, isCompleted: isCompleted, dateCreated: dateCreated, dateDue: dateDue, id: id)
    }
}
