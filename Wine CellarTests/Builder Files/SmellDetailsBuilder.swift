import Foundation

final class SmellDetailsBuilder {
    private var id = UUID(uuidString: "C5016210-5BEB-437F-8A11-944973966B3F")!
    private var primaryAroma = ["Primary Aroma"]
    private var secondaryAroma = ["Secondary Aroma"]
    private var tertiaryAroma = ["Tertiary Aroma"]
    
    func id(_ id: UUID) -> Self {
        self.id = id
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
        SmellDetailsBuilderModel(id: id, primaryAroma: primaryAroma, secondaryAroma: secondaryAroma, tertiaryAroma: tertiaryAroma)
    }
    
}
