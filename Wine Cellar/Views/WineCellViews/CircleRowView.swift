//
//  CircleRowView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 10/27/22.
//

import SwiftUI

struct CircleRowView: View {
    let bodyValue: Int16
    let sweetnessValue: Int16
    let acidityValue: Int16
    let alcoholValue: Int16
    let tanninValue: Int16
    
    enum Category: String {
        case body = "Body"
        case sweetness = "Sweetness"
        case acidity = "Acidity"
        case alcohol = "Alcohol"
        case tannins = "Tannins"
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                VStack {
                    Divider()
                        .background(Color(uiColor: UIColor(named: "WineColorAccent")!))
                }
                Text("Taste Profile")
                    .font(Font(UIFont(name: "Avenir Next Demi Bold", size: 14)!))
                    .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
                
                VStack {
                    Divider()
                        .background(Color(uiColor: UIColor(named: "WineColorAccent")!))
                }
            }
            HStack(spacing: 18) {
                CircleProgressView(total: 3, value: bodyValue, valueString: generateValueString(from: bodyValue, in: .body), circleDescriptor: Category.body.rawValue, color: UIColor(named: "WineColorAccent")!)
                CircleProgressView(total: 5, value: sweetnessValue, valueString: generateValueString(from: sweetnessValue, in: .sweetness), circleDescriptor: Category.sweetness.rawValue, color: UIColor(named: "WineColorAccent")!)
                CircleProgressView(total: 5, value: acidityValue, valueString: generateValueString(from: acidityValue, in: .acidity), circleDescriptor: Category.acidity.rawValue, color: UIColor(named: "WineColorAccent")!)
                CircleProgressView(total: 5, value: alcoholValue, valueString: generateValueString(from: alcoholValue, in: .alcohol), circleDescriptor: Category.alcohol.rawValue, color: UIColor(named: "WineColorAccent")!)
                CircleProgressView(total: 5, value: tanninValue, valueString: generateValueString(from: tanninValue, in: .tannins), circleDescriptor: Category.tannins.rawValue, color: UIColor(named: "WineColorAccent")!)
            }
        }
    }
    
    func generateValueString(from value: Int16, in category: Category) -> String {
        switch category {
        case .body:
            switch value {
            case 1:
                return "Light"
            case 2:
                return "Med."
            case 3:
                return "Full"
            default:
                return "--"
            }
        case .sweetness:
            switch value {
            case 1:
                return "Bone Dry"
            case 2:
                return "Dry"
            case 3:
                return "Semi-Sweet"
            case 4:
                return "Sweet"
            case 5:
                return "Very Sweet"
            default:
                return "--"
            }
        case .acidity, .alcohol, .tannins:
            switch value {
            case 1:
                return "Very Low"
            case 2:
                return "Low"
            case 3:
                return "Neutral"
            case 4:
                return "High"
            case 5:
                return "Very High"
            default:
                return "--"
            }
        }
    }
}

struct CircleRowView_Previews: PreviewProvider {
    static var previews: some View {
        CircleRowView(bodyValue: 2, sweetnessValue: 2, acidityValue: 3, alcoholValue: 4, tanninValue: 3)
    }
}
