//
//  WineDetailViewController.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 11/3/22.
//

import UIKit

class WineDetailViewController: UIViewController {
    
    var isEditingWine: Bool
    
    init(isEditingWine: Bool = false) {
        self.isEditingWine = isEditingWine
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        let barAppearance = UINavigationBarAppearance()
//        barAppearance.backgroundColor = UIColor(named: "NavigationElements")
//        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "WineColorAccent")!]
//        navigationItem.standardAppearance = barAppearance
//        navigationItem.scrollEdgeAppearance = barAppearance
//        navigationController?.navigationBar.tintColor = UIColor(named: "WineColorAccent")
        // Do any additional setup after loading the view.
    }

}
