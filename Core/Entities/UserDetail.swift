//
//  UserDetail.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 3.09.2025.
//

import Foundation

public struct UserDetail: Codable {
    public let id: Int
    public let login: String
    public let avatarUrl: String
    public let htmlUrl: String
    public let name: String?
    public let bio: String?
    public let followers: Int
    public let following: Int
    public let createdAt: Date
    
    public enum CodingKeys: String, CodingKey {
        case id, login, name, bio, followers, following
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case createdAt = "created_at"
    }
}

extension UserDetail{
    var AvatarAsURL: URL? {
        return URL(string: avatarUrl)
    }
}

extension UserDetail{
    var htmlAsURL: URL? {
        return URL(string: htmlUrl)
    }
}
