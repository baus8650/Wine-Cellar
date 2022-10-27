//
//  WineContentView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 10/27/22.
//

import SwiftUI

struct WineContentView: View {
    let company: String
    let vintage: Int16
    let varietal: String
    let vineyard: String?
    let color: UIColor
    @State var isFavorited: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(company)
                    .font(Font(UIFont(name: "Avenir Next Bold", size: 16)!))
                    .foregroundColor(Color(uiColor: color))
                Spacer()
                Button {
                    isFavorited.toggle()
                } label: {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color(uiColor: color))
                        .frame(width: 30, height: 30)
                        .padding([.top, .trailing], -10)
                }
            }
            Text("\(String(vintage)) \(varietal)")
                .font(Font(UIFont(name: "Avenir Next Medium", size: 14)!))
                .foregroundColor(Color(uiColor: color))
            if vineyard != nil {
                Text(vineyard ?? "No vineyard added yet!")
                    .font(Font(UIFont(name: "Avenir Next", size: 14)!))
                    .foregroundColor(Color(uiColor: color))
            }
        }
        .padding([.leading, .trailing, .bottom])
    }
}

struct WineContentView_Previews: PreviewProvider {
    static var previews: some View {
        WineContentView(company: "Flying Goat Cellars", vintage: 2016, varietal: "Pinot Noir", vineyard: "Rio Vista Vineyard", color: UIColor(named: "WineColorAccent")!, isFavorited: true)
    }
}
