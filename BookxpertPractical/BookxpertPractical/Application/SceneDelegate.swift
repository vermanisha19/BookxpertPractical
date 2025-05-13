//
//  SceneDelegate.swift
//  BookxpertPractical
//
//  Created by Nisha on 13/04/25.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if Auth.auth().currentUser != nil,
           let homeVC = UIStoryboard.main.get(HomeViewController.self) {
            window?.rootViewController = UINavigationController(rootViewController: homeVC)
        } else {
            let vc = UIStoryboard.main.get(ViewController.self)
            window?.rootViewController = vc
        }
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
}
