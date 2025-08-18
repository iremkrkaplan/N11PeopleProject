//
//  DashboardViewController.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import Foundation
import UIKit

final class DashboardViewController: BaseScrollViewController{
    
//    private let interactor: any DashboardInteractorProtocol
    private let interactor: DashboardInteractorProtocol
    private lazy var profileView: ProfileView = .build()
    private lazy var galleryView: GalleryView = .build()
    private lazy var titleView: UILabel = .build()
    private lazy var subtitleView: UILabel = .build()
    private lazy var settingsActionView: UIButton = .build()
    private lazy var settingsButton: UIButton = .build()
    private lazy var galleryTitleLabel: UILabel = .build()
    private lazy var quickActionsStackView: UIStackView = .build {
        $0.axis = .vertical
        $0.spacing = Layout.quickActionRowSpacing
        $0.alignment = .center
    }
    
    init(interactor: any DashboardInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataAndUpdateUI()
    }
    
    override func addUI() {
        super.addUI()
        addNavigationBar()
        addProfile()
        addTitle()
        addSubtitle()
        addQuickActions()
        addGalleryTitle()
        addGalleryView()
        addSettingsAction()
    }
    
    @MainActor
    func bind(_ data: DashboardViewData) {
        titleView.text = data.titleViewText
        subtitleView.text = data.subtitleViewText
        galleryTitleLabel.text = data.galleryTitleLabelText
        
        profileView.bind(data.profileModel)
        configureQuickActions(with: data.quickActionModels)
        configureSettingsAction(with: data.settingsButtonModel)
        configureGallery(with: data.galleryModel)
    }
    
    // MARK: - Data Fetching
    private func fetchDataAndUpdateUI() {
        Task {
            do {
                let user = try await interactor.fetchUser(username: "iremkrkaplan")
                let viewData = createViewData(from: user)
                bind(viewData)
                
            } catch {
                print("Hata oluştu: \(error.localizedDescription)")
                // TODO: Kullanıcıya allert ieklinde hata mesajı göster.
            }
        }
    }
}

extension DashboardViewController {
    
    private func addNavigationBar() {
        navigationItem.title = "Dashboard"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addProfile() {
        contentView.addSubview(profileView)
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.contentInsets.top),
            profileView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    private func addSettingsAction() {
        contentView.addSubview(settingsButton)
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: profileView.topAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.contentInsets.trailing),
            settingsButton.widthAnchor.constraint(equalToConstant: Layout.settingsActionSize.width),
            settingsButton.heightAnchor.constraint(equalToConstant: Layout.settingsActionSize.height)
        ])
    }
    
    private func addTitle() {
        titleView.font = .systemFont(ofSize: Layout.titleFontSize, weight: .bold)
        titleView.textAlignment = .center
        titleView.textColor = .systemPurple
        titleView.setContentHuggingPriority(.required, for: .vertical)
        titleView.setContentCompressionResistancePriority(.required, for: .vertical)
        contentView.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: Layout.profileBottomSpacing),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.contentInsets.leading),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.contentInsets.trailing),
        ])
    }

    private func addSubtitle() {
        subtitleView.font = .systemFont(ofSize: Layout.subtitleFontSize, weight: .regular)
        subtitleView.textColor = .gray
        subtitleView.textAlignment = .center
        contentView.addSubview(subtitleView)
        NSLayoutConstraint.activate([
            subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            subtitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func addQuickActions() {
        contentView.addSubview(quickActionsStackView)
        NSLayoutConstraint.activate([
            quickActionsStackView.topAnchor.constraint(equalTo: subtitleView.bottomAnchor, constant: Layout.quickActionsTopSpacing),
            quickActionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.contentInsets.leading),
            quickActionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.contentInsets.trailing)
        ])
    }
    
    private func addGalleryTitle() {
        galleryTitleLabel.font = .systemFont(ofSize: Layout.galleryTitleFontSize, weight: .bold)
        galleryTitleLabel.textColor = .black
        contentView.addSubview(galleryTitleLabel)
        NSLayoutConstraint.activate([
            galleryTitleLabel.topAnchor.constraint(equalTo: quickActionsStackView.bottomAnchor, constant: Layout.gallerySectionTopSpacing),
            galleryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.galleryHorizontalPadding),
            galleryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.galleryHorizontalPadding)
        ])
    }

    private func addGalleryView() {
        contentView.addSubview(galleryView)
        NSLayoutConstraint.activate([
            galleryView.topAnchor.constraint(equalTo: galleryTitleLabel.bottomAnchor, constant: Layout.galleryTitleBottomSpacing),
            galleryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.galleryHorizontalPadding),
            galleryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.galleryHorizontalPadding),
            galleryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.galleryBottomPadding)
        ])
    }
        
    private func configureSettingsAction(with model: SimpleActionPresentationModel) {
           var config = UIButton.Configuration.filled()
           config.background.backgroundColor = .systemPurple
           config.background.cornerRadius = Layout.settingsActionSize.width / 2
           config.image = .init(systemName: model.iconName)
           settingsButton.configuration = config
           
           settingsButton.addAction(UIAction { _ in model.action() }, for: .touchUpInside)
       }
       
    private func configureQuickActions(with models: [[QuickActionButtonPresentationModel]]) {
           quickActionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
           
           models.forEach { rowModels in
               let rowStackView = UIStackView()
               rowStackView.spacing = Layout.quickActionRowSpacing
               rowStackView.distribution = .fillEqually
               
               rowModels.forEach { model in
                   let button = QuickActionButton()
                   button.bind(with: model)
                   rowStackView.addArrangedSubview(button)
               }
               quickActionsStackView.addArrangedSubview(rowStackView)
           }
       }

    private func configureGallery(with model: GalleryPresentationModel?) {
           let finalModel = model ?? createPlaceholderGalleryModel()
           galleryView.isHidden = false
           galleryView.bind(with: finalModel)
       }
}

//Data Factory TODO: Move to presenter
private extension DashboardViewController {
    
    func createViewData(from user: User) -> DashboardViewData {
        return .init(
            titleViewText: "Yönetim Paneli",
            subtitleViewText: "n11 Kültür",
            galleryTitleLabelText: "n11 Galeri",
            profileModel: .init(
                avatarModel: .init(
                    url: user.avatarUrl,
                    placeholderImage: UIImage(systemName: "person.circle.fill"),
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
            action: {
                print("Ayarlar butonu tıklandı! Navigasyon olmalı.")
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
         let allItems = Array(repeating: placeholderItem, count: placeholderItemCount)
         return GalleryPresentationModel(items: allItems)
     }
 }

extension DashboardViewController {
    private struct Layout {
        static let contentInsets: NSDirectionalEdgeInsets = .init(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
        
        static let settingsActionSize: CGSize = .init(width: 40, height: 40)
        
        static let profileBottomSpacing: CGFloat = 24
        static let quickActionsTopSpacing: CGFloat = 30
        static let quickActionRowSpacing: CGFloat = 20
        static let gallerySectionTopSpacing: CGFloat = 40
        static let galleryTitleBottomSpacing: CGFloat = 16

        static let galleryHorizontalPadding: CGFloat = 20
        static let galleryBottomPadding: CGFloat = 20
        
        static let titleFontSize: CGFloat = 34
        static let subtitleFontSize: CGFloat = 17
        static let galleryTitleFontSize: CGFloat = 26
    }
}

