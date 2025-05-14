//
//  MoviePresentationModel.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import Foundation

public struct MoviePresentationModel {
    public let thumbnail: String
    public let title: String
    public let overview: String
    public var isInWatchlist: Bool
    public let year: Int
    public let id: Int
    
    init(movie: Movie) {
        self.id = movie.id
        if let poster = movie.posterPath {
            self.thumbnail = "https://image.tmdb.org/t/p/w500" + poster
        } else {
            thumbnail = ""
        }
        self.title = movie.title ?? ""
        self.overview = movie.overview ?? ""
        self.isInWatchlist = WatchlistManager.shared.isInWatchlist(movie.id)
        let formatter: DateFormatter = {
            $0.dateFormat = "yyyy-MM-dd"
            return $0
        }(DateFormatter())
        let calendar = Calendar.current
        if let date = movie.releaseDate, let releaseDate = formatter.date(from: date),
            let year = calendar.dateComponents([.year], from: releaseDate).year {
            self.year = year
        } else {
            self.year = -1
        }
    }
}
