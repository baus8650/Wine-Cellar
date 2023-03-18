//
//  AddWineView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 11/7/22.
//

import SwiftUI

struct AddCompleteWineView: View {
    var dismissAction: (() -> Void)
    @ObservedObject var wineViewModel: WineViewModel
    @State var wine = NewWine()
    @State var vineyard = NewVineyard()
    @State var visualDetails = NewVisualDetails()
    @State var smellDetails = NewSmellDetails()
    @State var tasteDetails = NewTasteDetails()
    @State var personalDetails = NewPersonalDetails()
    @State var tastingNotes: [NewTastingNote] = []
    @State var foodPairings: [NewFoodPairing] = []
    
    init(viewModel: WineViewModel, dismissAction: @escaping (() -> Void)) {
        self.wineViewModel = viewModel
        self.dismissAction = dismissAction
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "WineColorAccent")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(named: "NavigationElements")!], for: .selected)
        UISlider.appearance().tintColor = UIColor(named: "SliderAccent")
        let thumbImage = UIImage(systemName: "circle.fill")!
        let resizedImage = thumbImage.resizeImageTo(size: CGSize(width: 14, height: 14))
        let newImage = resizedImage?.withTintColor(UIColor(named: "SliderAccent")!, renderingMode: .alwaysTemplate)
        UISlider.appearance().setThumbImage(newImage, for: .normal)
        UISlider.appearance().setThumbImage(newImage, for: .selected)
        UISlider.appearance().setThumbImage(newImage, for: .highlighted)
        UISlider.appearance().setThumbImage(newImage, for: .focused)
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    
                } header: {
                    HStack {
                        Spacer()
                        Text("Add New Wine")
                            .font(Font(UIFont(name: "Avenir Next Bold", size: 32)!))
                            .foregroundColor(Color("WineColorAccent"))
                        Spacer()
                    }
                }
                .textCase(nil)
                .padding(.bottom, -16)
                Section {
                    AddWineDetailsView(wine: $wine)
                } header: {
                    Text("Wine Details")
                        .font(Font(UIFont(name: "Avenir Next Bold", size: 24)!))
                        .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
                        .padding(.leading, -12)
                }
                .textCase(nil)
                Section {
                    AddVisualDetailsView(visualDetails: $visualDetails)
                } header: {
                    Text("Visual Details")
                        .font(Font(UIFont(name: "Avenir Next Bold", size: 24)!))
                        .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
                        .padding(.leading, -12)
                }
                .textCase(nil)
                Section {
                    AddScentDetailsView(smellDetails: $smellDetails)
                } header: {
                    Text("Scent Details")
                        .font(Font(UIFont(name: "Avenir Next Bold", size: 24)!))
                        .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
                        .padding(.leading, -12)
                }
                .textCase(nil)
                Section {
                    AddTasteDetailsView(tasteDetails: $tasteDetails)
                } header: {
                    Text("Taste Details")
                        .font(Font(UIFont(name: "Avenir Next Bold", size: 24)!))
                        .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
                        .padding(.leading, -12)
                }
                .textCase(nil)
                //            HStack {
                //                Spacer()
                //                Button {
                //                    saveWine()
                //                } label: {
                //                    Text("Save Wine")
                //                        .foregroundColor(Color("WineColorAccent"))
                //                }
                //                Spacer()
                //            }
                //            Spacer()
            }
            HStack {
                Spacer()
                Button {
                    saveWine()
                    dismissAction()
                } label: {
                    Text("Save Wine")
                        .fontWeight(.semibold)
                        .foregroundColor(Color("WineColorAccent"))
                }
                Spacer()
            }
            .padding([.leading, .trailing, .bottom], 8)
        }
    }
    
    private func saveWine() {
        let newWine = wineViewModel.addWine(abv: Float(wine.abv) ?? 0.0, ava: wine.ava, company: wine.company, isFavorited: wine.isFavorited, numberOwned: Int16(wine.numberOwn) ?? 0, type: wine.wineType.rawValue, varietal: wine.varietal, vintage: Int16(wine.vintage) ?? 0, wineColor: wine.wineColor.rawValue)
        
        wineViewModel.saveTasteDetails(
            body: Int16(tasteDetails.body),
            sweetness: Int16(tasteDetails.sweetness),
            alcohol: Int16(tasteDetails.alcohol),
            acidityLevel: Int16(tasteDetails.acidity),
            tanninLevel: Int16(tasteDetails.tannin),
            wine: newWine)
        
        wineViewModel.saveVisualDetails(
            clarity: visualDetails.clarity,
            color: visualDetails.color,
            viscosity: visualDetails.viscosity,
            wine: newWine)
        
        wineViewModel.saveSmellDetails(
            date: Date(),
            primaryAroma: smellDetails.primaryAroma,
            secondaryAroma: smellDetails.secondaryAroma,
            tertiaryAroma: smellDetails.tertiaryAroma,
            wine: newWine)
    }
    
    private func primaryDelete(_ index: Int) {
//        smellDetails.primaryAroma.remove(at: index)
    }
}

//struct AddCompleteWineView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCompleteWineView()
//    }
//}
