//
//  DashboardContracts.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 15.08.2025.
//
import UIKit
// MARK: - View Protocol
protocol DashboardViewInput: AnyObject {
    func displayLoading()
    func bind(viewData: DashboardViewData)
    func displayError(_ errorModel: ErrorPresentationModel)
}

protocol DashboardViewOutput: AnyObject {
    func viewDidLoad()
    func didPullToRefresh()
    func settingsButtonTapped()
    func retryButtonTapped()
}

// MARK: - Presenter Protocol
protocol DashboardPresenterInput: DashboardViewOutput, DashboardInteractorOutput {}

// MARK: - Interactor Protocol
protocol DashboardInteractorInput: AnyObject {
    var  presenter: DashboardInteractorOutput? { get set }
    func fetchAuthenticatedUser()
}

// MARK: - Interactor Output Protocol
protocol DashboardInteractorOutput: AnyObject {
    func didFetchUser(user: User)
    func didFailToFetchUser(error: Error)
}
