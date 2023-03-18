//
//  CustomSlider.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 11/10/22.
//

import SwiftUI

struct UISliderView: UIViewRepresentable {
    @Binding var value: CGFloat
    
    var minValue = 1.0
    var maxValue = 100.0
    var thumbColor: UIColor = .white
    var minTrackColor: UIColor = .blue
    var maxTrackColor: UIColor = .lightGray
    var thumbImage = UIImage(systemName: "square.fill")?.resizeImageTo(size: CGSize(width: 6, height: 24))?.withTintColor(UIColor(named: "WineColorAccent")!)
    
    class Coordinator: NSObject {
        var value: Binding<CGFloat>
        
        init(value: Binding<CGFloat>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = CGFloat(sender.value)
        }
    }
    
    func makeCoordinator() -> UISliderView.Coordinator {
        Coordinator(value: $value)
    }
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = thumbColor
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.value = Float(value)
        slider.setThumbImage(thumbImage, for: .normal)
        slider.setThumbImage(thumbImage, for: .selected)
        slider.setThumbImage(thumbImage, for: .focused)
        slider.setThumbImage(thumbImage, for: .highlighted)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }
}

//
//struct CustomSlider_Previews: PreviewProvider {
//    static var previews: some View {
//        UISliderView(value: <#Binding<CGFloat>#>)
//    }
//}
