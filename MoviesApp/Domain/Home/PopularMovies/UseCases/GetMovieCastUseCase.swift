//
//  GetMovieCastUseCase.swift
//  MoviesApp
//
//  Created by Khaled hashem on 13/05/2025.
//

import Foundation
public protocol GetMovieCastUseCase {
    func execute(with id: Int) async throws -> [CastMember]
}

final public class DefaultGetMovieCastUseCase: GetMovieCastUseCase {
    // MARK: - Properties
    let movieDetailsRepository: MovieDetailsRepository
    
    // MARK: - Methods
    init(movieDetailsRepository: MovieDetailsRepository) {
        self.movieDetailsRepository = movieDetailsRepository
    }
    
    public func execute(with id: Int) async throws -> [CastMember] {
        try await movieDetailsRepository.getCast(for: id)
    }
}
