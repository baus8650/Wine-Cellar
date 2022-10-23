import Foundation

struct SmellDetailsBuilderModel {
    let primaryAroma: [Scent]
    let secondaryAroma: [Scent]?
    let tertiaryAroma: [Scent]?
}

struct ScentBuilderModel {
    let name: String
}
