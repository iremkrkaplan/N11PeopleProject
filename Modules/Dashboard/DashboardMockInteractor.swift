//
//  DashboardMockInteractor.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 15.08.2025.
//
import Foundation

enum MockScenario {
    case success(User)
    case failure(Error)
}

final class DashboardMockInteractor: DashboardInteractorInput{
    weak var presenter: (any DashboardInteractorOutput)?
    private let scenario: MockScenario
    private let delayInSeconds: UInt64
    
    init(scenario: MockScenario, delayInSeconds: UInt64 = 1) {
        self.scenario = scenario
        self.delayInSeconds = delayInSeconds
    }
    
    func fetchAuthenticatedUser() {
        Task {
            try? await Task.sleep(nanoseconds: delayInSeconds * 1_000_000_000)
            await MainActor.run {
                switch self.scenario {
                case .success(let user):
                    self.presenter?.didFetchUser(user: user)
                case .failure(let error):
                    self.presenter?.didFailToFetchUser(error: error)
                }
            }
        }
    }
    static var mockUser: User {
        let json = """
        {
          "login": "iremkrkaplan",
          "id": 115878341,
          "avatar_url": "https://avatars.githubusercontent.com/u/115878341?v=4"
        }
        """
        let data = Data(json.utf8)
        return try! JSONDecoder().decode(User.self, from: data)
    }
}

enum PreviewError: Error {
    case forcedFailure
}