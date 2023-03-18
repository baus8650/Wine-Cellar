//
//  NewWine.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 11/7/22.
//

import Foundation

struct NewWine {
    var dateAdded: Date = Date()
    var company: String = ""
    var varietal: String = ""
    var ava: String = ""
    var vintage: String = ""
    var abv: String = ""
    var numberOwn: String = ""
    var wineType: Constants.WineType = .still
    var wineColor: Constants.WineColor = .red
    var isFavorited: Bool = false
}

struct NewVineyard {
    var name: String = ""
    var address: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}

struct NewVisualDetails {
    var clarity: Int16 = 0
    var color: String = ""
    var viscosity: Int16 = 0
}

struct NewSmellDetails {
    var date: Date = Date()
    var primaryAroma: [String] = []
    var secondaryAroma: [String] = []
    var tertiaryAroma: [String] = []
}

struct NewTasteDetails {
    var body: Int16 = 0
    var sweetness: Int16 = 0
    var alcohol: Int16 = 0
    var acidity: Int16 = 0
    var tannin: Int16 = 0
}
struct NewPersonalDetails {
    var mood: String = ""
    var opinion: String = ""
}

struct NewTastingNote {
    var noteOrigin: Constants.TastingNotesOrigin = .wineryGenerated
    var tastingNoteText: String = ""
}

struct NewFoodPairing {
    var name: String = ""
}

