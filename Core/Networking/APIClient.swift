//
//  APIClient.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 17.08.2025.
//

import Foundation

struct APIClient {
    var searchUsers: (SearchUsersParams) async throws -> UserSearchResponse
    var getAuthenticatedUser: () async throws -> User
    
    static let noop = Self(
        searchUsers: { _ in try await Task.never() },
        getAuthenticatedUser: { try await Task.never() }
    )
}

extension Task where Failure == Never {
    static func never() async throws -> Success {
        for await element in AsyncStream<Success>.never { return element }
        throw _Concurrency.CancellationError()
    }
}
extension AsyncStream {
    static var never: Self { Self { _ in } }
}
