//
//  DashboardContracts.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 15.08.2025.
//

import Foundation

struct User {
    let id: String
    let name: String?
}

protocol DashboardInteractorProtocol: AnyObject {
    func fetchUser() async throws -> User
}
