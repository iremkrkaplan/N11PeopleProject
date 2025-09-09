//
//  UserFavoritesContracts.swift
//  N11PeopleProject
//
//  Created by irem karakaplan on 7.09.2025.
//
import UIKit


protocol UserFavoritesViewInput: AnyObject {
    var output: UserFavoritesViewOutput? { get set }
    func displayInitialState(title: String)
    func displayLoading(_ isLoading: Bool)
    func bind(favorites: [FavoriteCellModel])
    func displayEmptyState(message: String)
}

protocol UserFavoritesViewOutput: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func didSelectFavoriteUser(with model: FavoriteCellModel)
    func favoriteButtonTapped(for model: FavoriteCellModel)
    func searchTextChanged(to query: String)
}

protocol UserFavoritesPresenterInput: UserFavoritesViewOutput, UserFavoritesInteractorOutput {
    var view: UserFavoritesViewInput? { get set }
    var interactor: UserFavoritesInteractorInput? { get set }
    var router: UserFavoritesRouterInput? { get set }
}

protocol UserFavoritesInteractorInput: AnyObject {
    var output: UserFavoritesInteractorOutput? { get set }
    func fetchFavoritedUsers()
    func unfavoriteUser(username: String)
}

protocol UserFavoritesInteractorOutput: AnyObject {
    // `Interactor`'ın Presenter'a bildireceği sonuçlar.
    // DİKKAT: `Interactor`, tüm zor işi yaptıktan sonra, `Presenter`'a
    // hala temiz bir `[User]` listesi verir.
    func didFetchFavorites(users: [User])
    func didFailToFetchFavorites(error: Error)
}

protocol UserFavoritesRouterInput: AnyObject {
    var viewController: UIViewController? { get set }
    func navigateToUserDetail(username: String)
}
