import CoreLocation
import Foundation

struct Vineyard {
    let name: String
    let address: String
    var latitude: Double?
    var longitude: Double?
    var location: CLLocation?
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}
