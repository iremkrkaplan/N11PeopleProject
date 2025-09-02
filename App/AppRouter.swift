//
//  AppRouter.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 18.08.2025.
//

import UIKit
final class AppRouter {
    
    func buildDashboardFeature() -> UIViewController {
        return DashboardRouter.createModule()
    }
    
    func buildUserListFeature() -> UIViewController {
        return UserListRouter.createModule()
    }
    
    func createPlaceholderViewController(title: String) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        viewController.title = title
        return viewController
    }
}
