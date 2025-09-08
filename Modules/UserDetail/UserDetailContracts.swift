//
//  UserDetailContracts.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 3.09.2025.
//

import UIKit

protocol UserDetailViewInput: AnyObject {
    var  output: UserDetailViewOutput? { get set }
    func displayLoading()
    func bind(viewData: UserDetailViewData)
    func displayError(_ errorModel: ErrorPresentationModel)
}

protocol UserDetailViewOutput: AnyObject {
    func viewDidLoad()
    func didPullToRefresh()
    func retryButtonTapped()
    func favoriteButtonTapped()
    func githubButtonTappeed()
}

protocol UserDetailPresenterInput: UserDetailViewOutput, UserDetailInteractorOutput {
    var view: UserDetailViewInput? { get set }
    var interactor: UserDetailInteractorInput? { get set }
    var router: UserDetailRouterInput? { get set }
}

protocol UserDetailInteractorInput: AnyObject {
    var output: UserDetailInteractorOutput? { get set }
    func fetchUserDetail()
    func toggleFavoriteStatus()
}

protocol UserDetailInteractorOutput: AnyObject {
    func didFetchUserDetailSuccessfully(detail: UserDetail)
    func didFailToFetchUserDetail(error: Error)
}

protocol UserDetailRouterInput: AnyObject {
    var viewController: UIViewController? { get set }
    func openInBrowser(url: URL)
}
