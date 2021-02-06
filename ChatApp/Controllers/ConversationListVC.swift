//
//  ConversationListVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 23.01.2021.
//

import UIKit


class ConversationListVC: UIViewController {
    private var reuseIdentifier = "Cell"
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    enum Section: Int, CaseIterable {
        case waiting
        case active
        
        func description() -> String {
            switch self {
            case .waiting: return "Waiting chats"
            case .active: return "Active chats"
            }
        }
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
    var currentUser: MUser!
    
    init(user: MUser) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(WaitingCell.self, forCellWithReuseIdentifier: WaitingCell.reuseIdentifier)
        
        let nibItem = UINib(nibName: "ActiveCell", bundle: .main)
        collectionView.register(nibItem, forCellWithReuseIdentifier: ActiveCell.reuseIdentifier)
        collectionView.backgroundColor = #colorLiteral(red: 0.9136453271, green: 0.9137768149, blue: 0.9136165977, alpha: 1)
        collectionView.register(Header.self, forSupplementaryViewOfKind: PeopleListVC.sectionHeaderElementKind, withReuseIdentifier: Header.reuseIdentifier)
        view.addSubview(collectionView)
        
        configureDataSource()
        applyInitialSnapshots()
        performQuery(with: nil)
        setupNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(singOut))
    }
    
    @objc func singOut() {
        AuthService.shared.signOut()
    }
    
    func setupNavigationBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.title = currentUser.fullname
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
            case .waiting:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaitingCell.reuseIdentifier, for: indexPath as IndexPath) as! WaitingCell
                cell.configure(imageName: chat.image)
                return cell
            case .active:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActiveCell.reuseIdentifier, for: indexPath as IndexPath) as! ActiveCell
                cell.configure(imageName: chat.image, fullname: chat.fullname, lastMessage: chat.lastMessage)
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
            guard let sectionKind = Section(rawValue: indexPath.section) else { return nil }
            supplementaryView.configure(text: sectionKind.description())
            return supplementaryView
        }
    }
    
    func applyInitialSnapshots() {
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        let charts = Bundle.main.decode([Item].self, from: "data")
        let charts2 = Bundle.main.decode([Item].self, from: "data2")
        
        var waitingSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        waitingSnapshot.append(charts)
        dataSource.apply(waitingSnapshot, to: .waiting, animatingDifferences: false)
        
        var activeSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        activeSnapshot.append(charts2)
        dataSource.apply(activeSnapshot, to: .active, animatingDifferences: false)
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            
            if (sectionKind == .waiting) {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
            } else if (sectionKind == .active) {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(80))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                
                section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            } else {
                fatalError("Unknown section!")
            }
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(1))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: PeopleListVC.sectionHeaderElementKind,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func performQuery(with filter: String?) {
        //
    }
}

extension ConversationListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
}
