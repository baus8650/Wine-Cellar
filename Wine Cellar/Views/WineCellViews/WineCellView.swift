//
//  WineCellView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 10/27/22.
//

import SwiftUI

struct WineCellView: View {
    let wine: Wine
    let color: String
    
    var body: some View {
        ZStack {
            VStack(spacing: -12) {
                WineContentView(company: wine.company!, vintage: wine.vintage, varietal: wine.varietal!, vineyard: (wine.vineyard?.name), color: UIColor(named: "WineColorAccent")!, isFavorited: wine.isFavorited)
                    .padding(.top, 8)
                CircleRowView(
                    bodyValue: wine.tasteDetails?.body ?? 0,
                    sweetnessValue: wine.tasteDetails?.sweetness ?? 0,
                    acidityValue: wine.tasteDetails?.acidity ?? 0,
                    alcoholValue: wine.tasteDetails?.alcohol ?? 0,
                    tanninValue: wine.tasteDetails?.tannin ?? 0)
                .padding(.bottom, 8)
            }
            if wine.type == Constants.WineType.sparkling.rawValue {
                BubblesView()
            }
        }
        .background(Color(uiColor: setBackgroundColor(with: color)))
    }
    
    func setBackgroundColor(with wineColor: String) -> UIColor {
        switch wineColor {
        case Constants.WineColor.red.rawValue:
            return UIColor(named: "CellRed")!
        case Constants.WineColor.white.rawValue:
            return UIColor(named: "CellWhite")!
        case Constants.WineColor.rose.rawValue:
            return UIColor(named: "CellRosé")!
        default:
            return UIColor(named: "WineColorAccent")!
        }
    }
}
