//
//  UserDetailContracts.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 3.09.2025.
//

import UIKit
struct UserDetailViewData {
    let profile: ProfilePresentationModel
    
    let bioText: String?
    let followersText: String
    let followingText: String
    let publicReposText: String
    let memberSinceText: String
    let githubProfileURL: URL
}

protocol ViewToPresenterUserDetailProtocol: AnyObject {
    func viewDidLoad()
    func viewOnGitHubButtonTapped()
    func favoriteButtonTapped()
}

protocol PresenterToViewUserDetailProtocol: AnyObject {
    func displayLoading(_ isLoading: Bool)
    func display(viewData: UserDetailViewData)
    func displayError(title: String, message: String)
}

protocol PresenterToInteractorUserDetailProtocol: AnyObject {
    func fetchUserDetail()
}

protocol InteractorToPresenterUserDetailProtocol: AnyObject {
    func didFetchUserDetailSuccessfully(detail: UserDetail)
    func didFailToFetchUserDetail(error: Error)
}

protocol PresenterToRouterUserDetailProtocol: AnyObject {
    func openInBrowser(url: URL)
}
