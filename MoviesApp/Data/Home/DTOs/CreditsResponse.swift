//
//  CreditsResponse.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation

public struct CreditsResponse: Codable {
    let id: Int
    let crew: [CrewMemberDTO]
    let cast: [CastMemberDTO]
}
