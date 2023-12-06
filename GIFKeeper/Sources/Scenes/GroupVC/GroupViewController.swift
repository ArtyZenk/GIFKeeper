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

private extension GroupViewController {
    func configureNavigationBar() {
        navigationItem.title = Constants.navigationTitle
        navigationItem.searchController = searchController
        
        setupRightBarButtonItems()
    }
}
    
// MARK: - Setup right items of NavBar

private extension GroupViewController {
    func setupRightBarButtonItems() {
        let renameGroupAction = UIAction(title: "Rename group") { _ in
            self.renameButtonPressed()
        }
        
        let deleteGroupAction = UIAction(
            title: "Delete group",
            image: UIImage(systemName: "trash"),
            attributes: .destructive,
            handler: { _ in self.deleteButtonPressed() }
        )
                
        let editMenu = UIMenu(children: [renameGroupAction, deleteGroupAction])
        
        let editButton = UIBarButtonItem(
            image: UIImage(systemName: "text.justify"),
            primaryAction: .none,
            menu: editMenu
        )
            
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonPressed)
        )
        
        navigationItem.rightBarButtonItems = [favoriteButton, editButton]
    }
           
    // MARK: Navigation bar actions handling
    
    func renameButtonPressed() {
        let alertController = UIAlertController(
            title: "Rename group",
            message: nil,
            preferredStyle: .alert
        )
        alertController.addTextField { textField in
            textField.placeholder = "Enter new name"
            textField.clearButtonMode = .whileEditing
        }
        let actionOk = UIAlertAction(
            title: "Rename",
            style: .default
        ) { _ in
            if let text = alertController.textFields?.first?.text {
                print(text)
            } else {
                print("No text entered")
            }
        }
        
        let actionCancel = UIAlertAction(
            title: "Cancel",
            style: .destructive
        )
        
        alertController.addAction(actionOk)
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true)
    }
    
    func deleteButtonPressed() {}
    
    @objc func favoriteButtonPressed() {}
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
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(
            previewProvider: nil
            // TODO: Should create preview mode
        ) { actions -> UIMenu in
            let share = UIAction(title: "Отправить") { _ in self.shareData() }
            let edit = UIAction(title: "Редактировать") { _ in }
            let deleteFromGroup = UIAction(title: "Удалить из группы") { _ in }
            let deleteFromMemory = UIAction(title: "Удалить из памяти", attributes: .destructive) { _ in }
        
            return UIMenu(children: [share, edit, deleteFromGroup, deleteFromMemory])
        }
    }
}

// MARK: - Collection layout methods

private extension GroupViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layoutSection = CustomLayoutSection.shared.create(
            with: SectionSettings(
                columnAmount: 3,
                isGroup: false
            )
        )
        return UICollectionViewCompositionalLayout(section: layoutSection)
    }
}

// MARK: - UIActivityVC methods

private extension GroupViewController {
    func shareData() {
        // FIXME: Temporary model
        #warning("It's fake data")
        let images = [UIImage(systemName: "phone"), UIImage(systemName: "phone")]
        
        let shareController = UIActivityViewController(
            activityItems: images,
            applicationActivities: nil
        )
        
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            bool ? print("It's shared") : print("It isn't shared")
        }
        
        present(shareController, animated: true)
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
