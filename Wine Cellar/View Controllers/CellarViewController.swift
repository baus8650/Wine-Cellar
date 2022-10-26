import Combine
import CoreData
import PureLayout
import SwiftUI
import UIKit

class CellarViewController: UIViewController {

    // MARK: - Properties
    var coreDataStack: CoreDataStack!
    var cellarViewModel: CellarViewModel!
    
    var wines = [Wine]()
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Views
    
    private lazy var addMenu: UIMenu = {
        let menu = UIMenu(title: "", children: [
            UIAction(title: "Add New Wine", image: UIImage(named: "FlightAttendantImage")) { [weak self] action in
                guard let self else { return }
                self.addWine()
            },
            UIAction(title: "Start New Flight", image: UIImage(systemName: "airplane.departure")) { action in
            }
        ])
        return menu
    }()
    
    private lazy var addWineButton: UIBarButtonItem = {
        let button = UIBarButtonItem(systemItem: .add, menu: addMenu)
        button.tintColor = UIColor(named: "WineColorAccent")
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        coreDataStack = CoreDataStack()
        cellarViewModel = CellarViewModel(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Wine Cellar"
        navigationItem.rightBarButtonItem = addWineButton
        setUpBindings()
    }

    private func setUpBindings() {
        cellarViewModel.$wines.sink { wines in
            self.wines = wines
            print(wines.count)
        }.store(in: &cancellables)
    }
    
    private func addWine() {
        let testWine = WineBuilder().build()
        cellarViewModel.addWine(abv: testWine.abv, ava: testWine.ava!, company: testWine.company, isFavorited: testWine.isFavorited, numberOwned: Int16(testWine.numberOwned), type: testWine.type.rawValue, varietal: testWine.varietal.rawValue, vintage: Int16(testWine.vintage), wineColor: testWine.wineColor.rawValue)
    }

}

