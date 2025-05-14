//
//  CastMemberPresentationModel.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation

public struct CastMemberPresentationModel {
    public let profile: String
    public let name: String
    public let id: Int
    
    init(item: CastMember) {
        self.id = item.id
        if let profile = item.profilePath {
            self.profile = "https://image.tmdb.org/t/p/w500" + profile
        } else {
            profile = ""
        }
        self.name = item.name ?? ""
    }
}
