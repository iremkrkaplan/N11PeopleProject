//
//  AppRouter.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 18.08.2025.
//

import UIKit

public final class AppRouter {
    public init() {}

    func buildDashboardBuilder() -> UIViewController {
        let feature = DashboardBuilder(
            dependencies: .init(apiClient: .live)
        )
        return feature.build()
    }
}
