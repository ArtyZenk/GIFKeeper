//
//  GroupViewController.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 27.10.2023.
//

import UIKit

final class GroupViewController: UIViewController {

    // MARK: UIElements
    
    private let searchController: UISearchController = {
        let search = UISearchController()
        return search
    }()
    
    private lazy var gifsCollectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            GifCoverCell.self,
            forCellWithReuseIdentifier: .groupCell
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        setupHierarchy()
        setupLayout()
        configureView()
    }
}

// MARK: - Configure Navigation bar

extension GroupViewController {
    private func configureNavigationBar() {
        navigationItem.title = Constants.navigationTitle
        navigationItem.searchController = searchController
    }
}

// MARK: - Setup hierarchy

private extension GroupViewController {
    func setupHierarchy() {
        view.addSubview(gifsCollectionView)
    }
}

// MARK: - Setup layouts for UIElements

private extension GroupViewController {
    func setupLayout() {
        gifsCollectionView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
    }
}

// MARK: - Configure view property

private extension GroupViewController {
    func configureView() {
        view.backgroundColor = .white
    }
}

// MARK: - CollectionViewDataSource

extension GroupViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        35
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: .groupCell, for: indexPath)
    }
}

// MARK: - CollectionViewDelegate

extension GroupViewController: UICollectionViewDelegate {
}

// MARK: - Collection layout methods

private extension GroupViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.fullComponentSize / Constants.amountColumn),
            heightDimension: .fractionalHeight(
                Constants.fullComponentSize / Constants.amountColumn * Constants.itemHeightOffset
            )
        )
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constants.fullComponentSize),
            heightDimension: .fractionalWidth(1 / Constants.amountColumn)
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [layoutItem]
        )
        layoutGroup.interItemSpacing = .fixed(Constants.groupInterItemSpacing)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = .init(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        layoutSection.interGroupSpacing = Constants.sectionInterGroupSpacing
        return UICollectionViewCompositionalLayout(section: layoutSection)
    }
}

// MARK: - Setup properties

extension GroupViewController {
    func set(groupName: String) {
        navigationItem.title = groupName
    }
}

// MARK: - Constants

private enum Constants {
    static let navigationTitle = "Group name"
    
    static let fullComponentSize: CGFloat = 1
    static let amountColumn: CGFloat = 3
    
    static let itemHeightOffset: CGFloat = 2
   
    static let groupInterItemSpacing: CGFloat = 3
    static let sectionInterGroupSpacing: CGFloat = -40
}
