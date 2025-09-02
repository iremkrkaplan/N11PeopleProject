//
//  AppRouter.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 18.08.2025.
//

import UIKit

final class AppRouter {
    
    func buildMainInterface() -> UITabBarController {
        
        let tabBarController = MainTabBarController()
        
        let dashboardVC = buildDashboardFeature()
        let searchVC = buildUserListFeature()
        let listsVC = createPlaceholderViewController(title: "Listelerim")
        let accountVC = createPlaceholderViewController(title: "Ana sayfa")
        
        let dashboardNav = UINavigationController(rootViewController: dashboardVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let listsNav = UINavigationController(rootViewController: listsVC)
        let accountNav = UINavigationController(rootViewController: accountVC)
        tabBarController.viewControllers = [dashboardNav, searchNav, listsNav, accountNav]
        
        return tabBarController
    }
    
    private func createPlaceholderViewController(title: String) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.title = title
        return viewController
    }
    
    private func buildDashboardFeature() -> UIViewController {
        return DashboardRouter.createModule()
    }
    
    private func buildUserListFeature() -> UIViewController {
        return UserListRouter.createModule()
    }
}
