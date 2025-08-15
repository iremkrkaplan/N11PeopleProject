//
//  DashboardContracts.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 15.08.2025.
//

import Foundation

struct User: Codable {
    let login: String
    let id: Int
    let avatarUrl: URL
}

enum CodingKeys: String, CodingKey {
    case login, id
    case avatarUrl = "avatar_url"
}

struct UserSearchResponse: Codable {
    let items: [User]
}

protocol DashboardInteractorProtocol: AnyObject {
    func fetchUser(username: String) async throws -> User
}
