import Foundation

final class SmellDetailsBuilder {
    private var date = Date()
    private var primaryAroma = ["Primary Aroma"]
    private var secondaryAroma = ["Secondary Aroma"]
    private var tertiaryAroma = ["Tertiary Aroma"]
    
    func date(_ date: Date) -> Self {
        self.date = date
        return self
    }
    
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
        SmellDetailsBuilderModel(date: date, primaryAroma: primaryAroma, secondaryAroma: secondaryAroma, tertiaryAroma: tertiaryAroma)
    }
    
}
