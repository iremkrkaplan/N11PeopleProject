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
}

final class DashboardMockInteractor: DashboardInteractorProtocol {
    private let scenario: MockScenario

    init(scenario: MockScenario) {
        self.scenario = scenario
    }
    
    func fetchAuthenticatedUser() async throws -> User {
        try await Task.sleep(nanoseconds: 4_000_000_000)
        
        switch scenario{
        case .success:
            let jsonData = Data(mockSuccessJson.utf8)
            return try JSONDecoder().decode(User.self, from: jsonData)
            
        case .failure:
            let jsonData = Data(mockMalformedJson.utf8)
            return try JSONDecoder().decode(User.self, from: jsonData)
            
        case .loading:
            let jsonData = Data(mockSuccessJson.utf8)
            return try JSONDecoder().decode(User.self, from: jsonData)
        }
    }
    
    private var mockSuccessJson: String {
        """
        {
          "login": "iremkrkaplan",
          "id": 115878341,
          "avatar_url": "https://avatars.githubusercontent.com/u/115878341?v=4"
        }
        """
    }

    private var mockMalformedJson: String {
        """
        {
          "login": "iremkrkaplan",
          "id": "115878341",
          "avatar_url": "https://avatars.githubusercontent.com/u/115878341?v=4"
        }
        """
    }
}
