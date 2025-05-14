//
//  MovieDetail.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation
public enum MovieDetail {
    case movie(MovieDetailsPresentationModel)
    case similar([MoviePresentationModel])
    case directors([CastMemberPresentationModel])
    case actors([CastMemberPresentationModel])
    
    public var index: Int {
        switch self {
        case .movie: return 0
        case .similar: return 1
        case .directors: return 2
        case .actors: return 3
        }
    }
    
    public var title: String {
        switch self {
        case .movie: return ""
        case .similar: return "Similar movies"
        case .directors: return "Directors"
        case .actors: return "Actors"
        }
    }
}
