//
//  AppLoader.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 18.08.2025.
//

import UIKit

public final class AppLoader {
    private let router = AppRouter()
    
    public init() {}
    
    public func load(in window: UIWindow) {
        window.rootViewController = router.buildMainInterface()
        window.makeKeyAndVisible()
    }
}
