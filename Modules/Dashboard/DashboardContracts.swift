//
//  DashboardContracts.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 15.08.2025.
//

// MARK: - View Protocol
protocol DashboardViewProtocol: AnyObject {
    func displayLoading()
    func bind(viewData: DashboardViewData)
    func displayError(_ errorModel: ErrorPresentationModel)
}

// MARK: - Presenter Protocol
protocol DashboardPresenterProtocol: AnyObject {
    func viewDidLoad()
    func handleRefresh()
    func settingsButtonTapped()
    func retryButtonTapped()
}

// MARK: - Interactor Protocol
protocol DashboardInteractorProtocol: AnyObject {
    var presenter: DashboardInteractorOutputProtocol? { get set }
    func fetchAuthenticatedUser()
}

// MARK: - Interactor Output Protocol
protocol DashboardInteractorOutputProtocol: AnyObject {
    func didFetchUser(user: User)
    func didFailToFetchUser(error: Error)
}
