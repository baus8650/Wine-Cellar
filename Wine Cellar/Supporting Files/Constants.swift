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
    
    enum WineType {
        case still
        case sparkling
    }
    
    enum WineColor {
        case white
        case rose
        case red
    }
    
    enum Varietal {
        case albariño
        case aligoté
        case amarone
        case arneis
        case astiSpumante
        case auslese
        case banylus
        case barbaresco
        case bardolino
        case barolo
        case beaujolais
        case blancDeBlancs
        case blancDeNoirs
        case blush
        case boal
        case bual
        case brunello
        case cabernetFranc
        case cabernetSauvignon
        case carignan
        case carmenere
        case cava
        case charbono
        case champagne
        case chardonnay
        case châteauneufDuPape
        case cheninBlanc
        case chianti
        case chiantiClassico
        case claret
        case colombard
        case constantia
        case cortese
        case dolcetto
        case eiswein
        case frascati
        case fuméBlanc
        case gamay
        case gamayBeaujolais
        case gattinara
        case gewürztraminer
        case grappa
        case grenache
        case johannisbergRiesling
        case kir
        case lambrusco
        case liebfraumilch
        case madeira
        case malbec
        case marc
        case marsala
        case marsanne
        case mead
        case meritage
        case merlot
        case montepulciano
        case moscato
        case mourvedre
        case müllerThurgau
        case muscat
        case nebbiolo
        case petitVerdot
        case petiteSirah
        case pinotBlanc
        case pinotGrigio
        case pinotGris
        case pinoMeunier
        case pinoNoir
        case pinotage
        case port
        case retsina
        case rosé
        case roussanne
        case sangiovese
        case sauterns
        case sauvignonBlanc
        case sémillon
        case sherry
        case soave
        case tokay
        case traminer
        case trebbiano
        case ugniBlanc
        case valpolicella
        case verdicchio
        case viognier
        case zinfandel
    }
    
    enum TastingNotesOrigin {
        case userGenerated
        case wineryGenerated
    }
    
    enum WineBody {
        case light
        case medium
        case full
    }
    
    enum Sweetness {
        case boneDry
        case dry
        case semiSweet
        case sweet
        case verySweet
    }
    
    enum AlcoholLevel {
        case extremelyLow
        case low
        case neutral
        case high
        case extremelyHigh
    }
    
    enum AcidityLevel {
        case extremelyLow
        case low
        case neutral
        case high
        case extremelyHigh
    }
    
    enum TanninLevel {
        case extremelyLow
        case low
        case neutral
        case high
        case extremelyHigh
    }
    
    enum ViscosityLevel {
        case low
        case medium
        case high
    }
    
    enum ClarityLevel {
        case brilliant
        case clear
        case dull
        case hazy
    }
}
