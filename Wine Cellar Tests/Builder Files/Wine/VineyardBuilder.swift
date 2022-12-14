import CoreLocation
import Foundation

final class VineyardBuilder {
    private var name = "Test Vineyard"
    private var address = "Chateau Margaux, 33460 Margaux"
    private var latitude = 45.043889
    private var longitude = -0.6687277
    
    func name(_ name: String) -> Self {
        self.name = name
        return self
    }
    
    func address(_ address: String) -> Self {
        self.address = address
        return self
    }
    
    func latitude(_ latitude: Double) -> Self {
        self.latitude = latitude
        return self
    }
    
    func longitude(_ longitude: Double) -> Self {
        self.longitude = longitude
        return self
    }

    func build() -> VineyardBuilderModel {
        return VineyardBuilderModel(name: name, address: address, latitude: latitude, longitude: longitude)
    }
}
