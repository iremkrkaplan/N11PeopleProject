//
//  DashboardMockInteractor.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 15.08.2025.
//

import Foundation

final class DashboardMockInteractor: DashboardInteractorProtocol {
    
    func fetchUser() async throws -> User {
        User(id: "id", name: "Irem ...")
    }
}
