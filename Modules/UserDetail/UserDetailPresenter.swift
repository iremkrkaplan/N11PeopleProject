//
//  UserDetailPresenter.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 3.09.2025.
//

import UIKit

final class UserDetailPresenter: UserDetailPresenterInput {
    
    weak var view: UserDetailViewInput?
    var interactor: UserDetailInteractorInput?
    var router: UserDetailRouterInput?
    private let favoriteService: FavoriteStorageServiceProtocol
    private var userDetail: UserDetail?
    
    init(favoriteService: FavoriteStorageServiceProtocol = FavoriteStorageService.shared) {
        self.favoriteService = favoriteService
    }
}

extension UserDetailPresenter{
    
    func didFetchUserDetailSuccessfully(detail: UserDetail) {
        self.userDetail = detail
        let viewData = createViewData(from: detail)
        view?.displayLoading()
        view?.bind(viewData: viewData)
    }
    
    func didFailToFetchUserDetail(error: Error) {
        print("Presenter'a hata ulaştı: \(error.localizedDescription)")
        
        let errorModel = ErrorPresentationModel.networkConnectionError
        
        view?.displayError(errorModel)
    }
}

extension UserDetailPresenter {
    func viewDidLoad() {
        view?.displayLoading()
        interactor?.fetchUserDetail()
    }
    
    func favoriteButtonTapped() {
        interactor?.toggleFavoriteStatus()
        guard let detail = self.userDetail else { return }
        let updatedViewData = createViewData(from: detail)
        view?.bind(viewData: updatedViewData)
    }
    
    func githubButtonTappeed() {
        guard let urlString = userDetail?.htmlUrl, let url = URL(string: urlString) else { return }
        router?.openInBrowser(url: url)
    }
    
    func didPullToRefresh() {
        interactor?.fetchUserDetail()
    }
    
    func retryButtonTapped() {
        print("Presenter, ViewController'dan gelen retry isteğini aldı.")
        viewDidLoad()
    }
}

extension UserDetailPresenter{
    private func createViewData(from detail: UserDetail) -> UserDetailViewData {
        let profileTitle = detail.name ?? detail.login
        let profileSubtitle = (detail.name != nil && !detail.name!.isEmpty) ? "@\(detail.login)" : nil
        let joinDate = detail.createdAt
        let memberSinceText = format(date: joinDate)
        
        let profileModel = ProfilePresentationModel(
            avatarModel: .init(
                url: detail.AvatarAsURL,
                placeholderImageName: "PlaceHolder",
                shape: .rectangle),
            userNameText: profileTitle,
            nameText: profileSubtitle
        )
        
        let statsModel = UserStatsPresentationModel(
            followersText: "\(detail.followers)",
            followingText: "\(detail.following)"
        )
        
        let githubButtonModel = GitHubButtonPresentationModel(
            title: "GitHub'da Görüntüle",
            url: detail.htmlAsURL,
            action: { [weak self] in
                self?.router?.openInBrowser(url: URL(string: detail.htmlUrl)!)
            }
        )
        
        return UserDetailViewData(
            profileModel: profileModel,
            bioText: detail.bio,
            statsModel: statsModel,
            memberSinceText: "Katıma tarihi: \(memberSinceText)",
            githubButtonModel: githubButtonModel,
            isFavorite: favoriteService.isFavorite(username: detail.login)
        )
    }
}


extension UserDetailPresenter{
    private func format(date: Date) -> String {
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "MMMM yyyy"
        displayFormatter.locale = Locale(identifier: "tr_TR")
        return displayFormatter.string(from: date)
    }
}
