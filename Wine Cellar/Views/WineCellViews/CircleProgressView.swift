//
//  CircleProgressView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 10/27/22.
//

import SwiftUI

struct CircleProgressView: View {
    let total: Int16?
    let value: Int16?
    let valueString: String
    let circleDescriptor: String
    let color: UIColor
    
    init(total: Int16, value: Int16, valueString: String, circleDescriptor: String, color: UIColor) {
        self.total = total
        self.value = value
        self.valueString = valueString
        self.circleDescriptor = circleDescriptor
        self.color = color
    }
    
    var body: some View {
        VStack(spacing: -2) {
            ZStack {
                Circle()
                    .trim(from: 0, to: 0.75)
                    .rotation(.degrees(135))
                    .stroke(Color(uiColor: UIColor(named: "WineColorAccent")!).opacity(0.2), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .frame(width: 52, height: 52)
                Circle()
                    .trim(from: 0, to: calculateProgress(value ?? 0, outOf: total ?? 0))
                    .rotation(.degrees(135))
                    .stroke(Color(uiColor: color), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .frame(width: 52, height: 52)
                Text(valueString)
                    .font(Font(UIFont(name: "Avenir Next", size: 12)!))
                    .foregroundColor(Color(uiColor: color))
                    .frame(width: 40)
                    .multilineTextAlignment(.center)
            }
            Text(circleDescriptor)
                .font(Font(UIFont(name: "Avenir Next Medium", size: 12)!))
                .foregroundColor(Color(uiColor: color))
                
        }
    }
    
    func calculateProgress(_ value: Int16, outOf total: Int16) -> CGFloat {
        let percentage = CGFloat(value)/CGFloat(total)
        return percentage*0.75
    }
}

struct CircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressView(total: 5, value: 2, valueString: "Bone Dry", circleDescriptor: "Sweetness", color: UIColor(named: "WineColorAccent")!)
    }
}
