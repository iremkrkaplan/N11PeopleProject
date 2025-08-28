//
//  UserSearchResponse.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 21.08.2025.
//

import Foundation

struct UserSearchResponse: Codable {
    let items: [User]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

