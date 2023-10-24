//
//  AllGroupsViewController.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 20.10.2023.
//

import UIKit

final class AllGroupsViewController: UIViewController {
    
    // MARK: FIXME

    private let arrayPopularGifs = [GifModel]()
    private let arrayLatestGifs = [GifModel]()
    private let arrayGroupsGifs = [String]()
    
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
            return arrayLatestGifs.count
        case .popular:
            return arrayPopularGifs.count
        case .allGroups:
            return arrayGroupsGifs.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionLayoutKind.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionLayoutKind = SectionLayoutKind.allCases[indexPath.section]
        switch sectionLayoutKind {
        case .latest:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: .gifWithTextCell,
                for: indexPath
            ) as? GifWithTextCell
            else { return GifWithTextCell() }
            
            let model = arrayLatestGifs[indexPath.item]
            cell.configureCell(gifModel: model)
            return cell
        case .popular:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: .gifWithTextCell,
                for: indexPath
            ) as? GifWithTextCell
            else { return GifWithTextCell() }
            
            let model = arrayPopularGifs[indexPath.item]
            cell.configureCell(gifModel: model)
            return cell
        case .allGroups:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: .groupGifCell,
                for: indexPath
            ) as? GroupGifCell
            else { return GroupGifCell() }
            
            let item = arrayGroupsGifs[indexPath.item]
            cell.set(name: item)
            return cell
        }
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
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _ ) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            let sectionLayoutKind = SectionLayoutKind.allCases[sectionIndex]
            let amountColumns = sectionLayoutKind.columnAmountOnScreenInSection()
            switch sectionLayoutKind {
            case .latest:
                return self.createHorizontalSectionsLayout(with: amountColumns)
            case .popular:
                return self.createHorizontalSectionsLayout(with: amountColumns)
            case .allGroups:
                return self.createVerticalSectionLayout(with: amountColumns)
            }
        }
        return layout
    }
    
    // MARK: Horizontal layout configure
    
    func createHorizontalSectionsLayout(with countColumn: Double) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / countColumn),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1 / countColumn)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [headerItem]
        section.supplementaryContentInsetsReference = .safeArea
        return section
    }
    
    // MARK: Vartical layout configure
    
    func createVerticalSectionLayout(with amountColumn: Double) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / amountColumn),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1 / amountColumn)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [headerItem]
        section.supplementaryContentInsetsReference = .safeArea
        return section
    }
    
    // MARK: Headers of Sections
    
    private var headerItem: NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(25)
        )
        
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
}

// MARK: - Constants

private enum Constants {
    static let navigationTitle = "All my groups"
}
