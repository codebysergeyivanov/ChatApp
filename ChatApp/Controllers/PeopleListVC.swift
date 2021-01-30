//
//  ListVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 23.01.2021.
//

import UIKit


class PeopleListVC: UIViewController {
    private var reuseIdentifier = "Cell"
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    enum Section: Int, CaseIterable {
        case main
    }
    
    struct Item: Hashable, Decodable {
        let fullname: String
        let lastMessage: String
        let image: String
        let id: Int
        
        init(fullname: String, lastMessage: String, image: String, id: Int) {
            self.fullname = fullname
            self.lastMessage = lastMessage
            self.image = image
            self.id = id
        }
    }
    
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    let charts2 = Bundle.main.decode([Item].self, from: "data2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(ConversationCell.self, forCellWithReuseIdentifier: ConversationCell.reuseIdentifier)
        collectionView.backgroundColor = #colorLiteral(red: 0.9136453271, green: 0.9137768149, blue: 0.9136165977, alpha: 1)
        collectionView.register(Header.self, forSupplementaryViewOfKind: PeopleListVC.sectionHeaderElementKind, withReuseIdentifier: Header.reuseIdentifier)
        self.view.addSubview(collectionView)
        
        configureDataSource()
        applyInitialSnapshots()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.title = "Profiles"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9136453271, green: 0.9137768149, blue: 0.9136165977, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConversationCell.reuseIdentifier, for: indexPath as IndexPath) as! ConversationCell
                cell.configure(imageName: chat.image, fullname: chat.fullname)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { (
          collectionView: UICollectionView,
          kind: String,
          indexPath: IndexPath)
            -> UICollectionReusableView? in

          guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: Header.reuseIdentifier,
            for: indexPath) as? Header else {
              fatalError("Cannot create header view")
          }
          return supplementaryView
        }
    }
    
    func applyInitialSnapshots() {
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        var waitingSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        waitingSnapshot.append(charts2)
        dataSource.apply(waitingSnapshot, to: .main, animatingDifferences: false)
    }

    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            
            let contentSize = layoutEnvironment.container.effectiveContentSize
            let columns = contentSize.width > 800 ? 3 : 2
            let spacing = CGFloat(10)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(0.6))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            
            let headerSize = NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1.0),
              heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
              layoutSize: headerSize,
              elementKind: PeopleListVC.sectionHeaderElementKind,
              alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        return layout
    }
    func performQuery(with filter: String?) {
        let filtred = charts2.filter() {
            if (filter != nil) {
                return $0.fullname.lowercased().contains(filter?.lowercased() ?? "")
            }
            return true
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filtred)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension PeopleListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        performQuery(with: nil)
    }
}
