//
//  FavoriteGroupsViewController.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 19.10.2023.
//

import UIKit

final class FavoriteGroupsViewController: UIViewController {
    
    // MARK: UI
    
    private let searchController: UISearchController = {
        let search = UISearchController()
        return search
    }()
    
    private lazy var allGroupsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(UITableViewCell.self, forCellReuseIdentifier: .myCategoriesCell)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var favoriteGroupsCollection: UICollectionView = {
        let layout = createLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(GroupGifCell.self, forCellWithReuseIdentifier: .groupGifCell)
        collection.register(
            SectionsHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: .sectionsHeader
        )
        collection.showsVerticalScrollIndicator = false
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupView()
        setupNavigationBar()
    }
}

// MARK: - UITableViewDelegate

extension FavoriteGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableRowHeight
    }
}

// MARK: - UITableViewDataSource

extension FavoriteGroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.numberRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .myCategoriesCell, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = Constants.tableCellText
        content.image = UIImage(systemName: Constants.tableCellImage)
        content.imageProperties.tintColor = .red
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension FavoriteGroupsViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource

extension FavoriteGroupsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Constants.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: .groupGifCell, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard 
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: .sectionsHeader,
                for: indexPath
            ) as? SectionsHeader
        else { return UICollectionReusableView() }
        
        header.set(titleText: "Favorites")
        return header
    }
}

// MARK: - Composition layout methods

private extension FavoriteGroupsViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layoutSection = CustomLayoutSection.shared.create(with: SectionSettings())
        return UICollectionViewCompositionalLayout(section: layoutSection)
    }
}

// MARK: - Setup Hierarchy

private extension FavoriteGroupsViewController {
    func setupHierarchy() {
        view.addSubview(allGroupsTable)
        view.addSubview(favoriteGroupsCollection)
    }
}

// MARK: - Setup Layout

private extension FavoriteGroupsViewController {
    func setupLayout() {
        allGroupsTable.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Constants.tableHeight)
        }
        
        favoriteGroupsCollection.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(allGroupsTable.snp.bottom).offset(Constants.CollectionTopConstrain)
        }
    }
}

// MARK: - Setup View

private extension FavoriteGroupsViewController {
    func setupView() {
        view.backgroundColor = .white
    }
}

// MARK: - Setup navigation bar

private extension FavoriteGroupsViewController {
    func setupNavigationBar() {
        navigationItem.title = Constants.navigationTitle
        navigationItem.searchController = searchController
        
        setupRightBarButtonItems()
    }
}

// MARK: - Setup right items of NavBar

private extension FavoriteGroupsViewController {
    func setupRightBarButtonItems() {
        let editButton = UIBarButtonItem(
            image: UIImage(systemName: "text.justify"),
            style: .plain,
            target: self,
            action: nil
        )
        
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(showAddNewGroupForm)
        )
        
        navigationItem.rightBarButtonItems = [favoriteButton, editButton]
    }
}

// MARK: - Alert methods

private extension FavoriteGroupsViewController {
    @objc func showAddNewGroupForm() {
        let alert = UIAlertController(
            title: "Add new group",
            message: nil ,
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = "Enter name for group"
            textField.clearButtonMode = .whileEditing
        }
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in
            let _ = alert.textFields?.first
            // TODO: Add action behaving
        }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .destructive
        ) { _ in }
        
        [okAction, cancelAction].forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}

// MARK: - Constants

private enum Constants {
    static let navigationTitle = "Categories"
    
    static let tableRowHeight: CGFloat = 80
    static let numberRowInSection = 1
    static let tableHeight: CGFloat = 80
    
    static let tableCellText = "All my group"
    static let tableCellImage = "phone"
    
    static let CollectionTopConstrain: CGFloat = 16
    static let numberOfItemsInSection = 25
    
    static let headerWidth: CGFloat = 0.93
    static let headerHeight: CGFloat = 30
    static let itemWidth: CGFloat = 100
    static let itemHeight: CGFloat = 100
    static let absoluteViewWidth: CGFloat = 1
    static let absoluteViewHeight: CGFloat = 1
    static let countGroupInHeight: CGFloat = 4
    static let groupHeightOffset: CGFloat = 1.5
        
    static let sectionInterGroupSpacing: CGFloat = -35
}

private extension String {
    static let myCategoriesCell = "myCategoriesCell"
}
