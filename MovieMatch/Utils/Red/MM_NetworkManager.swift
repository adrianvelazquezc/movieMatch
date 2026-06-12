//
//  MM_NetworkManager.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

//
//  MM_NetworkManager.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case serializationError
    case serverError(String)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
}

class MM_NetworkManager {
    let initialPath = "https://api.themoviedb.org/3/"
    let apiKey = "e142ca6d5b52024931683472e1abbef2"
    let imagePath = "https://image.tmdb.org/t/p/w500"
    
    var requestToken = ""
    var sessionId = ""
    var username = ""

    init() {}

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let fullURLString = "\(initialPath)\(endpoint.path)"
        
        guard var components = URLComponents(string: fullURLString) else {
            throw NetworkError.invalidURL
        }
        
        var queryItems = endpoint.queryItems ?? []
        queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.noData
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.serializationError
        }
    }
}
