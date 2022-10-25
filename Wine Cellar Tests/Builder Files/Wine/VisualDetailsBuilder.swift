import Foundation

final class VisualDetailsBuilder {
    private var color = "640700"
    private var viscosity = Constants.ViscosityLevel.noResponse
    private var clarity = Constants.ClarityLevel.noResponse
    
    func color(_ color: String) -> Self {
        self.color = color
        return self
    }
    
    func viscosity(_ viscosity: Constants.ViscosityLevel) -> Self {
        self.viscosity = viscosity
        return self
    }
    
    func clarity(_ clarity: Constants.ClarityLevel) -> Self {
        self.clarity = clarity
        return self
    }
    
    func build() -> VisualDetailsBuilderModel {
        return VisualDetailsBuilderModel(Color: color, viscosity: viscosity, clarity: clarity)
    }
}
