//
//  AddScentDetailsView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 11/28/22.
//

import SwiftUI

struct AddScentDetailsView: View {
    @State var newWord: String = ""
    @State var secondaryWord: String = ""
    @State var tertiaryWord: String = ""
    @Binding var smellDetails: NewSmellDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Primary scents")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("WineColorAccent"))
                TextField("Add new Primary Scent", text: $newWord)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit(addNewWord)
                List {
                    ForEach($smellDetails.primaryAroma.indices, id: \.self) { index in
                        TextField("", text: $smellDetails.primaryAroma[index])
                            .foregroundColor(Color("WineColorAccent"))
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            $smellDetails.primaryAroma.wrappedValue.remove(atOffsets: indexSet)
                        }
                    }
                }
                .listStyle(.plain)
                .frame(height: (43 * CGFloat(smellDetails.primaryAroma.count)))
                .cornerRadius(8)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Secondary scents")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("WineColorAccent"))
                TextField("Add new Secondary Scent", text: $secondaryWord)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit(addSecondaryWord)
                List {
                    ForEach($smellDetails.secondaryAroma, id: \.self) { scent in
                        TextField("", text: scent)
                            .foregroundColor(Color("WineColorAccent"))
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            $smellDetails.secondaryAroma.wrappedValue.remove(atOffsets: indexSet)
                        }
                    }
                }
                .listStyle(.plain)
                .frame(height: (43 * CGFloat(smellDetails.secondaryAroma.count)))
                .cornerRadius(8)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Tertiary scents")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("WineColorAccent"))
                TextField("Add new Tertiary Scent", text: $tertiaryWord)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit(addTertiaryWord)
                List {
                    ForEach($smellDetails.tertiaryAroma, id: \.self) { scent in
                        TextField("", text: scent)
                            .foregroundColor(Color("WineColorAccent"))
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            $smellDetails.tertiaryAroma.wrappedValue.remove(atOffsets: indexSet)
                        }
                    }
                }
                .listStyle(.plain)
                .frame(height: (43 * CGFloat(smellDetails.tertiaryAroma.count)))
                .cornerRadius(8)
            }
        }
    }
    
    func addNewWord() {
        withAnimation {
//            $smellDetails.primaryAroma.wrappedValue.append(newWord)
            smellDetails.primaryAroma.append(newWord)
        }
        newWord = ""
    }
    
    func addSecondaryWord() {
        withAnimation {
            smellDetails.secondaryAroma.append(secondaryWord)
        }
        secondaryWord = ""
    }
    
    func addTertiaryWord() {
        withAnimation {
            smellDetails.tertiaryAroma.append(tertiaryWord)
        }
        tertiaryWord = ""
    }
    
    func delete(_ indexSet: IndexSet) {
        $smellDetails.primaryAroma.wrappedValue.remove(atOffsets: indexSet)
    }
}

//struct AddScentDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddScentDetailsView()
//    }
//}
