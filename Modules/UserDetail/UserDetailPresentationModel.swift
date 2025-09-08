//
//  UserDetailPresentationModel.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 4.09.2025.
//

import Foundation

struct UserStatsPresentationModel {
    let followersText: String
    let followingText: String
}

struct GitHubButtonPresentationModel {
    let title: String
    let url: URL?
    let action: () -> Void
}

struct UserDetailViewData {
    let profileModel: ProfilePresentationModel
    let bioText: String?
    let statsModel: UserStatsPresentationModel
    let memberSinceText: String
    let githubButtonModel: GitHubButtonPresentationModel
    let isFavorite: Bool
}
