//
//  APIClientLive.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 17.08.2025.
//

import Foundation

struct GetUserEndpoint: Endpoint {
    private let params: GetUserParams
    
    init(params: GetUserParams) {
        self.params = params
    }
    
    func urlRequest() -> URLRequest {
        let url = url(appendingPath: "/users/\(params.username)")
        return URLRequest(url: url)
    }
}

extension Endpoint where Self == GetUserEndpoint {
    static func getUser(params: GetUserParams) -> Self {
        .init(params: params)
    }
}

extension APIClient {
    static let live: Self = {
        var client = Self.noop
        
        client.getUser = { params in
            try await request(.getUser(params: params))
        }
        
        return client
    }()
}

private extension APIClient {
    static func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        var request = endpoint.urlRequest()
        
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(T.self, from: data)
    }
}
