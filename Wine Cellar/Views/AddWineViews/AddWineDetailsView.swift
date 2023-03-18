//
//  AddWineDetailsView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 11/7/22.
//

import SwiftUI

struct AddWineDetailsView: View {
    @Binding var wine: NewWine
    @State var presentList = false
    @State var selectionMade = false
    var isFavorited = false
    var allVarietals = Constants.Varietal.allCases.map { $0.rawValue }
    @State var filteredVarietals: [String] = []
    @State var selectedVarietal: String = ""
    
    var body: some View {
        TextField("Producer", text: $wine.company)
            .textInputAutocapitalization(.words)
        VStack(alignment: .leading) {
            TextField("Varietal", text: $wine.varietal)
                .onChange(of: wine.varietal) { newValue in
                    filterVarietal(with: newValue)

                    if selectedVarietal == newValue {
                        filteredVarietals = []
                        presentList = false
                    }
                }
                .onSubmit {
                    presentList = false
                    filteredVarietals = []
                    UIApplication.shared.inputView?.endEditing(true)
                }
            if presentList {
                List {
                    ForEach(filteredVarietals.indices, id: \.self) { index in
                        Text(filteredVarietals[index])
                            .onTapGesture {
                                selectedVarietal = filteredVarietals[index]
                                completeVarietal(with: filteredVarietals[index])
                            }
                            .foregroundColor(Color("WineColorAccent"))
                    }
                }
                .listStyle(.inset)
                .frame(height: 152)
                .cornerRadius(8)
            }
        }
        
        TextField("AVA", text: $wine.ava)
            .textInputAutocapitalization(.words)
        HStack(alignment: .center) {
            TextField("Vintage", text: $wine.vintage)
                .keyboardType(.numberPad)
            TextField("ABV", text: $wine.abv)
                .keyboardType(.decimalPad)
            TextField("Inventory", text: $wine.numberOwn)
                .keyboardType(.numberPad)
        }
        Picker("Wine Type", selection: $wine.wineType) {
            ForEach(Constants.WineType.allCases, id: \.self) {type in
                Text(type.rawValue)
            }
        }
        .pickerStyle(.segmented)
        Picker("Wine Color", selection: $wine.wineColor) {
            ForEach(Constants.WineColor.allCases, id: \.self) {type in
                Text(type.rawValue)
            }
        }
        .pickerStyle(.segmented)
        HStack() {
            Spacer()
            Toggle("", isOn: $wine.isFavorited)
                .toggleStyle(CheckboxToggleStyle())
            Spacer()
        }
    }
    
    private func filterVarietal(with string: String) {
        filteredVarietals = allVarietals.filter {
            $0.lowercased().contains(string.lowercased())
        }
        if !filteredVarietals.isEmpty {
            presentList = true
        } else {
            presentList = false
        }
    }
    
    private func completeVarietal(with string: String) {
        wine.varietal = string.capitalized
        presentList = false
        filteredVarietals = []
    }
}

//public protocol ToggleStyle {
//    associatedtype Body : View
//
//    func makeBody(configuration: Self.Configuration) -> Self.Body
//
//    typealias Configuration = ToggleStyleConfiguration
//}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Image(systemName: configuration.isOn ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
//struct AddWineDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddWineDetailsView()
//    }
//}
