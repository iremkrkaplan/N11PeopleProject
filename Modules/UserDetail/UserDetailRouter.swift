//
//  UserDetailRouter.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 4.09.2025.
//

import UIKit

final class UserDetailRouter: UserDetailRouterInput {
    
    weak var viewController: UIViewController?
    
    static func createModule(with username: String) -> UIViewController {
        
        let view: UserDetailViewInput & UIViewController = UserDetailViewController()
        
        let interactor: UserDetailInteractorInput = UserDetailAPIInteractor(username: username, apiClient: .live)
        
        let router: UserDetailRouterInput = UserDetailRouter()
        
        let presenter: UserDetailPresenterInput & UserDetailInteractorOutput = UserDetailPresenter()
        
        
        view.output = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return view
    }
    
    func openInBrowser(url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
