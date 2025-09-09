//
//  UserFavoritesPresentationModel .swift
//  N11PeopleProject
//
//  Created by irem karakaplan on 7.09.2025.
//

import Foundation

struct FavoriteCellModel: Hashable {
    // `id` hala `DiffableDataSource`'un elemanları ayırt etmesi için gereklidir.
    let id: Int
    let name: String
    let usernameForAction: String // Favoriden çıkarmak için `login`'i ayrı tutalım.
    let avatarURL: URL?
    let isFavorite: Bool
}
