//
//  RemoteAPI.swift
//  MoviesApp
//
//  Created by Khaled hashem on 12/05/2025.
//

import Foundation

public protocol RemoteAPI {
    func request<T: Codable>(endPoint: String, method: HTTPMethod, parameters: [String: Any]?) async throws -> T
}

extension RemoteAPI {
    public func request<T: Decodable>(
        endPoint: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil
    ) async throws -> T {
        
        guard let baseUrlString = Bundle.main.infoDictionary?[NetworkConstants.apiBaseURL] as? String,
              var urlComponents = URLComponents(string: baseUrlString + endPoint) else {
            throw NetworkError.invalidURL
        }
        
        // Add the API key to the query param
        var queryItems = [URLQueryItem(name: "api_key", value: Bundle.main.infoDictionary?[NetworkConstants.ApiKey] as? String)]
        
        // Add additional parameters (for GET or any query case)
        if let parameters = parameters {
            queryItems += parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // For non-GET methods, send parameters in the body (excluding query params)
        if method != .get, let parameters = parameters {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            throw NetworkError.decodingFailed(decodingError)
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
