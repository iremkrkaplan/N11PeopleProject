//
//  UserFavoritesPresenter.swift
//  N11PeopleProject
//
//  Created by irem karakaplan on 7.09.2025.
//
import Foundation

final class UserFavoritesPresenter: UserFavoritesPresenterInput {
    
    // MARK: - Properties
    weak var view: UserFavoritesViewInput?
    var interactor: UserFavoritesInteractorInput?
    var router: UserFavoritesRouterInput?
    
    // DEĞİŞTİ: Artık bu diziler doğru tipi, yani `FavoriteCellModel`'ı tutuyor.
    private var allFavorites: [FavoriteCellModel] = []
    private var filteredFavorites: [FavoriteCellModel] = []

    // MARK: - Input from View
    func viewDidLoad() {
        view?.displayInitialState(title: "Favorilerim")
    }
    
    func viewWillAppear() {
        view?.displayLoading(true)
        interactor?.fetchFavoritedUsers()
    }
    
    func didSelectFavoriteUser(with model: FavoriteCellModel) {
        router?.navigateToUserDetail(username: model.usernameForAction)
    }
    
    func favoriteButtonTapped(for model: FavoriteCellModel) {
        interactor?.unfavoriteUser(username: model.usernameForAction)
    }
    
    // DEĞİŞTİ: Bu fonksiyon artık doğru tipteki diziler üzerinde çalışıyor.
    func searchTextChanged(to query: String) {
        if query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            // Arama çubuğu boşsa, filtrelenmemiş tam listeyi göster.
            filteredFavorites = allFavorites
        } else {
            // Arama çubuğunda metin varsa, tam liste içinde filtreleme yap.
            // `name`'e göre arama yapıyoruz.
            filteredFavorites = allFavorites.filter {
                $0.name.lowercased().contains(query.lowercased())
            }
        }
        // View'a, yeni filtrelenmiş sonuçlarla kendini çizmesini söyle.
        // Artık tipler uyuştuğu için hata vermeyecek.
        view?.bind(favorites: filteredFavorites)
    }
    
    // MARK: - Output from Interactor
    
    func didFetchFavorites(users: [User]) {
        view?.displayLoading(false)
        
        if users.isEmpty {
            view?.displayEmptyState(message: "Henüz hiçbir kullanıcıyı favorilerinize eklemediniz.")
        } else {
            // Ham `[User]` verisini, `[FavoriteCellModel]`'a çeviriyoruz.
            let cellModels = users.compactMap { user -> FavoriteCellModel? in
                let displayName = user.name?.isEmpty == false ? user.name! : user.login
                
                return FavoriteCellModel(
                    id: user.id,
                    name: displayName,
                    usernameForAction: user.login,
                    avatarURL: URL(string: user.avatarUrl),
                    isFavorite: true // Bu ekrandaki herkes favoridir.
                )
            }
            
            // DEĞİŞTİ: Yeni gelen veriyi, doğru tipteki property'lerimize atıyoruz.
            self.allFavorites = cellModels.sorted { $0.name.lowercased() < $1.name.lowercased() }
            self.filteredFavorites = self.allFavorites
            
            view?.bind(favorites: self.filteredFavorites)
        }
    }
    
    func didFailToFetchFavorites(error: Error) {
        view?.displayLoading(false)
        // ... Hata durumunu yönet ...
    }
}
