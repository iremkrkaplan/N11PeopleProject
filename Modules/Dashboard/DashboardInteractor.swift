//
//  DashboardInteractor.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 15.08.2025.
//

import Foundation

final class DashboardAPIInteractor: DashboardInteractorProtocol {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchUser(username: String) async throws -> User {
        let params = GetUserParams(username: username)
        
        return try await self.apiClient.getUser(params)
    }
}
