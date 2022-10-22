import Foundation
import UIKit

struct VisualDetails {
    let Color: UIColor
    let viscosity: ViscosityLevel
    let clarity: ClarityLevel
    
    enum ViscosityLevel {
        case low
        case medium
        case high
    }
    
    enum ClarityLevel {
        case brilliant
        case clear
        case dull
        case hazy
    }
}
