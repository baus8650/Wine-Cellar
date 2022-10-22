import Foundation

struct TasteDetails {
    let body: WineBody
    let sweetness: Sweetness
    let alcohol: AlcoholLevel
    let acidityLevel: AcidityLevel
    let tanninLevel: TanninLevel
    
    enum WineBody {
        case light
        case medium
        case full
    }
    
    enum Sweetness {
        case boneDry
        case dry
        case semiSweet
        case sweet
        case verySweet
    }
    
    enum AlcoholLevel {
        case extremelyLow
        case low
        case neutral
        case high
        case extremelyHigh
    }
    
    enum AcidityLevel {
        case extremelyLow
        case low
        case neutral
        case high
        case extremelyHigh
    }
    
    enum TanninLevel {
        case extremelyLow
        case low
        case neutral
        case high
        case extremelyHigh
    }
}
