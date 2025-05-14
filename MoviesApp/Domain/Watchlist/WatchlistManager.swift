//
//  WatchlistManager.swift
//  MoviesApp
//
//  Created by Khaled hashem on 14/05/2025.
//

import Foundation

final class WatchlistManager {
    private let key = "watchlist_ids"
    private let defaults = UserDefaults.standard

    static let shared = WatchlistManager()

    private init() {}

    private func getWatchlist() -> Set<Int> {
        let ids = defaults.array(forKey: key) as? [Int] ?? []
        return Set(ids)
    }

    func isInWatchlist(_ id: Int) -> Bool {
        return getWatchlist().contains(id)
    }

    func toggle(id: Int) -> Bool {
        var ids = getWatchlist()
        let added: Bool
        if ids.contains(id) {
            ids.remove(id)
            added = false
        } else {
            ids.insert(id)
            added = true
        }
        defaults.set(Array(ids), forKey: key)
        return added
    }
}
