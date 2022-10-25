import Foundation

final class FoodPairingsBuilder {
    private var foodPairings = [FoodPairingBuilder().build()]
    
    func foodPairings(_ foodPairings: [FoodPairingBuilderModel]) -> Self {
        self.foodPairings = foodPairings
        return self
    }
    
    func build() -> FoodPairingsBuilderModel {
        return FoodPairingsBuilderModel(foodPairings: foodPairings)
    }
}
