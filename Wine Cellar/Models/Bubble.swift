import Foundation

struct Bubble: Identifiable {
    let id = UUID()
    let bubbleScaleValue = CGFloat.random(in: 0.1...0.6)
    let bubbleFrameWidth = CGFloat.random(in: 1...100)
    let bubbleFrameHeight = CGFloat.random(in: 20...100)
    let bubbleXPosition = CGFloat.random(in: 0...1000)
    let bubbleYPosition = CGFloat.random(in: 0...200)
    }
