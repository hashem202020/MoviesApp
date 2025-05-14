//
//  CrewMemberDTO.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation

public struct CrewMemberDTO: Codable {
    let id: Int
    let adult: Bool?
    let gender: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath, creditId, department, job: String?
    
    enum CodingKeys: String, CodingKey {
        case id, adult, gender, name, popularity
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case creditId = "credit_id"
        case profilePath = "profile_path"
        case department, job
        
    }
}
