//
//  APIClientLive.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 17.08.2025.
//

import Foundation

struct GetAuthenticatedUserEndpoint: Endpoint {
    
    func urlRequest() -> URLRequest {
        let url = url(appendingPath: "/user")
        return URLRequest(url: url)
    }
}

extension Endpoint where Self == GetAuthenticatedUserEndpoint {
    static func getAuthenticatedUser() -> Self {
        .init()
    }
}

extension APIClient {
    public static let live: Self = {
        var client = Self.noop
        
        client.getAuthenticatedUser = { try await request(.getAuthenticatedUser()) }
        
        return client
    }()
}

private extension APIClient {
    
    static var githubToken: String {
        guard let token = Bundle.main.infoDictionary?["API_TOKEN"] as? String,
              !token.isEmpty else {
            fatalError("API_TOKEN not found in Info.plist. Please check your xcconfig setup.")
        }
        return token
    }
    
    static func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        var request = endpoint.urlRequest()
        
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(githubToken)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
            
        }
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(T.self, from: data)
    }
}
