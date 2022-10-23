import Foundation

final class SmellDetailsBuilder {
    private var primaryAroma = ["Primary Aroma"]
    private var secondaryAroma = ["Secondary Aroma"]
    private var tertiaryAroma = ["Tertiary Aroma"]
    
    func primaryAroma(_ primaryAroma: [String]) -> Self {
        self.primaryAroma = primaryAroma
        return self
    }
    
    func secondaryAroma(_ secondaryAroma: [String]) -> Self {
        self.secondaryAroma = secondaryAroma
        return self
    }
    
    func tertiaryAroma(_ tertiaryAroma: [String]) -> Self {
        self.tertiaryAroma = tertiaryAroma
        return self
    }
    
    func build() -> SmellDetailsBuilderModel {
        SmellDetailsBuilderModel(primaryAroma: primaryAroma, secondaryAroma: secondaryAroma, tertiaryAroma: tertiaryAroma)
    }
    
}
