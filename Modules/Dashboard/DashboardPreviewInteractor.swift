//
//  DashboardPreviewInteractor.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 22.08.2025.
//

import Foundation

enum PreviewError: Error {
    case forcedFailure
}

class DashboardFailureInteractor: DashboardInteractorProtocol {
    func fetchAuthenticatedUser() async throws -> User {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        throw PreviewError.forcedFailure
    }
}
		
