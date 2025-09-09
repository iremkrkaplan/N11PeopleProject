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
    
    func buildUserFavoritesFeature() -> UIViewController {
        return UserFavoritesRouter.createModule()
    }
}
