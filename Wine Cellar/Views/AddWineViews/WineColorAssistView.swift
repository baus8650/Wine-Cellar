//
//  WineColorAssistView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 11/9/22.
//

import SwiftUI

struct WineColorAssistView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var visualDetails: NewVisualDetails
    @State var red: CGFloat = 0.0
    @State var green: CGFloat = 0.0
    @State var blue: CGFloat = 0.0
    @State private var color =
    Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Rectangle()
                    .frame(width: 200, height: 48)
                    .foregroundColor(Color(.sRGB, red: red, green: green, blue: blue))
                    .border(Color(.black).opacity(0.30), width: 1)
                ZStack {
                    VStack {
                        Divider()
                            .padding(.bottom, 4)
                        VStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Red")
                                    .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
                                UISliderView(value: $red, minValue: 0.0, maxValue: 1.0, thumbColor: .white, minTrackColor: .clear, maxTrackColor: .clear)
                                    .frame(height: 8)
                                    .background(LinearGradient(
                                        gradient: Gradient(
                                            colors: [
                                                Color(.sRGB, red: 0, green: green, blue: blue),
                                                Color(.sRGB, red: 1, green: green, blue: blue)
                                            ]),
                                        startPoint: .leading,
                                        endPoint: .trailing))
                                    .tint(Color(.clear))
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Green")
                                    .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
                                UISliderView(value: $green, minValue: 0.0, maxValue: 1.0, thumbColor: .white, minTrackColor: .clear, maxTrackColor: .clear)
                                    .frame(height: 8)
                                    .background(LinearGradient(
                                        gradient: Gradient(
                                            colors: [
                                                Color(.sRGB, red: red, green: 0, blue: blue),
                                                Color(.sRGB, red: red, green: 1, blue: blue)
                                            ]),
                                        startPoint: .leading,
                                        endPoint: .trailing))
                                    .tint(Color(.clear))
                                    
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Blue")
                                    .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
                                UISliderView(value: $blue, minValue: 0.0, maxValue: 1.0, thumbColor: .white, minTrackColor: .clear, maxTrackColor: .clear)
                                    .frame(height: 8)
                                    .background(LinearGradient(
                                        gradient: Gradient(
                                            colors: [
                                                Color(.sRGB, red: red, green: green, blue: 0),
                                                Color(.sRGB, red: red, green: green, blue: 1)
                                            ]),
                                        startPoint: .leading,
                                        endPoint: .trailing))
                                    .tint(Color(.clear))
                            }
                        }
                        .padding([.leading, .trailing], 64)
                        .padding(.bottom, 8)
                        VStack {
                            Text("Quick Set Options")
                                .font(Font(UIFont(name: "Avenir Next Medium", size: 14)!))
                                .foregroundColor(Color(uiColor: UIColor(named: "WineColorAccent")!))
                                .padding(.bottom, 4)
                            HStack(spacing: 64) {
                                Button {
                                    red = 0.5686
                                    green = 0.1098
                                    blue = 0.047
                                } label: {
                                    Text("Red")
                                        .foregroundColor(Color("HeaderRed"))
                                }
                                Button {
                                    red = 0.9529
                                    green = 0.6823
                                    blue = 0.6745
                                } label: {
                                    Text("Rosé")
                                        .foregroundColor(Color("HeaderRosé"))
                                }
                                Button {
                                    red = 0.9921
                                    green = 0.9529
                                    blue = 0.8705
                                } label: {
                                    Text("White")
                                        .foregroundColor(Color("HeaderWhite"))
                                }
                            }
                            .padding(.bottom, 12)
                        }
                        Button {
                            let newColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0).toHex!
                            visualDetails.color = newColor
                            dismiss()
                        } label: {
                            Text("Set Color")
                                .foregroundColor(Color("WineColorAccent"))
                        }
                        .padding(.bottom, 4)
                    }
                }
                .background(Color(.systemBackground))
            }
        }
        .background(Color(.white))
    }
}

