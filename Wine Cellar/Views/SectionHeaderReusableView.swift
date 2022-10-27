//
//  SectionHeaderReusableView.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 10/26/22.
//

import Foundation
import PureLayout
import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: SectionHeaderReusableView.self)
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        label.font = UIFont(name: "Avenir Next Bold", size: 24)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8)
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        addSubview(titleLabel)
        titleLabel.autoPinEdgesToSuperviewMargins()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
