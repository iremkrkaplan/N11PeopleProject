//
//  DashboardMockInteractor.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 15.08.2025.
//
import Foundation

final class DashboardMockInteractor: DashboardInteractorProtocol {
    func fetchAuthenticatedUser() async throws -> User {
        struct Err: Error {}
        throw Err()
//        let mockJsonString = """
//        {
//          "login": "iremkrkaplan",
//          "id": 115878341,
//          "avatar_url": "https://avatars.githubusercontent.com/u/115878341?v=4"
//        }
//        """
//        let jsonData = Data(mockJsonString.utf8)
//        let user = try JSONDecoder().decode(User.self, from: jsonData)
//        return user
    }
}
