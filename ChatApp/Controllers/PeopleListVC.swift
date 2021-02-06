//
//  ListVC.swift
//  ChatApp
//
//  Created by Сергей Иванов on 23.01.2021.
//

import UIKit
import FirebaseFirestore


class PeopleListVC: UIViewController {
    private var reuseIdentifier = "Cell"
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    enum Section: Int, CaseIterable {
        case main
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, MUser>!
    var users = [MUser]()
    var currentUser: MUser!
    var usersObserver: ListenerRegistration!
    
    init(user: MUser) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        usersObserver.remove()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(PeopleCell.self, forCellWithReuseIdentifier: PeopleCell.reuseIdentifier)
        collectionView.backgroundColor = #colorLiteral(red: 0.9136453271, green: 0.9137768149, blue: 0.9136165977, alpha: 1)
        collectionView.register(Header.self, forSupplementaryViewOfKind: PeopleListVC.sectionHeaderElementKind, withReuseIdentifier: Header.reuseIdentifier)
        self.view.addSubview(collectionView)
        
        configureDataSource()
        setupNavigationBar()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(singOut))
        
        usersObserver = ListenerService.shared.observeObject(users) {
            result in
            switch result {
            case .success(let users):
                self.users = users
                self.performQuery(with: nil)
            case .failure(let error):
                print("Error fetching snapshots: \(error)")
            }
        }
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
        dataSource = UICollectionViewDiffableDataSource<Section, MUser>(collectionView: collectionView) {
            (collectionView, indexPath, chat) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeopleCell.reuseIdentifier, for: indexPath as IndexPath) as! PeopleCell
                cell.configure(avatarImageStringURL: chat.avatarImageStringURL, fullname: chat.fullname)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = {  [unowned self] (
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
            let items = self.dataSource.snapshot().itemIdentifiers(inSection: .main)
            supplementaryView.configure(text: "\(items.count) people nearby")
          return supplementaryView
        }
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
        let filtred = users.filter() {
            if (filter != nil) {
                return $0.fullname.lowercased().contains(filter?.lowercased() ?? "")
            }
            return true
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, MUser>()
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
