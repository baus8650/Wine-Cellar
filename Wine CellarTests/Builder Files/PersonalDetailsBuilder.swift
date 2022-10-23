import Foundation

final class PersonalDetailsBuilder {
    private var opinions = "Test Opinion"
    private var mood = "Test Mood"
    
    func opinions(_ opinions: String) -> Self {
        self.opinions = opinions
        return self
    }
    
    func mood(_ mood: String) -> Self {
        self.mood = mood
        return self
    }
    
    func build() -> PersonalDetailsBuilderModel {
        return PersonalDetailsBuilderModel(opinions: opinions, mood: mood)
    }
}
