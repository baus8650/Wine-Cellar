import Combine
import CoreData
import PureLayout
import SwiftUI
import UIKit

class CellarViewController: UIViewController {
    
    // MARK: - Properties
    typealias DataSource = UICollectionViewDiffableDataSource<Constants.WineColor, Wine>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Constants.WineColor, Wine>
    var coreDataStack: CoreDataStack!
    var cellarViewModel: CellarViewModel!
    var horizontalClass: UIUserInterfaceSizeClass!
    
    var wines = [Wine]()
    var redWines = [Wine]()
    var roseWines = [Wine]()
    var whiteWines = [Wine]()
    var winesToDelete = [Wine]()
    var bubbles = [Bubble]()
    var selectedIndices = Set<IndexPath>()
    var isEditingEnabled: Bool = false
    var sortParameter: Constants.SortingOptions!
    var filterParameter: Constants.FilterOptions!
    
    var cancellables = Set<AnyCancellable>()
    
    private lazy var datasource = makeDataSource()
    // MARK: - Views
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(forAutoLayout: ())
        searchBar.placeholder = "Search..."
        return searchBar
    }()
    
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
    
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(systemItem: .edit, primaryAction: UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.isEditingEnabled = true
            self.toggleEditMode()
        }))
        button.tintColor = UIColor(named: "WineColorAccent")
        return button
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(systemItem: .cancel, primaryAction: UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.isEditingEnabled = false
            self.toggleEditMode()
            self.selectedIndices = Set<IndexPath>()
            self.winesToDelete = []
        }))
        button.tintColor = UIColor(named: "WineColorAccent")
        return button
    }()
    
    private lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(systemItem: .trash, primaryAction: UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.isEditingEnabled = false
            self.toggleEditMode()
            self.deleteWines()
            self.selectedIndices = Set<IndexPath>()
            self.winesToDelete = []
        }))
        button.tintColor = UIColor(named: "WineColorAccent")
        return button
    }()
    
    private lazy var optionsButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"))
        button.tintColor = UIColor(named: "WineColorAccent")
        return button
    }()
    
    private lazy var selectAllButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "All", style: .plain, target: self, action: #selector(selectAllWines))
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
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Wine Cellar"
        horizontalClass = view.traitCollection.horizontalSizeClass
        coreDataStack = CoreDataStack()
        cellarViewModel = CellarViewModel(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        collectionView.dataSource = datasource
        collectionView.delegate = self
        setUpBarButtonItems()
        setUpSubviews()
        setUpBindings()
    }
    
    private func setUpBindings() {
        cellarViewModel.$wines.sink { [weak self] wines in
            guard let self else { return }
            self.wines = wines
            self.applySnapshot(animatingDifferences: true)
        }.store(in: &cancellables)
        
        cellarViewModel.$redWines.sink { [weak self] wines in
            guard let self else { return }
            self.redWines = wines
            self.applySnapshot(animatingDifferences: true)
        }.store(in: &cancellables)
        
        cellarViewModel.$roseWines.sink { [weak self] wines in
            guard let self else { return }
            self.roseWines = wines
            self.applySnapshot(animatingDifferences: true)
        }.store(in: &cancellables)
        
        cellarViewModel.$whiteWines.sink { [weak self] wines in
            guard let self else { return }
            self.whiteWines = wines
            self.applySnapshot(animatingDifferences: true)
        }.store(in: &cancellables)
        
        cellarViewModel.$bubbles.sink { [weak self] bubbles in
            guard let self else { return }
            self.bubbles = bubbles
        }.store(in: &cancellables)
        
        cellarViewModel.$sortParameter.sink { [weak self] sortParameter in
            guard let self else { return }
            self.sortParameter = sortParameter
            self.createContextMenu()
        }.store(in: &cancellables)
        
        cellarViewModel.$filterParameter.sink { [weak self] filterParameter in
            guard let self else { return }
            self.filterParameter = filterParameter
            self.createContextMenu()
        }.store(in: &cancellables)
    }
    
    private func setUpBarButtonItems() {
        navigationItem.rightBarButtonItems = isEditingEnabled ? [deleteButton] : [addWineButton, optionsButton]
        navigationItem.leftBarButtonItems = isEditingEnabled ? [selectAllButton, cancelButton] : [editButton]
    }
    
    private func setUpSubviews() {
        view.addSubview(searchBar)
        searchBar.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .top)
        collectionView.autoPinEdge(.top, to: .bottom, of: searchBar)
    }
    
    private func createContextMenu() {
        let sortOptions = UIMenu(title: "Sorting Options", children: [
            UIAction(
                title: Constants.SortingOptions.abvAscending.rawValue,
                image: sortParameter == Constants.SortingOptions.abvAscending ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.sortParameter = .abvAscending
                    self.cellarViewModel.fetchWines()
                },
            UIAction(
                title: Constants.SortingOptions.abvDescending.rawValue,
                image: sortParameter == Constants.SortingOptions.abvDescending ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.sortParameter = .abvDescending
                    self.cellarViewModel.fetchWines()
                },
            UIAction(
                title: Constants.SortingOptions.dateAscending.rawValue,
                image: sortParameter == Constants.SortingOptions.dateAscending ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.sortParameter = .dateAscending
                    self.cellarViewModel.fetchWines()
                },
            UIAction(
                title: Constants.SortingOptions.dateDescending.rawValue,
                image: sortParameter == Constants.SortingOptions.dateDescending ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.sortParameter = .dateDescending
                    self.cellarViewModel.fetchWines()
                },
            UIAction(
                title: Constants.SortingOptions.companyAscending.rawValue,
                image: sortParameter == Constants.SortingOptions.companyAscending ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.sortParameter = .companyAscending
                    self.cellarViewModel.fetchWines()
                },
            UIAction(
                title: Constants.SortingOptions.companyDescending.rawValue,
                image: sortParameter == Constants.SortingOptions.companyDescending ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.sortParameter = .companyDescending
                    self.cellarViewModel.fetchWines()
                },
            UIAction(
                title: Constants.SortingOptions.varietalAscending.rawValue,
                image: sortParameter == Constants.SortingOptions.varietalAscending ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.sortParameter = .varietalAscending
                    self.cellarViewModel.fetchWines()
                },
            UIAction(
                title: Constants.SortingOptions.varietalDescending.rawValue,
                image: sortParameter == Constants.SortingOptions.varietalDescending ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.sortParameter = .varietalDescending
                    self.cellarViewModel.fetchWines()
                },
            UIAction(
                title: Constants.SortingOptions.vintageAscending.rawValue,
                image: sortParameter == Constants.SortingOptions.vintageAscending ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.sortParameter = .vintageAscending
                    self.cellarViewModel.fetchWines()
                },
            UIAction(
                title: Constants.SortingOptions.vintageDescending.rawValue,
                image: sortParameter == Constants.SortingOptions.vintageDescending ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.sortParameter = .vintageDescending
                    self.cellarViewModel.fetchWines()
                }]
        )
        
        let filterOptions = UIMenu(title: "Filter Options", children: [
            UIAction(
                title: Constants.FilterOptions.allWines.rawValue,
                image: filterParameter == Constants.FilterOptions.allWines ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.filterParameter = .allWines
                    self.cellarViewModel.fetchWines()
                },
            UIAction(
                title: Constants.FilterOptions.sparklingOnly.rawValue,
                image: filterParameter == Constants.FilterOptions.sparklingOnly ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.filterParameter = .sparklingOnly
                    self.cellarViewModel.fetchWines()
                },
            UIAction(
                title: Constants.FilterOptions.stillOnly.rawValue,
                image: filterParameter == Constants.FilterOptions.stillOnly ?  UIImage(systemName: "checkmark.circle.fill")! : nil) { action in
                    self.cellarViewModel.filterParameter = .stillOnly
                    self.cellarViewModel.fetchWines()
                }
        ])
        let optionsMenu = UIMenu(title: "Options", children: [
            sortOptions,
            filterOptions
        ])
        optionsButton.menu = optionsMenu
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if view.traitCollection.horizontalSizeClass == .compact {
            horizontalClass = .compact
        } else {
            horizontalClass = .regular
        }
        collectionView.collectionViewLayout = generateLayout()
    }
    
    private func toggleEditMode() {
        setUpBarButtonItems()
        collectionView.reloadData()
    }
    
    private func addWine() {
        let whiteWine = WineBuilder()
            .company("New White wine")
            .wineColor(Constants.WineColor.white)
            .build()
        let redWine = WineBuilder()
            .company("New Red wine")
            .wineColor(Constants.WineColor.red)
            .build()
        let roseWine = WineBuilder()
            .company("New Rosé wine")
            .wineColor(Constants.WineColor.rose)
            .build()
        let whiteWineSparkling = WineBuilder()
            .company("New Sparkling White wine")
            .type(.sparkling)
            .wineColor(Constants.WineColor.white)
            .build()
        let redWineSparkling = WineBuilder()
            .company("New Sparkling Red wine")
            .type(.sparkling)
            .wineColor(Constants.WineColor.red)
            .build()
        let roseWineSparkling = WineBuilder()
            .company("New Sparkling Rosé wine")
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
    
    private func deleteWines() {
        cellarViewModel.deleteMultiple(winesToDelete)
    }
    
    @objc
    private func selectAllWines() {
        for red in 0..<redWines.count {
            selectedIndices.insert(IndexPath(row: red, section: Constants.WineColor.red.index))
        }
        for rose in 0..<redWines.count {
            selectedIndices.insert(IndexPath(row: rose, section: Constants.WineColor.rose.index))
        }
        for white in 0..<redWines.count {
            selectedIndices.insert(IndexPath(row: white, section: Constants.WineColor.white.index))
        }
        collectionView.reloadData()
        winesToDelete = wines
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
                    ZStack {
                        WineCellView(
                            wine: wine,
                            color: wine.wineColor ?? Constants.WineColor.red.rawValue,
                            isEditing: self.isEditingEnabled,
                            isSelected: self.selectedIndices.contains(indexPath) ? true : false,
                            bubbles: self.bubbles)
                    }
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
        snapshot.appendItems(redWines, toSection: .red)
        snapshot.appendItems(roseWines, toSection: .rose)
        snapshot.appendItems(whiteWines, toSection: .white)
        datasource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(horizontalClass == .regular ? 1/2 : 1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(190))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: UIDevice.current.userInterfaceIdiom == .pad ? 2 : 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 8, trailing: 0)
        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(20)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        sectionHeader.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension CellarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditingEnabled {
            if selectedIndices.contains(indexPath) {
                selectedIndices.remove(indexPath)
                collectionView.reloadData()
            } else {
                selectedIndices.insert(indexPath)
                collectionView.reloadData()
            }
            winesToDelete = []
            let _ = selectedIndices.map {
                switch $0.section {
                case Constants.WineColor.red.index:
                    winesToDelete.append(redWines[$0.row])
                case Constants.WineColor.rose.index:
                    winesToDelete.append(roseWines[$0.row])
                case Constants.WineColor.white.index:
                    winesToDelete.append(whiteWines[$0.row])
                default:
                    fatalError("Wine out of index range")
                }
            }
        }
    }
}

extension Hashable where Self : CaseIterable {
    var index: Self.AllCases.Index {
        return type(of: self).allCases.firstIndex(of: self)!
    }
}
