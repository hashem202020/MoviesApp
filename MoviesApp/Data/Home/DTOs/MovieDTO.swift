//
//  MovieDTO.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

public struct MovieDTO: Codable {
    let id: Int
    let overview, title: String?
    let posterPath: String?
    let releaseDate: String?
    let revenue: Double?
    let status, tagline: String?
    
    public func toDomain() -> Movie {
        Movie(id: id,
              overview: overview,
              title: title,
              posterPath: posterPath,
              releaseDate: releaseDate,
              revenue: revenue,
              status: status,
              tagline: tagline)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, overview, title, revenue, status, tagline
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
