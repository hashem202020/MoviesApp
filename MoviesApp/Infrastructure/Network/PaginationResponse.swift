//
//  PaginationResponse.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import Foundation

public struct PaginationResponse<T: Codable>: Codable {

    // MARK: - Properties

    let results: [T]?
    let page: Int?
    let errorMessage: String?
    let totalPages: Int?
    let totalResults: Int?
}
