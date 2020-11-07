//
//  SceneDelegate.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 02/11/20.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let navigationController = UINavigationController(rootViewController: MenuTableViewController())
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}


struct SceneDelegate_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UIViewControllerPreview {
                UINavigationController(rootViewController: MenuTableViewController())
            }
            UIViewControllerPreview {
                MultiSectionCollectionViewController()
            }
        }
    }
}
