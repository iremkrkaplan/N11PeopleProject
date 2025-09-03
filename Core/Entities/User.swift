//
//  User.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 21.08.2025.
//

import Foundation

struct User: Codable {
    let login: String
    let id: Int
    let avatarUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarUrl = "avatar_url"
    }
}
