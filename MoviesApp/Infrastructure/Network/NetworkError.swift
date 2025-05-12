//
//  NetworkError.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
}
