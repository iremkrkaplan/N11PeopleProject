//
//  UserListInteractor.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 28.08.2025.
//

import Foundation

final class UserListInteractor: UserListInteractorInput {
    
    weak var output: UserListInteractorOutput?
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func searchUsers(with query: String){
        Task {
            do {
                let params = SearchUsersParams(query: query)
                let response = try await apiClient.searchUsers(params)
                await MainActor.run {
                    output?.didFetchUsersSuccessfully(users: response.items)
                }
            }	
            catch {
                await MainActor.run {
                    output?.didFailToFetchUsers(error: error)
                }
            }
        }
    }
}
