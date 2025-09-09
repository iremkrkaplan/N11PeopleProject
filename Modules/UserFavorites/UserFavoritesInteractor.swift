//
//  UserFavoritesInteractor.swift
//  N11PeopleProject
//
//  Created by irem karakaplan on 7.09.2025.
//
import Foundation

final class FavoritesListInteractor: UserFavoritesInteractorInput {
    
    weak var output: UserFavoritesInteractorOutput?
    private let apiClient: APIClient
    private let favoriteService: FavoriteStorageServiceProtocol
    
    init(apiClient: APIClient,
         favoriteService: FavoriteStorageServiceProtocol = FavoriteStorageService.shared) {
        self.apiClient = apiClient
        self.favoriteService = favoriteService
    }

    func fetchFavoritedUsers() {
        // 1. Cihaz hafızasından favori `username`'lerini al.
        let favoriteUsernames = favoriteService.getFavorites()
        
        if favoriteUsernames.isEmpty {
            Task { await MainActor.run { output?.didFetchFavorites(users: []) } }
            return
        }
        
        Task {
            do {
                // 2. Bu `username`'lerin her biri için, API'dan zengin `UserDetail`'i çek.
                // TaskGroup, bu 10-20 isteği aynı anda ve hızlıca yapar.
                let userDetails: [UserDetail] = try await withThrowingTaskGroup(of: UserDetail.self) { group in
                    
                    for username in favoriteUsernames {
                        group.addTask {
                            let params = GetUserDetailParams(username: username)
                            // `UserDetail` getiren `apiClient` fonksiyonunu çağırıyoruz.
                            return try await self.apiClient.getUserDetail(params)
                        }
                    }
                    
                    var collectedDetails: [UserDetail] = []
                    for try await detail in group {
                        collectedDetails.append(detail)
                    }
                    return collectedDetails
                }
                
                // 3. Şimdi, `Presenter`'ın beklediği `[User]` listesini oluşturmak için,
                // bu zengin `[UserDetail]` listesini "dönüştürüyoruz".
                let users = userDetails.map { detail -> User in
                    return User(
                        login: detail.login,
                        id: detail.id,
                        avatarUrl: detail.avatarUrl,
                        name: detail.name
                    )
                }
                
                // 4. `Presenter`'a, artık `name` bilgisini de içeren bu listeyi gönder.
                await MainActor.run {
                    output?.didFetchFavorites(users: users)
                }
                
            } catch {
                await MainActor.run {
                    output?.didFailToFetchFavorites(error: error)
                }
            }
        }
    }
    
    func unfavoriteUser(username: String) {
        favoriteService.toggleFavorite(username: username)
        fetchFavoritedUsers()
    }
}
