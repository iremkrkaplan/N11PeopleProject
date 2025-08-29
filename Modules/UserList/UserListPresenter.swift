//
//  UserListPresenter.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 28.08.2025.
//

import Foundation

final class UserListPresenter: UserListViewOutput, UserListInteractorOutput {
    
    private weak var view: UserListViewInput?
    private let interactor: UserListInteractorInput
    private let router: UserListRouterInput
    private var users: [User] = []

    init(view: UserListViewInput,
         interactor: UserListInteractorInput,
         router: UserListRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
        
    func viewDidLoad() {
        let initialData = UserListViewData(
            title: "Kullanıcı Ara",
            searchPlaceholder: "GitHub kullanıcısı ara..."
        )
        view?.displayInitialState(with: initialData)
    }
    
    func searchButtonTapped(with query: String) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        view?.displayLoading(true)
        interactor.searchUsers(with: query)
    }
    
    func didSelectUser(with model: UserListCellModel) {
        router.navigateToUserDetail(username: model.username)
    }
    
    func didFetchUsersSuccessfully(users: [User]) {
        self.users = users
        
        let cellModels = users.map { user -> UserListCellModel in
            return UserListCellModel(
                id: user.id,
                username: user.login,
                avatarURL: URL(string: user.avatarUrl)
            )
        }
        
        view?.displayLoading(false)
        
        if cellModels.isEmpty {
            view?.displayError(title: "Sonuç Bulunamadı", message: "Girdiğiniz kritere uygun kullanıcı bulunamadı.")
        } else {
            view?.bind(results: cellModels)
        }
    }
    
    func didFailToFetchUsers(error: Error) {
        view?.displayLoading(false)
        view?.displayError(title: "Hata Oluştu", message: "Arama sırasında bir sorun oluştu. Lütfen tekrar deneyin.")

        print("Error from Interactor: \(error.localizedDescription)")
    }
}
