//
//  AppRouter.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 18.08.2025.
//

import Foundation
import UIKit

public final class AppRouter {
    public init() {}

    func buildDashboardFeature() -> UIViewController {
        let feature = DashboardFeature(
            dependencies: .init(apiClient: .live)
        )
        return feature.build()
    }
}
