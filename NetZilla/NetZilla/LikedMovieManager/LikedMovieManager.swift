//
//  LikedMovieManager.swift
//  NetZilla
//
//  Created by Davit Muradyan on 30.06.25.
//

import Foundation

class LikedMoviesManager {
    private let key = "likedMovieIDs"
    
    var likedMovieIDs: [Int] {
        get {
            if let data = UserDefaults.standard.data(forKey: key),
               let ids = try? JSONDecoder().decode([Int].self, from: data) {
                return ids
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }

    func isLiked(_ id: Int) -> Bool {
        likedMovieIDs.contains(id)
    }

    func toggleLike(id: Int) {
        var current = likedMovieIDs
        if current.contains(id) {
            current.removeAll { $0 == id }
        } else {
            current.append(id)
        }
        likedMovieIDs = current
    }
}
