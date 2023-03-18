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
    
    enum WineType: String, CaseIterable {
        case still = "Still"
        case sparkling = "Sparkling"
    }
    
    enum WineColor: String, CaseIterable {
        case red = "Red"
        case rose = "Rosé"
        case white = "White"
    }
    
    enum Varietal: String, CaseIterable {
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
    
    enum TastingNotesOrigin: Int16, CaseIterable {
        case userGenerated = 0
        case wineryGenerated = 1
    }
    
    enum WineBody: Int16, CaseIterable {
        case noResponse = 0
        case light = 1
        case medium = 2
        case full = 3
        
        var description: String {
            switch self {
            case .noResponse:
                return "No Response"
            case .light:
                return "Light"
            case .medium:
                return "Medium"
            case .full:
                return "Full"
            }
        }
    }
    
    enum Sweetness: Int16, CaseIterable {
        case noResponse = 0
        case boneDry = 1
        case dry = 2
        case semiSweet = 3
        case sweet = 4
        case verySweet = 5
        
        var description: String {
            switch self {
            case .noResponse:
                return "No Response"
            case .boneDry:
                return "Bone Dry"
            case .dry:
                return "Dry"
            case .semiSweet:
                return "Semi-Sweet"
            case .sweet:
                return "Sweet"
            case .verySweet:
                return "Very Sweet"
            }
        }
    }
    
    enum AlcoholLevel: Int16, CaseIterable {
        case noResponse = 0
        case extremelyLow = 1
        case low = 2
        case neutral = 3
        case high = 4
        case extremelyHigh = 5
        
        var description: String {
            switch self {
            case .noResponse:
                return "No Response"
            case .extremelyLow:
                return "Very Low"
            case .low:
                return "Low"
            case .neutral:
                return "Medium"
            case .high:
                return "High"
            case .extremelyHigh:
                return "Very High"
            }
        }
    }
    
    enum AcidityLevel: Int16, CaseIterable {
        case noResponse = 0
        case extremelyLow = 1
        case low = 2
        case neutral = 3
        case high = 4
        case extremelyHigh = 5
        
        var description: String {
            switch self {
            case .noResponse:
                return "No Response"
            case .extremelyLow:
                return "Very Low"
            case .low:
                return "Low"
            case .neutral:
                return "Medium"
            case .high:
                return "High"
            case .extremelyHigh:
                return "Very High"
            }
        }
    }
    
    enum TanninLevel: Int16, CaseIterable {
        case noResponse = 0
        case extremelyLow = 1
        case low = 2
        case neutral = 3
        case high = 4
        case extremelyHigh = 5
        
        var description: String {
            switch self {
            case .noResponse:
                return "No Response"
            case .extremelyLow:
                return "Very Low"
            case .low:
                return "Low"
            case .neutral:
                return "Medium"
            case .high:
                return "High"
            case .extremelyHigh:
                return "Very High"
            }
        }
    }
    
    enum ViscosityLevel: Int16, CaseIterable {
        case noResponse = 0
        case low = 1
        case medium = 2
        case high = 3
        
        var description: String {
            switch self {
            case .noResponse:
                return "No Response"
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high:
                return "High"
            }
        }
    }
    
    enum ClarityLevel: Int16, CaseIterable {
        case noResponse = 0
        case hazy = 1
        case dull = 2
        case clear = 3
        case brilliant = 4
        
        var description: String {
            switch self {
            case .noResponse:
                return "No Response"
            case .hazy:
                return "Hazy"
            case .dull:
                return "Dull"
            case .clear:
                return "Clear"
            case .brilliant:
                return "Brilliant"
            }
        }
    }
    
    enum SortingOptions: String {
        case abvAscending = "ABV Ascending"
        case abvDescending = "ABV Descending"
        case dateAscending = "Add Date Ascending"
        case dateDescending = "Add Date Descending"
        case companyAscending = "Company Ascending"
        case companyDescending = "Company Descending"
        case varietalAscending = "Varietal Ascending"
        case varietalDescending = "Varietal Descending"
        case vintageAscending = "Vintage Ascending"
        case vintageDescending = "Vintage Descending"

    }
    
    enum FilterOptions: String {
        case allWines = "All Wines"
        case stillOnly = "Still Wines Only"
        case sparklingOnly = "Sparkling Wines Only"
    }
}
