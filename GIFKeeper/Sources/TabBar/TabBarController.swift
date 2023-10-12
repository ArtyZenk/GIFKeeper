//
//  TabBarController.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 12.10.2023.
//

import UIKit

class TabBarController: UITabBarController, UITableViewDelegate {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
        setupTabBarViewControllers()
    }
    
    // MARK: - Private methods
    
    private func setupTabBarController() {
        view.backgroundColor = .systemGray5
        tabBar.tintColor = .systemOrange
        tabBar.isTranslucent = false
    }
    
    private func setupTabBarViewControllers() {
        let groupsVC = UINavigationController(rootViewController: GifGroupsViewController())
        groupsVC.tabBarItem = UITabBarItem(title: Constants.groupsVCTitle,
                                           image: UIImage(systemName: Constants.groupsVCImage),
                                           selectedImage: UIImage(systemName: Constants.groupsVCSelectedImage))
        
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem = UITabBarItem(title: Constants.searchVCTitle,
                                           image: UIImage(systemName: Constants.searchVCImage),
                                           selectedImage: UIImage(systemName: Constants.searchVCSelectedImage))
        
        setViewControllers([groupsVC, searchVC], animated: true)
        selectedViewController = groupsVC
    }
}

// MARK: - Constants

private extension TabBarController {
    enum Constants {
        static let groupsVCTitle = "Groups"
        static let groupsVCImage = "rectangle.on.rectangle"
        static let groupsVCSelectedImage = "rectangle.fill.on.rectangle.fill"
        
        static let searchVCTitle = "Search"
        static let searchVCImage = "magnifyingglass.circle"
        static let searchVCSelectedImage = "magnifyingglass.circle.fill"
    }
}
