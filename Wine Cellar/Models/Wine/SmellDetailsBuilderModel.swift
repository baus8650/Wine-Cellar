import Foundation

struct SmellDetailsBuilderModel {
    let id: UUID
    let date: Date
    let primaryAroma: [String]?
    let secondaryAroma: [String]?
    let tertiaryAroma: [String]?
}
