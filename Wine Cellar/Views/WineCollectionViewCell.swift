////
////  WineCollectionViewCell.swift
////  Wine Cellar
////
////  Created by Tim Bausch on 10/26/22.
////
//import PureLayout
//import SwiftUI
//import UIKit
//
//class WineCollectionViewCell: UICollectionViewCell {
////    lazy var company: UILabel = {
////        let label = UILabel(forAutoLayout: ())
////        label.font = UIFont(name: "Avenir Next Bold", size: 20)
////        label.textColor = UIColor(named: "WineColorAccent")
////        return label
////    }()
////
////    lazy var abv: UILabel = {
////        let label = UILabel(forAutoLayout: ())
////        label.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
////        label.textColor = UIColor(named: "WineColorAccent")
////        return label
////    }()
////
////    lazy var ava: UILabel = {
////        let label = UILabel(forAutoLayout: ())
////        label.font = UIFont(name: "Avenir Next ultra light", size: 14)
////        label.textColor = UIColor(named: "WineColorAccent")
////        return label
////    }()
////
////    lazy var varietal: UILabel = {
////        let label = UILabel(forAutoLayout: ())
////        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
////        label.font = UIFont(name: "Avenir Next Demi Bold", size: 16)
////        label.textColor = UIColor(named: "WineColorAccent")
////        return label
////    }()
////
////    lazy var vintage: UILabel = {
////        let label = UILabel(forAutoLayout: ())
////        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
////        label.font = UIFont(name: "Avenir Next", size: 14)
////        label.textColor = UIColor(named: "WineColorAccent")
////        return label
////    }()
////
////    lazy var vineyard: UILabel = {
////        let label = UILabel(forAutoLayout: ())
////        label.textColor = UIColor(named: "WineColorAccent")
////        return label
////    }()
////
////    lazy var numberOwned: UILabel = {
////        let label = UILabel(forAutoLayout: ())
////        label.textColor = UIColor(named: "WineColorAccent")
////        return label
////    }()
////
////    lazy var sparkleImage: UIImageView = {
////        let imageView = UIImageView(forAutoLayout: ())
////        imageView.image = UIImage(systemName: "sparkles")
////        return imageView
////    }()
////
////    lazy var favoriteImage: UIImageView = {
////        let imageView = UIImageView(forAutoLayout: ())
////        imageView.image = UIImage(systemName: "star.fill")
////        return imageView
////    }()
////
////    private lazy var wineSpecsStack: UIStackView = {
////        let stackView = UIStackView(forAutoLayout: ())
////        stackView.axis = .horizontal
////        stackView.spacing = 4
////        let views = [vintage, abv]
////        let _ = views.map {
////            stackView.addArrangedSubview($0)
////        }
////        return stackView
////    }()
////
////    private lazy var mainStack: UIStackView = {
////        let stackView = UIStackView(forAutoLayout: ())
////        stackView.axis = .vertical
////        stackView.spacing = 4
////        let views = [company, varietal, wineSpecsStack, vineyard, ava]
////        let _ = views.map {
////            stackView.addArrangedSubview($0)
////        }
////        return stackView
////    }()
//    var wine: Wine!
////    private lazy var cellView = UIHostingController(rootView: WineCellView(wine: wine))
//    private(set) var cellView: UIHostingController<WineCellView>?
//    
//    var background = UIColor(named: "WineColor")
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        layer.cornerRadius = 8
//        let cellView = UIHostingController(rootView: WineCellView(wine: wine))
//        setUpSubviews()
//    }
//    
//    private func setUpSubviews() {
////        addSubview(mainStack)
////        mainStack.autoPinEdgesToSuperviewMargins()
//        addSubview(cellView!)
//        cellView.autoPinEdgesToSuperviewMargins()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setBackgroundColor(with wineColor: String) -> UIColor {
//        switch wineColor {
//        case Constants.WineColor.red.rawValue:
//            return UIColor(named: "CellRed")!
//        case Constants.WineColor.white.rawValue:
//            return UIColor(named: "CellWhite")!
//        case Constants.WineColor.rose.rawValue:
//            return UIColor(named: "CellRosé")!
//        default:
//            return UIColor(named: "WineColorAccent")!
//        }
//    }
//}
