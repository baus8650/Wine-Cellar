import Combine
import CoreData
import PureLayout
import SwiftUI
import UIKit

class CellarViewController: UIViewController {
    
    // MARK: - Properties
    var coreDataStack: CoreDataStack!
    var cellarViewModel: CellarViewModel!
    var horizontalClass: UIUserInterfaceSizeClass!
    
    var wines = [Wine]()
    var cancellables = Set<AnyCancellable>()
    typealias DataSource = UICollectionViewDiffableDataSource<Constants.WineColor, Wine>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Constants.WineColor, Wine>
    
    private lazy var datasource = makeDataSource()
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = generateLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "WineCell")
        collectionView.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Wine Cellar"
        navigationItem.rightBarButtonItem = addWineButton
        horizontalClass = view.traitCollection.horizontalSizeClass
        coreDataStack = CoreDataStack()
        cellarViewModel = CellarViewModel(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        collectionView.dataSource = datasource
        setUpSubviews()
        setUpBindings()
    }
    
    private func setUpBindings() {
        cellarViewModel.$wines.sink { [weak self] wines in
            guard let self else { return }
            self.wines = wines
            self.applySnapshot(animatingDifferences: true)
        }.store(in: &cancellables)
    }
    
    private func setUpSubviews() {
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewSafeArea()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if view.traitCollection.horizontalSizeClass == .compact {
            horizontalClass = .compact
        } else {
            horizontalClass = .regular
        }
        collectionView.collectionViewLayout = generateLayout()
    }
    
    private func addWine() {
        let whiteWine = WineBuilder()
            .company("White wine")
            .wineColor(Constants.WineColor.white)
            .build()
        let redWine = WineBuilder()
            .company("Red wine")
            .wineColor(Constants.WineColor.red)
            .build()
        let roseWine = WineBuilder()
            .company("Rosé wine")
            .wineColor(Constants.WineColor.rose)
            .build()
        let whiteWineSparkling = WineBuilder()
            .company("Sparkling White wine")
            .type(.sparkling)
            .wineColor(Constants.WineColor.white)
            .build()
        let redWineSparkling = WineBuilder()
            .company("Sparkling Red wine")
            .type(.sparkling)
            .wineColor(Constants.WineColor.red)
            .build()
        let roseWineSparkling = WineBuilder()
            .company("Sparkling Rosé wine")
            .type(.sparkling)
            .wineColor(Constants.WineColor.rose)
            .build()
        let demoWines = [redWine, whiteWine, roseWine, redWineSparkling, whiteWineSparkling, roseWineSparkling]
        let testWine = demoWines.randomElement()!
        cellarViewModel.addWine(
            abv: testWine.abv, 
            ava: testWine.ava!,
            company: testWine.company,
            isFavorited: testWine.isFavorited,
            numberOwned: Int16(testWine.numberOwned),
            type: testWine.type.rawValue,
            varietal: testWine.varietal.rawValue,
            vintage: Int16(testWine.vintage),
            wineColor: testWine.wineColor.rawValue)
    }
    
    private func makeDataSource() -> DataSource? {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, wine) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "WineCell",
                    for: indexPath)
                cell.contentConfiguration = UIHostingConfiguration {
                    WineCellView(wine: wine, color: wine.wineColor ?? "Red")
                        .cornerRadius(8)
                }
                return cell
            })
        dataSource.supplementaryViewProvider = { collectionView, section, indexPath in
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: section,
                withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier,
                for: indexPath) as? SectionHeaderReusableView
            let section = self.datasource?.snapshot()
                .sectionIdentifiers[indexPath.section]
            view?.titleLabel.text = section?.rawValue
            view?.titleLabel.textColor = UIColor(named: "Header\(section!.rawValue)")
            return view
        }
        return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(Constants.WineColor.allCases)
        let reds = wines.filter { wine in
            wine.wineColor == Constants.WineColor.red.rawValue
        }
        let whites = wines.filter { wine in
            wine.wineColor == Constants.WineColor.white.rawValue
        }
        let roses = wines.filter { wine in
            wine.wineColor == Constants.WineColor.rose.rawValue
        }
        
        snapshot.appendItems(roses, toSection: .rose)
        snapshot.appendItems(whites, toSection: .white)
        snapshot.appendItems(reds, toSection: .red)
        datasource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(horizontalClass == .regular ? 1/2 : 1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(190))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: UIDevice.current.userInterfaceIdiom == .pad ? 2 : 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(20)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}
