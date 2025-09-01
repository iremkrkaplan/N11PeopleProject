//
//  UserListRouter.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 31.08.2025.
//

import UIKit

final class UserListRouter: UserListRouterInput {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        
        let view = UserListViewController()
        
        let interactor: UserListInteractorInput = UserListInteractor(apiClient: .live)
        let router: UserListRouterInput = UserListRouter()
        
        let presenter: UserListViewOutput & UserListInteractorOutput = UserListPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.output = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
    
    
    func navigateToUserDetail(username: String) {
        
        /* TODO: UserDetail from userlist
         guard let sourceView = viewController else { return }
         let detailVC = UserDetailRouter.createModule(with: username)
         sourceView.navigationController?.pushViewController(detailVC, animated: true)
         */
        
        print("ROUTER: \(username) kullanıcısının detayına gitme komutu alındı.")
        
        let alert = UIAlertController(
            title: "Navigasyon",
            message: "\(username) kullanıcısının detay sayfasına gidilecek.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        viewController?.present(alert, animated: true)
    }
}
