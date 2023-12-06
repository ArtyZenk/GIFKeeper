//
//  AllGroupsViewController.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 20.10.2023.
//

import UIKit

final class AllGroupsViewController: UIViewController {
    
    // MARK: FIXME

    private let popularSectionGifs: [GifModel] = []
    private let latestSectionGifs: [GifModel] = []
    private let groupsList: [String] = []
    
    // MARK: UIElements
    
    private let searchController: UISearchController = {
        let search = UISearchController()
        return search
    }()
    
    private lazy var allGroupsCollection: UICollectionView = {
        let collectionLayout = createCollectionLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionLayout
        )
        collectionView.dataSource = self
        collectionView.register(
            GifWithTextCell.self,
            forCellWithReuseIdentifier: .gifWithTextCell
        )
        collectionView.register(
            GroupGifCell.self,
            forCellWithReuseIdentifier: .groupGifCell
        )
        collectionView.register(
            SectionsHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: .sectionsHeader)
        return collectionView
    }()
    
    // MARK: View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupHierarchy()
        setupLayout()
        configureView()
    }
}

// MARK: - Configure Navigation bar

extension AllGroupsViewController {
    private func configureNavigationBar() {
        navigationItem.title = Constants.navigationTitle
        navigationItem.searchController = searchController
        
        setupRightBarButtonItem()
    }
}

// MARK: - Setup right items of NavBar

private extension AllGroupsViewController {
    func setupRightBarButtonItem() {
        let addGroupButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(showAddNewGroupForm)
        )
        
        navigationItem.rightBarButtonItem = addGroupButton
    }
    
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
            self.navigationController?.pushViewController(DetailGifViewController(), animated: true)
        }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .destructive
        ) { _ in }
        
        [okAction, cancelAction].forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}

// MARK: - Setup hierarchy

private extension AllGroupsViewController {
    func setupHierarchy() {
        view.addSubview(allGroupsCollection)
    }
}

// MARK: - Setup layouts for UIElements

private extension AllGroupsViewController {
    func setupLayout() {
        allGroupsCollection.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
    }
}

// MARK: - Configure view property

private extension AllGroupsViewController {
    func configureView() {
        view.backgroundColor = .white
    }
}

// MARK: - CollectionViewDataSource

extension AllGroupsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionLayoutKind = SectionLayoutKind.allCases[section]
        switch sectionLayoutKind {
        case .latest:
            return latestSectionGifs.count
        case .popular:
            return popularSectionGifs.count
        case .allGroups:
            return groupsList.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionLayoutKind.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionLayoutKind = SectionLayoutKind.allCases[indexPath.section]
        switch sectionLayoutKind {
        case .latest:
                return getGifWithTextCell(
                    collectionView,
                    for: indexPath,
                    source: latestSectionGifs,
                    section: .latest
                )
        case .popular:
                return getGifWithTextCell(
                    collectionView,
                    for: indexPath,
                    source: popularSectionGifs,
                    section: .popular
                )
        case .allGroups:
            return getGroupGifCell(
                collectionView,
                for: indexPath,
                source: groupsList
            )
        }
    }
    
    // TODO: Need fix when models be ready
  
    private func getGifWithTextCell(
        _ collectionView: UICollectionView,
        for indexPath: IndexPath,
        source: [GifModel],
        section: SectionLayoutKind
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: .gifWithTextCell,
            for: indexPath
        ) as? GifWithTextCell else { return GifWithTextCell() }
        
        cell.configureCell(gifModel: source[indexPath.item])
        return cell
    }

    private func getGroupGifCell(
        _ collectionView: UICollectionView,
        for indexPath: IndexPath,
        source: [String]
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: .groupGifCell,
            for: indexPath
        ) as? GroupGifCell else { return GroupGifCell() }
        
        cell.set(name: source[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionLayoutKind = SectionLayoutKind.allCases[indexPath.section]
        var headerTitle = ""
        switch sectionLayoutKind {
        case .latest:
            headerTitle = "Latest"
        case .popular:
            headerTitle = "Popular"
        case .allGroups:
            headerTitle = "All my groups"
        }
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: .sectionsHeader,
            for: indexPath
        ) as? SectionsHeader
        else { return UICollectionReusableView() }
        
        header.set(titleText: headerTitle)
        return header
    }
}

// MARK: - CollectionViewDelegate

extension AllGroupsViewController: UICollectionViewDelegate {}

// MARK: - Collection layout methods

private extension AllGroupsViewController {
    enum SectionLayoutKind: Int, CaseIterable {
        case latest
        case popular
        case allGroups
        
        func columnAmountOnScreenInSection() -> Double {
            if self == .allGroups {
                return 4
            } else {
                return 3
            }
        }
    }
    
    func createCollectionLayout() -> UICollectionViewLayout {
        let sectionLayout = CustomLayoutSection.shared
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _ ) -> NSCollectionLayoutSection in
            let sectionLayoutKind = SectionLayoutKind.allCases[sectionIndex]
            let amountColumns = sectionLayoutKind.columnAmountOnScreenInSection()
            switch sectionLayoutKind {
            case .latest:
                return sectionLayout.create(
                    with: SectionSettings(
                        columnAmount: amountColumns,
                        horizontalScroll: true
                    )
                )
            case .popular:
                return sectionLayout.create(
                    with: SectionSettings(
                        columnAmount: amountColumns,
                        horizontalScroll: true
                    )
                )
            case .allGroups:
                return sectionLayout.create(
                    with: SectionSettings(columnAmount: amountColumns)
                )
            }
        }
        return layout
    }
}

// MARK: - Constants

private enum Constants {
    static let navigationTitle = "All groups"
}
