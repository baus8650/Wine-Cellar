import Foundation

final class TasteDetailsBuilder {
    private var body = Constants.WineBody.noResponse
    private var sweetness = Constants.Sweetness.noResponse
    private var alcohol = Constants.AlcoholLevel.noResponse
    private var acidity = Constants.AcidityLevel.noResponse
    private var tannin = Constants.TanninLevel.noResponse
    
    func body(_ body: Constants.WineBody) -> Self {
        self.body = body
        return self
    }
    
    func sweetness(_ sweetness: Constants.Sweetness) -> Self {
        self.sweetness = sweetness
        return self
    }
    
    func alcohol(_ alcohol: Constants.AlcoholLevel) -> Self {
        self.alcohol = alcohol
        return self
    }
    
    func acidity(_ acidity: Constants.AcidityLevel) -> Self {
        self.acidity = acidity
        return self
    }
    
    func tannin(_ tannin: Constants.TanninLevel) -> Self {
        self.tannin = tannin
        return self
    }
    
    func build() -> TasteDetailsBuilderModel {
        return TasteDetailsBuilderModel(body: body, sweetness: sweetness, alcohol: alcohol, acidityLevel: acidity, tanninLevel: tannin)
    }
}
