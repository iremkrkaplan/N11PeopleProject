//
//  DashboardViewControllerRevised.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import Foundation
import UIKit

final class DashboardViewControllerRevised: BaseScrollViewController{
    
    // MARK: - UI Components
    private lazy var profileView: ProfileView = .build()
    private lazy var galleryView: GalleryView = .build()
    private lazy var titleView: UILabel = .build()
    private lazy var subtitleView: UILabel = .build()
    private lazy var settingsActionView: UIButton = .build()
    private lazy var settingsButton: UIButton = .build()
    private lazy var galleryTitleLabel: UILabel = .build()

    private let layout: Layout = .init()
    
    override func addUI() {
        super.addUI()
        addBackground()
        addNavigationBar()
        addProfile()
        addTitle()
        addSubtitle()
        //addQuickActions()
        addGallery()
        addSettingsAction()
    }
}

extension DashboardViewControllerRevised {
    private func addBackground() {
        view.backgroundColor = .systemBackground
    }
    
    private func addNavigationBar() {
        navigationItem.title = "Dashboard"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
	
    private func addProfile() {
        profileView.configure(
            image: UIImage(systemName: "person.circle.fill"),
            name: "İrem Karakaplan"
        )

        contentView.addSubview(profileView)
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: layout.contentInsets.top
            ),
            profileView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: layout.contentInsets.leading
            ),
            profileView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: layout.contentInsets.leading
            )
        ])
    }
    
    private func addTitle() {
        titleView.text = "Yönetim Paneli"
        titleView.font = .systemFont(ofSize: 34, weight: .bold)
        titleView.textAlignment = .center
        titleView.textColor = .systemPurple
        
        contentView.addSubview(titleView)
        titleView.setContentHuggingPriority(
            .required,
            for: .vertical
        )
        titleView.setContentCompressionResistancePriority(
            .required,
            for: .vertical
        )
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 24),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: layout.contentInsets.leading),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -layout.contentInsets.trailing),
        ])
    }
    
    private func addSubtitle() {
        subtitleView.text = "n11 Kültür"
        subtitleView.font = .systemFont(ofSize: 17, weight: .regular)
        subtitleView.textColor = .gray
        subtitleView.textAlignment = .center
        
        contentView.addSubview(subtitleView)
        NSLayoutConstraint.activate([
            subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            subtitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func addGallery() {
        galleryTitleLabel.text = "n11 Galeri"
        galleryTitleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        galleryTitleLabel.textColor = .black
        
        contentView.addSubview(galleryTitleLabel)
        contentView.addSubview(galleryView)
        NSLayoutConstraint.activate([
            galleryTitleLabel.topAnchor.constraint(equalTo: subtitleView.bottomAnchor, constant: 40),
            galleryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            galleryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            galleryView.topAnchor.constraint(equalTo: galleryTitleLabel.bottomAnchor, constant: 16),
            galleryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            galleryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            galleryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func addSettingsAction() {
        var configuration: UIButton.Configuration = .filled()
        configuration.background.backgroundColor = .systemPurple
        configuration.background.cornerRadius = layout.settingsActionSize.width / 2
        configuration.image = .init(systemName: "gearshape.fill")
        settingsButton.configuration = configuration
        
        contentView.addSubview(settingsButton)
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: profileView.topAnchor),
            settingsButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -layout.contentInsets.trailing
            ),
            settingsButton.widthAnchor.constraint(equalToConstant: layout.settingsActionSize.width),
            settingsButton.heightAnchor.constraint(equalToConstant: layout.settingsActionSize.height)
        ])
        
        settingsButton.addAction(
            .init(handler: { [weak self] _ in
                // TODO
            }),
            for: .touchUpInside
        )
    }
}

extension DashboardViewControllerRevised {
    private struct Layout {
        let contentInsets: NSDirectionalEdgeInsets = .init(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
        let settingsActionSize: CGSize = .init(width: 40, height: 40)
    }
}

// BaseViewController +
// BaseScrollViewController +
// Navigation bar large title -> Dashboard
// private lazy var scrollView: UIScrollView = .build()
// private lazy var contentView: UIView = .build()
//private lazy var dashBoardView: UILabel = .build() //dashboardlabel view kaldırıldı yerine large title
// AvatarView +
// GalleryView - UIImageView b stacjview
