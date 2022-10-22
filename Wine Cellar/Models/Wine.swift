import Foundation
import UIKit

struct Wine {
    let name: String
    let vintage: Int
    let varietal: String
    let company: String
    let vineyard: Vineyard?
    let ava: String?
    let abv: Double
    let visualDetails: VisualDetails?
    let tasteDetails: TasteDetails?
    let smellDetails: SmellDetails?
    let notes: Note?
    let personalDetails: PersonalDetails
    let numberOwned: Int
    let image: UIImage
    var isFavorited: Bool = false
}
