//
//  AppLoader.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 18.08.2025.
//

import Foundation
import UIKit

public final class AppLoader {
    private let router = AppRouter()

    public init() {}

    public func load(in window: UIWindow) {
        let rootViewController = router.buildDashboardFeature()
        
        window.rootViewController = UINavigationController(rootViewController: rootViewController)
        window.makeKeyAndVisible()
    }
}
