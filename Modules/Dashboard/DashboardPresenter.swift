//
//  DashboardPresenter.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 25.08.2025.
//

import Foundation

final class DashboardPresenter {
    private weak var view: DashboardViewProtocol?
    private var interactor: DashboardInteractorProtocol

    init(view: DashboardViewProtocol, interactor: DashboardInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.interactor.presenter = self
    }
}

extension DashboardPresenter: DashboardInteractorOutputProtocol {
    func didFetchUser(user: User) {
        let viewData = createViewData(from: user)
        view?.bind(viewData: viewData)
    }
    
    func didFailToFetchUser(error: Error) {
        print("Presenter'a hata ulaştı: \(error.localizedDescription)")
        let errorModel = ErrorPresentationModel.createViewData { [weak self] in
            self?.viewDidLoad()
        }
        view?.displayError(errorModel)
    }
}

extension DashboardPresenter: DashboardPresenterProtocol {
    func viewDidLoad() {
        view?.displayLoading()
        interactor.fetchAuthenticatedUser()
    }

    func handleRefresh() {
        interactor.fetchAuthenticatedUser()
    }
    
    func settingsButtonTapped() {
        print("Ayarlar butonu tıklandı! Bu istek Presenter'a geldi.")
    }
}

private extension DashboardPresenter {
    
    func createViewData(from user: User) -> DashboardViewData {
        return .init(
            titleViewText: "Yönetim Paneli",
            subtitleViewText: "n11 Kültür",
            galleryTitleLabelText: "n11 Galeri",
            profileModel: .init(
                avatarModel: .init(
                    url: user.AvatarAsURL,
                    placeholderImage: "PlaceHolder",
                    shape: .circle
                ),
                nameText: user.login
            ),
            quickActionModels: createPlaceholderQuickActionModels(),
            settingsButtonModel: createPlaceholderSettingsButtonModel(),
            galleryModel: createPlaceholderGalleryModel()
        )
    }
    
    func createPlaceholderSettingsButtonModel() -> SimpleActionPresentationModel {
        return .init(
            iconName: "gearshape.fill",
            action: { [weak self] in
                guard let self = self else {
                    return
                }
                self.settingsButtonTapped()
                // TODO: `self?.presenter.navigateToSettings()` olacak.
            }
        )
    }
    
    func createPlaceholderQuickActionModels() -> [[QuickActionButtonPresentationModel]] {
        return [
            [
                .init(
                    title: "Kayıt Sorgulama",
                    iconName: "magnifyingglass",
                    color: .systemPink
                ) {
                    print("Kayıt Sorgulama tıklandı")
                },
                .init(
                    title: "Favorilediklerim",
                    iconName: "heart.fill",
                    color: .systemPurple
                ) {
                    print("Favorilediklerim tıklandı")
                },
                .init(
                    title: "Görüntülediklerim",
                    iconName: "eye.fill",
                    color: .systemPink
                ) {
                    print("Görüntülediklerim tıklandı")
                }
            ],
            [
                .init(
                    title: "Arkadaşlarım",
                    iconName: "person.badge.plus",
                    color: .systemPurple
                ) {
                    print("Arkadaşlarım tıklandı")
                },
                .init(
                    title: "Bu Ay Doğanlar",
                    iconName: "gift.fill",
                    color: .systemPink
                ) {
                    print("Bu Ay Doğanlar tıklandı")
                }
            ]
        ]
    }
    
    func createPlaceholderGalleryModel() -> GalleryPresentationModel {
        let placeholderItemCount = 6
        let placeholderItem = GalleryItemPresentationModel(
            imageSystemName: "ladybug.fill",
            tintColor: .systemGray4
        )
        let allItems = Array<GalleryItemPresentationModel>(repeating: placeholderItem, count: placeholderItemCount)
        return GalleryPresentationModel(items: allItems)
    }
}
