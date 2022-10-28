//
//  BubblesView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 10/27/22.
//

import SwiftUI

struct BubblesView: View {
    @State var scale : CGFloat = 1
    var body: some View {
        ForEach (1...150, id:\.self) { _ in
            Circle()
                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!).opacity(0.11))
                .scaleEffect(self.scale * .random(in: 0.1...0.6))
                .frame(width: .random(in: 1...100),
                       height: CGFloat.random (in:20...100),
                       alignment: .center)
                .position(CGPoint(x: .random(in: 0...1000),
                                  y: .random (in:0...200)))
        }
    }
}


struct BubblesView_Previews: PreviewProvider {
    static var previews: some View {
        BubblesView()
    }
}
