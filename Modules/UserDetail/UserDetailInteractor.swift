//
//  UserDetailInteractor.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 3.09.2025.
//

import Foundation

final class UserDetailAPIInteractor: UserDetailInteractorInput {
    
    weak var output: UserDetailInteractorOutput?
    private let apiClient: APIClient
    private let favoriteService: FavoriteStorageServiceProtocol
    private let username: String
    
    init(username: String,
         apiClient: APIClient,
         favoriteService: FavoriteStorageServiceProtocol = FavoriteStorageService.shared) {
        self.username = username
        self.apiClient = apiClient
        self.favoriteService = favoriteService
    }
    
    func fetchUserDetail() {
        Task {
            do {
                let params = GetUserDetailParams(username: self.username)
                let detail = try await apiClient.getUserDetail(params)
                await MainActor.run {
                    output?.didFetchUserDetailSuccessfully(detail: detail)
                }
            } catch {
                await MainActor.run {
                    output?.didFailToFetchUserDetail(error: error)
                }
            }
        }
    }
    
    func toggleFavoriteStatus() {
        favoriteService.toggleFavorite(username: self.username)
    }
}
