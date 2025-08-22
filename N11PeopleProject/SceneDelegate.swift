//
//  SceneDelegate.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private let appLoader = AppLoader()
    // SceneDelegate.swift

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // 1. Pencereyi hazırla
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        // 2. ErrorView'i gösterecek bir ana ViewController oluştur
        let rootViewController = UIViewController()
        
        // 3. Bizim özel ErrorView'imizi oluştur
        let errorView = ErrorView()
        
        // 4. Modelimizdeki test verisiyle ErrorView'i doldur
        // Bu, ErrorPresentationModel.swift dosyasındaki static fonksiyondur
        let errorModel = ErrorPresentationModel.createViewData()
        errorView.bind(errorModel)
        // 5. ErrorView'i ana ViewController'ın view'ine ekle
        rootViewController.view.addSubview(errorView)
        
        // 6. ErrorView'in tüm ekranı kaplamasını sağla (Auto Layout)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: rootViewController.view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: rootViewController.view.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: rootViewController.view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: rootViewController.view.trailingAnchor)
        ])

        // 7. Hazırladığımız ViewController'ı uygulamanın başlangıç ekranı yap
        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
    }
/*
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        appLoader.load(in: window)
        
        self.window = window
    }
*/
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
