//
//  BubblesView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 10/27/22.
//

import SwiftUI

struct BubblesView: View {
    @State var scale : CGFloat = 1
    var scaleMultiplier: CGFloat
    var width: CGFloat
    var height: CGFloat
    var xPosition: CGFloat
    var yPosition: CGFloat
    var body: some View {
        Circle()
            .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!).opacity(0.11))
            .scaleEffect(self.scale * scaleMultiplier)
            .frame(width: width,
                   height: height,
                   alignment: .center)
            .position(CGPoint(x: xPosition,
                              y: yPosition))
    }
}
