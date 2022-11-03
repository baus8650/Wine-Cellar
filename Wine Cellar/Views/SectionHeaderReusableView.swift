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
    
    private lazy var labelContainer: UIView = {
        let view = UIView(forAutoLayout: ())
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        view.backgroundColor = .systemBackground.withAlphaComponent(0.7)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        label.font = UIFont(name: "Avenir Next Bold", size: 24)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        addSubview(labelContainer)
        labelContainer.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        labelContainer.autoSetDimension(.height, toSize: 36)
        labelContainer.addSubview(titleLabel)
        titleLabel.autoPinEdgesToSuperviewMargins()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
