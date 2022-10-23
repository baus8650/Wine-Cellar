import Foundation

final class FoodPairingBuilder {
    private var name = "Food Pairing"
    
    func name(_ name: String) -> Self {
        self.name = name
        return self
    }
    
    func build() -> FoodPairingBuilderModel {
        return FoodPairingBuilderModel(name: name)
    }
}
