//
//  DashboardInteractor.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 15.08.2025.
//

import Foundation

final class DashboardAPIInteractor: DashboardInteractorProtocol {
    private let apiClient: APIClient
    weak var presenter: DashboardInteractorOutputProtocol?
    
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchAuthenticatedUser() {
        Task {
            do {
                let user = try await self.apiClient.getAuthenticatedUser()
                await MainActor.run {
                    presenter?.didFetchUser(user: user)
                }
            } catch {
                await MainActor.run {
                    presenter?.didFailToFetchUser(error: error)
                }
            }
        }
    }
}
