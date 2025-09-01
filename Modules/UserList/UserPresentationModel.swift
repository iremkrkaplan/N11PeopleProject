//
//  UserPresentationModel.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 29.08.2025.
//

import UIKit

struct UserListCellModel: Hashable {
    let id: Int
    let username: String
    let avatarURL: URL?
    let isFavorite: Bool
}

struct UserListViewData {
    let title: String
    let searchPlaceholder: String
//    TODO: let emptyStateAnimationName: String
}

struct UserNotFoundViewModel {
    let message: String
    let contactEmail: String
}
