import Foundation

final class FlightBuilder {
    private var numberOfWines: Int16 = 1
    
    func numberOfWines(_ numberOfWines: Int16) -> Self {
        self.numberOfWines = numberOfWines
        return self
    }
    
    func build() -> FlightBuilderModel {
        return FlightBuilderModel(numberOfWines: numberOfWines)
    }
}
