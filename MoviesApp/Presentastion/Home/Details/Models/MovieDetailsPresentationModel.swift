//
//  MovieDetailsPresentationModel.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation

public struct MovieDetailsPresentationModel {
    public let thumbnail: String
    public let title: String
    public let overview: String
    public var isInWatchlist: Bool
    public let tagline: String
    public let revenue: String
    public let releaseDate: String
    public let status: String
    
    init(movie: Movie) {
        if let poster = movie.posterPath {
            self.thumbnail = "https://image.tmdb.org/t/p/w500" + poster
        } else {
            thumbnail = ""
        }
        self.title = movie.title ?? ""
        self.overview = movie.overview ?? ""
        self.isInWatchlist = WatchlistManager.shared.isInWatchlist(movie.id)
        self.tagline = movie.tagline ?? ""
        self.revenue = movie.revenue == nil ? "" : ["$", "\(movie.revenue ?? 0)"].compactMap { $0 }.joined()
        self.releaseDate = movie.releaseDate ?? "Unknown"
        self.status = movie.status ?? ""
    }
}
