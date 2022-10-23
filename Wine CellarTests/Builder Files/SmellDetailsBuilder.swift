import Foundation

final class SmellDetailsBuilder {
    private var primaryAroma = [ScentBuilder().name("Primary Aroma").build()]
    private var secondaryAroma = [ScentBuilder().name("Secondary Aroma").build()]
    private var tertiaryAroma = [ScentBuilder().name("Tertiary Aroma").build()]
    
    func primaryAroma(_ primaryAroma: [ScentBuilderModel]) -> Self {
        self.primaryAroma = primaryAroma
        return self
    }
    
    func secondaryAroma(_ secondaryAroma: [ScentBuilderModel]) -> Self {
        self.secondaryAroma = secondaryAroma
        return self
    }
    
    func tertiaryAroma(_ tertiaryAroma: [ScentBuilderModel]) -> Self {
        self.tertiaryAroma = tertiaryAroma
        return self
    }
    
    func build() -> SmellDetailsBuilderModel {
        SmellDetailsBuilderModel(primaryAroma: primaryAroma, secondaryAroma: secondaryAroma, tertiaryAroma: tertiaryAroma)
    }
    
}
