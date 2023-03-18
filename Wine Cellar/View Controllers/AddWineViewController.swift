//
//  WineDetailViewController.swift
//  Wine Cellar
//
//  Created by Tim Bausch on 11/3/22.
//

import PureLayout
import SwiftUI
import UIKit

class AddWineViewController: UIViewController {
    
    var coreDataStack: CoreDataStack!
    var wineViewModel: WineViewModel!
    var cellarViewModel: CellarViewModel!
    var isEditingWine: Bool
    var wine: Wine?
    var isFavorite: Bool = false
    
    private lazy var hostedView: UIHostingController = {
        let view = UIHostingController(rootView: AddCompleteWineView(viewModel: wineViewModel, dismissAction: {
            self.dismiss(animated: true)
            self.cellarViewModel.fetchWines()
        }))
        return view
    }()
    
    init(coreDataStack: CoreDataStack, wine: Wine?, isEditingWine: Bool = false) {
        self.wine = wine
        isFavorite = wine!.isFavorited
        self.isEditingWine = isEditingWine
        self.coreDataStack = coreDataStack
        wineViewModel = WineViewModel(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        super.init(nibName: nil, bundle: nil)
    }
    
    init(coreDataStack: CoreDataStack, cellarViewModel: CellarViewModel, isEditingWine: Bool = false) {
        self.isEditingWine = isEditingWine
        self.coreDataStack = coreDataStack
        self.cellarViewModel = cellarViewModel
        wineViewModel = WineViewModel(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 4, bottom: 16, trailing: 4)
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        view.addSubview(hostedView.view)
        hostedView.view.autoPinEdgesToSuperviewSafeArea()
    }
}
