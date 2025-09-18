//
//  FavoriteStorageService.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 31.08.2025.
//

import Foundation

protocol FavoriteStorageServiceProtocol {
    func isFavorite(username: String) -> Bool
    func toggleFavorite(username: String)
    func getFavorites() -> Set<String>
}

final class FavoriteStorageService: FavoriteStorageServiceProtocol {
    static let shared = FavoriteStorageService()
    private let favoritesKey = "user_favorites"
    
    private init() {}
    
    func isFavorite(username: String) -> Bool {
        return getFavorites().contains(username)
    }
    
    func toggleFavorite(username: String) {
        var favorites = getFavorites()
        if favorites.contains(username) {
            favorites.remove(username)
        } else {
            favorites.insert(username)
        }
        UserDefaults.standard.set(Array(favorites), forKey: favoritesKey)
    }
    
    func getFavorites() -> Set<String> {
        let array = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        return Set(array)
    }
}
