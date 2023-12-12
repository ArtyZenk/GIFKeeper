//
//  SceneDelegate.swift
//  GIFCollection
//
//  Created by Sonata Girl on 08.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.appMainColor,
            NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: 28,
                weight: .thin
            ),
        ]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().prefersLargeTitles = false
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

