//
//  DashboardRouter.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 27.08.2025.
//
import UIKit

final class DashboardRouter: DashboardRouterInput {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = DashboardViewController()
        let interactor: DashboardInteractorInput = DashboardAPIInteractor(apiClient: .live)
        let router: DashboardRouterInput = DashboardRouter()
        
        let presenter: DashboardPresenterInput & DashboardInteractorOutput = DashboardPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
