//
//  DashboardFeature.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 18.08.2025.
//

import Foundation
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

        let interactor = DashboardAPIInteractor(apiClient: dependencies.apiClient)
        
        let vc = DashboardViewController(interactor: interactor)
        return vc
    }
}
