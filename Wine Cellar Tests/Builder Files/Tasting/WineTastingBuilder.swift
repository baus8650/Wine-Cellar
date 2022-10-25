import Foundation

final class WineTastingBuilder {
    private var winery = "Test Winery"
    private var date = Date()
    
    func winery(_ winery: String) -> Self {
        self.winery = winery
        return self
    }
    
    func date(_ date: Date) -> Self {
        self.date = date
        return self
    }
    
    func build() -> WineTastingBuilderModel {
        return WineTastingBuilderModel(winery: winery, date: date)
    }
}
