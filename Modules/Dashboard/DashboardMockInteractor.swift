//
//  DashboardMockInteractor.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 15.08.2025.
//
import Foundation

enum MockScenario {
    case success
    case failure
    case loading
    case timeout
}

final class DashboardMockInteractor: DashboardInteractorProtocol {
    
    private let scenario: MockScenario

    init(scenario: MockScenario) {
        self.scenario = scenario
    }

    func fetchAuthenticatedUser() async throws -> User {
        switch scenario {
        case .success:
            try await Task.sleep(nanoseconds: 2_000_000_000)
            let jsonData = Data(mockJsonString.utf8)
            return try JSONDecoder().decode(User.self, from: jsonData)
            
        case .failure:
            try await Task.sleep(nanoseconds: 2_000_000_000)
            throw URLError(.badServerResponse)
            
        case .loading:
            try await Task.sleep(nanoseconds: 7_000_000_000)
            let jsonData = Data(mockJsonString.utf8)
            return try JSONDecoder().decode(User.self, from: jsonData)
            
        case .timeout:
            try await Task.sleep(nanoseconds: 5_000_000_000)
            throw URLError(.timedOut)
        }
    }
    
    private var mockJsonString: String {
        """
        {
          "login": "iremkrkaplan",
          "id": 115878341,
          "avatar_url": "https://avatars.githubusercontent.com/u/115878341?v=4"
        }
        """
    }
}
