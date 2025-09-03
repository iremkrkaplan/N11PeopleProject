//
//  DashboardViewController.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import UIKit

final class DashboardViewController: BaseScrollViewController{
    
    private let interactor: DashboardInteractorProtocol
    private lazy var profileView: ProfileView = .build()
    private lazy var galleryView: GalleryView = .build()
    private lazy var titleView: UILabel = .build()
    private lazy var subtitleView: UILabel = .build()
    private lazy var settingsActionView: UIButton = .build()
    private lazy var errorView: ErrorView = .build()
    private lazy var settingsButton: UIButton = .build()
    private lazy var galleryTitleLabel: UILabel = .build()
    private lazy var quickActionsStackView: UIStackView = .build()
    private let refreshControl = UIRefreshControl()
    private let layout: Layout = .init()
    
    private lazy var activityIndicator: UIActivityIndicatorView = .build {
        $0.style = .large
        $0.color = .systemPurple
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
        setupRefreshControl()
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
        addStateViews()
    }
    
    private func bind(_ data: DashboardViewData) {
        titleView.text = data.titleViewText
        subtitleView.text = data.subtitleViewText
        galleryTitleLabel.text = data.galleryTitleLabelText
        
        profileView.bind(data.profileModel)
        configureQuickActions(with: data.quickActionModels)
        configureSettingsAction(with: data.settingsButtonModel)
        configureGallery(with: data.galleryModel)
        showContent()
    }
    
    
    
    @MainActor
    private func fetchDataAndUpdateUI(isPullToRefresh: Bool = false) {
        Task {
            
            if isPullToRefresh {
                async let fetchTask = Task {
                    try await interactor.fetchAuthenticatedUser()
                }

                async let delayTask = Task {
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                }

                let userResult = await fetchTask.result

                _ = await delayTask.result

                switch userResult {
                case .success(let user):
                    let viewData = createViewData(from: user)
                    bind(viewData)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    showError()
                }
                
                refreshControl.endRefreshing()
            }
            else {
                showLoading()
                do {
                    let user = try await interactor.fetchAuthenticatedUser()
                    let viewData = createViewData(from: user)
                    bind(viewData)
                
                } catch {
                    print("Error: \(error.localizedDescription)")
                    showError()
                }
            }

            
            if !isPullToRefresh {
                showLoading()
            }
            
            if !isPullToRefresh {
                try await Task.sleep(nanoseconds: 2_000_000_000)
            }
            
            do {
                let user = try await interactor.fetchAuthenticatedUser()
                let viewData = createViewData(from: user)
                bind(viewData)
                
            } catch {
                print("Error: \(error.localizedDescription)")
                // TODO: Kullanıcıya allert ieklinde hata mesajı göster.
                showError()
            }
        }
    }
    
    private func showLoading() {
        scrollView.isHidden = true
        errorView.isHidden = true
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func showContent() {
        scrollView.isHidden = false
        errorView.isHidden = true
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }

    private func showError() {
        scrollView.isHidden = true
        errorView.isHidden = false
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        refreshControl.endRefreshing()
        
        let errorModel = ErrorPresentationModel.createViewData(retryAction: { [weak self] in
            self?.fetchDataAndUpdateUI()
        })
        
        errorView.bind(errorModel)
    }
}

// MARK: - Add State Views
private extension DashboardViewController {
    func addStateViews() {
        view.addSubview(errorView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

private extension DashboardViewController {
    func setupRefreshControl() {
        refreshControl.tintColor = .systemPurple

        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)

        scrollView.refreshControl = refreshControl
    }

    @objc private func handleRefresh() {
        fetchDataAndUpdateUI(isPullToRefresh: true)
    }
}

private extension DashboardViewController {
        
        private func addNavigationBar() {
            navigationItem.title = "Dashboard"
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        private func addProfile() {
            contentView.addSubview(profileView)
            NSLayoutConstraint.activate([
                profileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: layout.contentInsets.top),
                profileView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        }
        
        private func addSettingsAction() {
            contentView.addSubview(settingsButton)
            NSLayoutConstraint.activate([
                settingsButton.topAnchor.constraint(equalTo: profileView.topAnchor),
                settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -layout.contentInsets.trailing),
                settingsButton.widthAnchor.constraint(equalToConstant: layout.settingsActionSize.width),
                settingsButton.heightAnchor.constraint(equalToConstant: layout.settingsActionSize.height)
            ])
        }
        
        private func addTitle() {
            titleView.font = .systemFont(ofSize: layout.titleFontSize, weight: .bold)
            titleView.textAlignment = .center
            titleView.textColor = .systemPurple
            titleView.setContentHuggingPriority(.required, for: .vertical)
            titleView.setContentCompressionResistancePriority(.required, for: .vertical)
            contentView.addSubview(titleView)
            NSLayoutConstraint.activate([
                titleView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: layout.profileBottomSpacing),
                titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: layout.contentInsets.leading),
                titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -layout.contentInsets.trailing),
            ])
        }
        
        private func addSubtitle() {
            subtitleView.font = .systemFont(ofSize: layout.subtitleFontSize, weight: .regular)
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
            quickActionsStackView.axis = .vertical
            quickActionsStackView.spacing = layout.quickActionRowSpacing
            quickActionsStackView.alignment = .center
            
            contentView.addSubview(quickActionsStackView)
            NSLayoutConstraint.activate([
                quickActionsStackView.topAnchor.constraint(equalTo: subtitleView.bottomAnchor, constant: layout.quickActionsTopSpacing),
                quickActionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: layout.contentInsets.leading),
                quickActionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -layout.contentInsets.trailing)
            ])
        }
        
        private func addGalleryTitle() {
            galleryTitleLabel.font = .systemFont(ofSize: layout.galleryTitleFontSize, weight: .bold)
            galleryTitleLabel.textColor = .black
            contentView.addSubview(galleryTitleLabel)
            NSLayoutConstraint.activate([
                galleryTitleLabel.topAnchor.constraint(equalTo: quickActionsStackView.bottomAnchor, constant: layout.gallerySectionTopSpacing),
                galleryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: layout.galleryHorizontalPadding),
                galleryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -layout.galleryHorizontalPadding)
            ])
        }
        
        private func addGalleryView() {
            contentView.addSubview(galleryView)
            NSLayoutConstraint.activate([
                galleryView.topAnchor.constraint(equalTo: galleryTitleLabel.bottomAnchor, constant: layout.galleryTitleBottomSpacing),
                galleryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: layout.galleryHorizontalPadding),
                galleryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -layout.galleryHorizontalPadding),
                galleryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -layout.galleryBottomPadding)
            ])
        }
        
        private func configureSettingsAction(with model: SimpleActionPresentationModel) {
            var config = UIButton.Configuration.filled()
            config.background.backgroundColor = .systemPurple
            config.background.cornerRadius = layout.settingsActionSize.width / 2
            config.image = .init(systemName: model.iconName)
            settingsButton.configuration = config
            
            settingsButton.addAction(UIAction { _ in model.action() }, for: .touchUpInside)
        }
        
        private func configureQuickActions(with models: [[QuickActionButtonPresentationModel]]) {
            quickActionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            models.forEach { rowModels in
                let rowStackView = UIStackView()
                rowStackView.spacing = layout.quickActionRowSpacing
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
                    print("Ayarlar butonu tıklandı!")
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
            let contentInsets: NSDirectionalEdgeInsets = .init(
                top: 16,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
            
            let settingsActionSize: CGSize = .init(width: 40, height: 40)
            
            let profileBottomSpacing: CGFloat = 24
            let quickActionsTopSpacing: CGFloat = 30
            let quickActionRowSpacing: CGFloat = 20
            let gallerySectionTopSpacing: CGFloat = 40
            let galleryTitleBottomSpacing: CGFloat = 16
            
            let galleryHorizontalPadding: CGFloat = 20
            let galleryBottomPadding: CGFloat = 20
            
            let titleFontSize: CGFloat = 34
            let subtitleFontSize: CGFloat = 17
            let galleryTitleFontSize: CGFloat = 26
        }
    }

@available(iOS 17, *)
#Preview("Success State") {
    let interactor = DashboardAPIInteractor(apiClient: .live)
    let vc = DashboardViewController(interactor: interactor)
    return UINavigationController(rootViewController: vc)
}

@available(iOS 17, *)
#Preview("Error State") {
    let failureInteractor = DashboardMockInteractor(
        scenario: .failure(PreviewError.forcedFailure)
    )
    let vc = DashboardViewController(interactor: failureInteractor)
    UINavigationController(rootViewController: vc)
}

/*
@available(iOS 17, *)
#Preview {
    DashboardViewController(interactor: DashboardAPIInteractor(apiClient: .live))
}
*/