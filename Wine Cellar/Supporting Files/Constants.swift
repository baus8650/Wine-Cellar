//
//  Constants.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 10/21/22.
//

import Foundation

final class Constants {
    static let weatherURL = "https://archive-api.open-meteo.com/v1/era5?&start_date=2012-01-01&end_date=2012-12-31&hourly=temperature_2m,relativehumidity_2m,dewpoint_2m,precipitation,rain,snowfall,cloudcover,soil_temperature_0_to_7cm,soil_temperature_7_to_28cm,soil_temperature_28_to_100cm,soil_temperature_100_to_255cm,soil_moisture_0_to_7cm,soil_moisture_7_to_28cm,soil_moisture_28_to_100cm,soil_moisture_100_to_255cm&daily=temperature_2m_max,temperature_2m_min,rain_sum,snowfall_sum,windspeed_10m_max,windgusts_10m_max&temperature_unit=fahrenheit&windspeed_unit=mph&precipitation_unit=inch"
    
    /*
     Still needs latitude, longitude, and timezone
     let timezone = TimeZone.current.identifier
     let formattedTimezone = timezone.replacingOccurrences(of: "/", with: "%2F", options: .literal, range: nil)
     print(formattedTimezone)
     
     */
    
    enum WineType: String {
        case still = "Still"
        case sparkling = "Sparkling"
    }
    
    enum WineColor: String, CaseIterable {
        case red = "Red"
        case rose = "Rosé"
        case white = "White"
    }
    
    enum Varietal: String {
        case albariño = "Albariño"
        case aligoté = "Aligoté"
        case amarone = "Amarone"
        case arneis = "Arneis"
        case astiSpumante = "Asti Spumante"
        case auslese = "Auslese"
        case banylus = "Banylus"
        case barbaresco = "Barbaresco"
        case bardolino = "Bardolino"
        case barolo = "Barolo"
        case beaujolais = "Beaujolais"
        case blancDeBlancs = "Blanc de Blancs"
        case blancDeNoirs = "Blanc de Noirs"
        case blush = "Blush"
        case boal = "Boal"
        case bual = "Bual"
        case brunello = "Brunello"
        case cabernetFranc = "Cabernet Franc"
        case cabernetSauvignon = "Cabernet Sauvignon"
        case carignan = "Carignan"
        case carmenere = "Carmenere"
        case cava = "Cava"
        case charbono = "Charbono"
        case champagne = "Champagne"
        case chardonnay = "Chardonnay"
        case châteauneufDuPape = "Châteauneuf-du-Pape"
        case cheninBlanc = "CheninBlanc"
        case chianti = "Chianti"
        case chiantiClassico = "Chianti Classico"
        case claret = "Claret"
        case colombard = "Colombard"
        case constantia = "Constantia"
        case cortese = "Cortese"
        case dolcetto = "Dolcetto"
        case eiswein = "Eiswein"
        case frascati = "Frascati"
        case fuméBlanc = "Fumé Blanc"
        case gamay = "Gamay"
        case gamayBeaujolais = "Gamay Beaujolais"
        case gattinara = "Gattinara"
        case gewürztraminer = "Gewürztraminer"
        case grappa = "Grappa"
        case grenache = "Grenache"
        case johannisbergRiesling = "Johannisberg Riesling"
        case kir = "Kir"
        case lambrusco = "Lambrusco"
        case liebfraumilch = "Liebfraumilch"
        case madeira = "Madeira"
        case malbec = "Malbec"
        case marc = "Marc"
        case marsala = "Marsala"
        case marsanne = "Marsanne"
        case mead = "Mead"
        case meritage = "Meritage"
        case merlot = "Merlot"
        case montepulciano = "Montepulciano"
        case moscato = "Moscato"
        case mourvedre = "Mourvedre"
        case müllerThurgau = "Müller-Thurgau"
        case muscat = "Muscat"
        case nebbiolo = "Nebbiolo"
        case petitVerdot = "Petit Verdot"
        case petiteSirah = "Petite Sirah"
        case pinotBlanc = "Pinot Blanc"
        case pinotGrigio = "Pinot Grigio"
        case pinotGris = "Pinot Gris"
        case pinotMeunier = "Pinot Meunier"
        case pinotNoir = "Pinot Noir"
        case pinotage = "Pinotage"
        case port = "Port"
        case retsina = "Retsina"
        case rosé = "Rosé"
        case roussanne = "Roussanne"
        case sangiovese = "Sangiovese"
        case sauterns = "Sauterns"
        case sauvignonBlanc = "Sauvignon Blanc"
        case sémillon = "Sémillon"
        case sherry = "Sherry"
        case soave = "Soave"
        case syrah = "Syrah"
        case tokay = "Tokay"
        case traminer = "Traminer"
        case trebbiano = "Trebbiano"
        case ugniBlanc = "Ugni Blanc"
        case valpolicella = "Valpolicella"
        case verdicchio = "Verdicchio"
        case viognier = "Viognier"
        case zinfandel = "Zinfandel"
    }
    
    enum TastingNotesOrigin: Int16 {
        case userGenerated = 0
        case wineryGenerated = 1
    }
    
    enum WineBody: Int16 {
        case light = 0
        case medium = 1
        case full = 2
        case noResponse = 3
    }
    
    enum Sweetness: Int16 {
        case boneDry = 0
        case dry = 1
        case semiSweet = 2
        case sweet = 3
        case verySweet = 4
        case noResponse = 5
    }
    
    enum AlcoholLevel: Int16 {
        case extremelyLow = 0
        case low = 1
        case neutral = 2
        case high = 3
        case extremelyHigh = 4
        case noResponse = 5
    }
    
    enum AcidityLevel: Int16 {
        case extremelyLow = 0
        case low = 1
        case neutral = 2
        case high = 3
        case extremelyHigh = 4
        case noResponse = 5
    }
    
    enum TanninLevel: Int16 {
        case extremelyLow = 0
        case low = 1
        case neutral = 2
        case high = 3
        case extremelyHigh = 4
        case noResponse = 5
    }
    
    enum ViscosityLevel: Int16 {
        case low = 0
        case medium = 1
        case high = 2
        case noResponse = 3
    }
    
    enum ClarityLevel: Int16 {
        case hazy = 0
        case dull = 1
        case clear = 2
        case brilliant = 3
        case noResponse = 4
    }
}
