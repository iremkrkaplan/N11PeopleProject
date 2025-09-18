//
//  User.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 21.08.2025.
//
import Foundation

struct User: Codable, Hashable {
    let login: String
    let id: Int
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarUrl = "avatar_url"
    }
}

extension User{
    var AvatarAsURL: URL? {
        return URL(string: avatarUrl)
    }
}
