//
//  DashboardFeature.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 18.08.2025.
//

import UIKit

public struct DashboardFeature {
    
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
        let presenter = DashboardPresenter(view: view, interactor: interactor)
        view.presenter = presenter
        return view
    }
}
