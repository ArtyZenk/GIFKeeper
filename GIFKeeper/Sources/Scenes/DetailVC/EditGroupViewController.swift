//
//  EditGroupViewController.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 26.10.2023.
//

import UIKit

class EditGroupViewController: UIViewController {

    // MARK: UI
    
    private lazy var groupsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: .editGroupCell)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    // MARK: Private properties
    
    private let groups = GifModel.getEditGroups()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupNavigationBar()
    }
}

// MARK: - UITableViewDelegate

extension EditGroupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension EditGroupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .editGroupCell, for: indexPath)
        let currentGroup = groups[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = currentGroup.name
        content.image = UIImage(systemName: currentGroup.imageName ?? "")
        content.imageProperties.tintColor = .black
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - Setup Hierarchy

private extension EditGroupViewController {
    func setupHierarchy() {
        view.addSubview(groupsTable)
    }
}

// MARK: - Setup Layout

private extension EditGroupViewController {
    func setupLayout() {
        groupsTable.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

// MARK: - Setup navigation bar

private extension EditGroupViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.appMainColor()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appMainColor()]
        title = "Gif name"
        
        navigationItem.setLeftBarButton(
            UIBarButtonItem(
                title: "Cancel",
                primaryAction: UIAction(handler: { _ in self.dismiss(animated: true) })
            ),
            animated: true
        )
        
        navigationItem.setRightBarButton(
            UIBarButtonItem(
                title: "Save",
                primaryAction: UIAction(handler: { _ in self.dismiss(animated: true) })
            ),
            animated: true
        )
    }
}

// MARK: - Identifier cell

private extension String {
    static let editGroupCell = "EditGroupCell"
}
