import Foundation

final class ScentBuilder {
    private var name = "Test Scent"
    
    func name(_ name: String) -> Self {
        self.name = name
        return self
    }
    
    func build() -> ScentBuilderModel {
        return ScentBuilderModel(name: name)
    }
}
