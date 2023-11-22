//
//  SettingsViewController.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 09.11.2023.
//

import UIKit

class SettingsViewController: UIViewController {
   
    // MARK: Properties
    
   private var settingsList: [[String: Any]] = []
   
    // MARK: UIElements
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            SettingsCell.self,
            forCellReuseIdentifier: .settingsCell
        )
        return tableView
    }()
    
    // MARK: View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataSettings()
        configureNavigationBar()
        setupHierarchy()
        setupLayout()
        configureView()
    }

    // MARK: Load data methods
    
    private func loadDataSettings() {
        
        // FIXME: Temporary model
        #warning("Text data, needs to be change")
        settingsList =  [
            ["Dark theme on" : false ],
            ["Developers" : URL(string: "https://github.com/Sonata-Girl/GIFKeeper") ?? URL(fileURLWithPath: "")],
        ]
    }
    
    // MARK: Handle actions methods
    
    @objc private func deleteButtonPressed() {}
}

// MARK: - Configure Navigation bar

extension SettingsViewController {
    private func configureNavigationBar() {
        navigationItem.title = "Settings"
    }
}

// MARK: - Setup hierarchy

private extension SettingsViewController {
    func setupHierarchy() {
        view.addSubview(settingsTableView)
    }
}

// MARK: - Setup constraints

private extension SettingsViewController {
    func setupLayout() {
        settingsTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Configure view

private extension SettingsViewController {
    func configureView() {
        view.backgroundColor = .white
    }
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: .settingsCell,
            for: indexPath
        ) as? SettingsCell else { return SettingsCell() }
        
        if let item = settingsList[indexPath.row].first {
            cell.set(titleText: item.key, valueOut: item.value)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

// MARK: - Constants

private enum Constants {
    static var halfOfPointAlpha: CGFloat = 0.5
    static var veryLightAlpha: CGFloat = 0.2
}
