import CoreLocation
import Foundation

struct VineyardBuilderModel {
    let id: UUID
    let name: String
    let address: String
    var latitude: Double?
    var longitude: Double?
}
