//
//  DashboardBuilder.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 28.08.2025.
//

import UIKit

public struct DashboardBuilder {
    
    public struct Dependencies {
        let apiClient: APIClient
    }
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func build() -> UIViewController {
        let view = DashboardViewController(nibName: nil, bundle: nil)
        let interactor = DashboardAPIInteractor(apiClient: dependencies.apiClient)
        let router = DashboardRouter()
        let presenter = DashboardPresenter(view: view, interactor: interactor, router: router)
        interactor.presenter = presenter
        view.presenter = presenter
        router.viewController = view
        return view
    }
}
