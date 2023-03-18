//
//  AddVisualDetailsView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 11/9/22.
//

import SwiftUI

struct AddVisualDetailsView: View {
    @Binding var visualDetails: NewVisualDetails
    @State private var showingColorAssistant = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Clarity")
                .font(Font(UIFont(name: "Avenir Next Bold", size: 20)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Text(String(Constants.ClarityLevel(rawValue: $visualDetails.clarity.wrappedValue)!.description))
                .font(Font(UIFont(name: "Avenir Next Medium", size: 16)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Slider(value: IntDoubleBinding($visualDetails.clarity).doubleValue, in:
                    0...Double(Constants.ClarityLevel.allCases.last!.rawValue), step: 1)
        }
        VStack(alignment: .leading) {
            Text("Viscosity")
                .font(Font(UIFont(name: "Avenir Next Bold", size: 20)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Text(String(Constants.ViscosityLevel(rawValue: $visualDetails.viscosity.wrappedValue)!.description))
                .font(Font(UIFont(name: "Avenir Next Medium", size: 16)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            Slider(value: IntDoubleBinding($visualDetails.viscosity).doubleValue, in:
                    0...Double(Constants.ViscosityLevel.allCases.last!.rawValue), step: 1)
        }
        VStack(alignment: .leading) {
            Text("Color")
                .font(Font(UIFont(name: "Avenir Next Bold", size: 20)!))
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
            HStack {
                TextField("Color (hex value)", text: $visualDetails.color)
                Button {
                    showingColorAssistant.toggle()
                } label: {
                    Image(systemName: "eyedropper.halffull")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("WineColorAccent"))
                }
                .sheet(isPresented: $showingColorAssistant) {
                    WineColorAssistView(visualDetails: $visualDetails)
                }
            }
        }
    }
}

//struct AddVisualDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddVisualDetailsView()
//    }
//}
