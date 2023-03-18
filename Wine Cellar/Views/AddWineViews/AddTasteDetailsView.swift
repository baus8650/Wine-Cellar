//
//  AddTasteDetailsView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 11/7/22.
//

import SwiftUI

struct AddTasteDetailsView: View {
    @Binding var tasteDetails: NewTasteDetails
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Body")
                .font(Font(UIFont(name: "Avenir Next Bold", size: 20)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Text(String(Constants.WineBody(rawValue: $tasteDetails.body.wrappedValue)!.description))
                .font(Font(UIFont(name: "Avenir Next Medium", size: 16)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Slider(value: IntDoubleBinding($tasteDetails.body).doubleValue, in: 0...Double(Constants.WineBody.allCases.last!.rawValue), step: 1)
        }
        VStack(alignment: .leading) {
            Text("Sweetness")
                .font(Font(UIFont(name: "Avenir Next Bold", size: 20)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Text(String(Constants.Sweetness(rawValue: $tasteDetails.sweetness.wrappedValue)!.description))
                .font(Font(UIFont(name: "Avenir Next Medium", size: 16)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Slider(value: IntDoubleBinding($tasteDetails.sweetness).doubleValue, in: 0...Double(Constants.Sweetness.allCases.last!.rawValue), step: 1)
        }
        VStack(alignment: .leading) {
            Text("Alcohol")
                .font(Font(UIFont(name: "Avenir Next Bold", size: 20)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Text(String(Constants.AlcoholLevel(rawValue: $tasteDetails.alcohol.wrappedValue)!.description))
                .font(Font(UIFont(name: "Avenir Next Medium", size: 16)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Slider(value: IntDoubleBinding($tasteDetails.alcohol).doubleValue, in: 0...Double(Constants.AlcoholLevel.allCases.last!.rawValue), step: 1)
        }
        VStack(alignment: .leading) {
            Text("Acidity")
                .font(Font(UIFont(name: "Avenir Next Bold", size: 20)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Text(String(Constants.AcidityLevel(rawValue: $tasteDetails.acidity.wrappedValue)!.description))
                .font(Font(UIFont(name: "Avenir Next Medium", size: 16)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Slider(value: IntDoubleBinding($tasteDetails.acidity).doubleValue, in: 0...Double(Constants.AcidityLevel.allCases.last!.rawValue), step: 1)
        }
        VStack(alignment: .leading) {
            Text("Tannins")
                .font(Font(UIFont(name: "Avenir Next Bold", size: 20)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Text(String(Constants.TanninLevel(rawValue: $tasteDetails.tannin.wrappedValue)!.description))
                .font(Font(UIFont(name: "Avenir Next Medium", size: 16)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Slider(value: IntDoubleBinding($tasteDetails.tannin).doubleValue, in: 0...Double(Constants.TanninLevel.allCases.last!.rawValue), step: 1)
        }
    }
}

struct IntDoubleBinding {
    let intValue : Binding<Int16>
    
    let doubleValue : Binding<Double>
    
    init(_ intValue : Binding<Int16>) {
        self.intValue = intValue
        
        self.doubleValue = Binding<Double>(get: {
            return Double(intValue.wrappedValue)
        }, set: {
            intValue.wrappedValue = Int16($0)
        })
    }
}
//
//struct AddTasteDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTasteDetailsView()
//    }
//}
