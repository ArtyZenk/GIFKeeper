//
//  SearchViewController.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 12.10.2023.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupView()
        setupNavigationBar()
    }
}

// MARK: - Setup methods

private extension SearchViewController {
    func setupHierarchy() {}
    
    func setupLayout() {}
    
    func setupView() {
        view.backgroundColor = .blue
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Searching GIFs"
    }
}
