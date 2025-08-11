//
//  DashboardViewControllerRevised.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import Foundation
import UIKit

// BaseViewController +
// BaseScrollViewController +
// Navigation bar large title -> Dashboard
//    private lazy var scrollView: UIScrollView = .build()
//    private lazy var contentView: UIView = .build()

// AvatarView
// GalleryView - UIImageView

final class DashboardViewControllerRevised: BaseScrollViewController<AnyObject> {

    // MARK: - UI Components
    private lazy var titleView: UILabel = .build()
    private lazy var cardView: UIView = .build()
    private lazy var dashBoardView: UILabel = .build() //dashboardlabel view
    private lazy var settingsActionView: UIButton = .build()
    private lazy var profileView: UIView = .build()
    private lazy var settingsButton: UIButton = .build()
    private lazy var galleryView: UIView = .build()
    private lazy var icons: [UIView] = []
    private lazy var galleryTitleLabel: UILabel = .build()
    private lazy var AvatarView: UIImageView = .build()
    private lazy var nameLabel: UILabel = .build()
    private let layout: Layout = .init()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        //addUI()
    }
    
    // MARK: - Setup UI
    override func setupUI() {
        super.setupUI()
        configureComponents()
        addUI()
    }
    
    // MARK: - Component Configuration
    private func configureComponents(){
        dashBoardView.text = "Dashboard"
        dashBoardView.font = .systemFont(ofSize: 34, weight: .bold)
        dashBoardView.textColor = .white
        
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 40
        
        let buttonSize: CGFloat = 40
        settingsButton.layer.cornerRadius = buttonSize / 2
        settingsButton.backgroundColor = .systemPurple
        settingsButton.tintColor = .white
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        settingsButton.setImage(UIImage(systemName: "gearshape.fill", withConfiguration: config), for: .normal)
        
        AvatarView.image = UIImage(systemName: "person.circle.fill")
        AvatarView.tintColor = .systemPink
        AvatarView.contentMode = .scaleAspectFit
        
        nameLabel.text = "İrem Karakaplan"
        nameLabel.font = .systemFont(ofSize: 17, weight: .medium)
        
        let titleLabel: UILabel = .build {
            $0.text = "Yönetim Paneli"
            $0.font = .systemFont(ofSize: 34, weight: .bold)
            $0.textAlignment = .center
            $0.textColor = .systemPurple
        }
        let subtitleLabel: UILabel = .build {
            $0.text = "n11 Kültür"
            $0.font = .systemFont(ofSize: 17, weight: .regular)
            $0.textColor = .gray
            $0.textAlignment = .center
        }
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor)
        ])
        
        icons.append(makeIconView(iconName: "magnifyingglass", text: "Kayıt Sorgulama", color: .systemPink))
        icons.append(makeIconView(iconName: "heart.fill", text: "Favorilediklerim", color: .systemPurple))
        icons.append(makeIconView(iconName: "eye.fill", text: "Görüntülediklerim", color: .systemPink))
        icons.append(makeIconView(iconName: "person.2.fill", text: "Arkadaşlarım", color: .systemPurple))
        icons.append(makeIconView(iconName: "birthday.cake.fill", text: "Bu Ay Doğanlar", color: .systemPink))
        
        galleryTitleLabel.text = "n11 Galeri"
        galleryTitleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        galleryTitleLabel.textColor = .black
        let galleryItems = [
            makeGalleryItemView(), makeGalleryItemView(),
            makeGalleryItemView(), makeGalleryItemView(),
            makeGalleryItemView(), makeGalleryItemView()
        ]
        
        for item in galleryItems {
            galleryView.addSubview(item)
        }
        
        let itemSpacing: CGFloat = 16
        let itemHeight: CGFloat = 120
        
        NSLayoutConstraint.activate([
            galleryItems[0].topAnchor.constraint(equalTo: galleryView.topAnchor),
            galleryItems[0].leadingAnchor.constraint(equalTo: galleryView.leadingAnchor),
            galleryItems[0].widthAnchor.constraint(equalTo: galleryView.widthAnchor, multiplier: 0.5, constant: -itemSpacing/2),
            galleryItems[0].heightAnchor.constraint(equalToConstant: itemHeight),

            galleryItems[1].topAnchor.constraint(equalTo: galleryItems[0].topAnchor),
            galleryItems[1].leadingAnchor.constraint(equalTo: galleryItems[0].trailingAnchor, constant: itemSpacing),
            galleryItems[1].widthAnchor.constraint(equalTo: galleryItems[0].widthAnchor),
            galleryItems[1].heightAnchor.constraint(equalToConstant: itemHeight),
            
            galleryItems[2].topAnchor.constraint(equalTo: galleryItems[0].bottomAnchor, constant: itemSpacing),
            galleryItems[2].leadingAnchor.constraint(equalTo: galleryView.leadingAnchor),
            galleryItems[2].widthAnchor.constraint(equalTo: galleryItems[0].widthAnchor),
            galleryItems[2].heightAnchor.constraint(equalToConstant: itemHeight),

            galleryItems[3].topAnchor.constraint(equalTo: galleryItems[2].topAnchor),
            galleryItems[3].leadingAnchor.constraint(equalTo: galleryItems[2].trailingAnchor, constant: itemSpacing),
            galleryItems[3].widthAnchor.constraint(equalTo: galleryItems[0].widthAnchor),
            galleryItems[3].heightAnchor.constraint(equalToConstant: itemHeight),
            
            galleryItems[4].topAnchor.constraint(equalTo: galleryItems[2].bottomAnchor, constant: itemSpacing),
            galleryItems[4].leadingAnchor.constraint(equalTo: galleryView.leadingAnchor),
            galleryItems[4].widthAnchor.constraint(equalTo: galleryItems[0].widthAnchor),
            galleryItems[4].heightAnchor.constraint(equalToConstant: itemHeight),

            galleryItems[5].topAnchor.constraint(equalTo: galleryItems[4].topAnchor),
            galleryItems[5].leadingAnchor.constraint(equalTo: galleryItems[4].trailingAnchor, constant: itemSpacing),
            galleryItems[5].widthAnchor.constraint(equalTo: galleryItems[0].widthAnchor),
            galleryItems[5].heightAnchor.constraint(equalToConstant: itemHeight),
            galleryView.bottomAnchor.constraint(equalTo: galleryItems[5].bottomAnchor)
        ])
    }
    
    // MARK: - Helper Functions
    private func makeIconView(iconName: String, text: String, color: UIColor) -> UIView {
        let view: UIView = .build()
        
        let iconImageView: UIImageView = .build {
            let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
            $0.image = UIImage(systemName: iconName, withConfiguration: config)
            $0.tintColor = .white
            $0.backgroundColor = color.withAlphaComponent(0.8)
            $0.contentMode = .center
            $0.layer.cornerRadius = 30
        }

        let label: UILabel = .build {
            $0.text = text
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .darkGray
            $0.textAlignment = .center
        }

        view.addSubview(iconImageView)
        view.addSubview(label)

        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: view.topAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            
            label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }
    
    private func makeGalleryItemView() -> UIView {
        let view: UIView = .build {
            $0.backgroundColor = .systemGray6
            $0.layer.cornerRadius = 15
        }

        let ladybugImageView: UIImageView = .build {
            $0.image = UIImage(systemName: "ladybug.fill")
            $0.tintColor = .systemPurple
            $0.contentMode = .scaleAspectFit
        }

        view.addSubview(ladybugImageView)
        
        NSLayoutConstraint.activate([
            ladybugImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ladybugImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ladybugImageView.widthAnchor.constraint(equalToConstant: 60),
            ladybugImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        return view
    }
    
    private func didTapSettingsButton() {
        print("Ayarlar butonu tıklandı!")
        //TODO: Implement the method
    }
}


extension DashboardViewControllerRevised {
    private func addUI() {
        contentView.addSubview(dashBoardView)
        contentView.addSubview(cardView)
        
        cardView.addSubview(profileView)
        cardView.addSubview(titleView)
        
        profileView.addSubview(AvatarView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(settingsButton)
        
        for icon in icons {
            cardView.addSubview(icon)
        }
        
        cardView.addSubview(galleryTitleLabel)
        cardView.addSubview(galleryView)
        
        addScroll()
    }
    
    private func addScroll() {
        addSettingsAction()
    }
    
    private func addSettingsAction() {
        /// .configuration
        /// UIButton.Configuration
        /// action
        settingsButton.addAction(
            .init(handler: { [weak self] _ in
                self?.didTapSettingsButton()
            }),
            for: .touchUpInside
        )
        setupConstraints()
    }

/*
    private func addSettingsAction() {
        /// .configuration
        /// UIButton.Configuration
        
        var configuration = UIButton.Configuration.filled(UIColor)
        /// layout
        scrollView.addSubview(settingsActionView)
        NSLayoutConstraint.activate([])
        
        /// action
        settingsActionView.addAction(
            .init(handler: { _ in
            
            }),
            for: .touchUpInside
        )
    }
    */
}
extension DashboardViewControllerRevised {
    private struct Layout {
        // CGFloat
        // CGSize
        // NSDirectionalEdgeInsets
    }
    private func setupConstraints() {
        let padding: CGFloat = 16
        let cardPadding: CGFloat = 20
        let iconSpacing: CGFloat = 25
        
        NSLayoutConstraint.activate([
            dashBoardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dashBoardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),

            cardView.topAnchor.constraint(equalTo: dashBoardView.bottomAnchor, constant: 20),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            profileView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: cardPadding),
            profileView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: cardPadding),
            profileView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -cardPadding),
            
            AvatarView.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            AvatarView.topAnchor.constraint(equalTo: profileView.topAnchor),
            AvatarView.widthAnchor.constraint(equalToConstant: 70),
            AvatarView.heightAnchor.constraint(equalToConstant: 70),
            nameLabel.topAnchor.constraint(equalTo: AvatarView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: profileView.bottomAnchor),

            settingsButton.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            
            titleView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 25),
            titleView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: cardPadding),
            titleView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -cardPadding),

            icons[0].topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: iconSpacing),
            icons[0].leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: cardPadding),
            icons[1].topAnchor.constraint(equalTo: icons[0].topAnchor),
            icons[1].centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            icons[2].topAnchor.constraint(equalTo: icons[0].topAnchor),
            icons[2].trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -cardPadding),

            icons[3].topAnchor.constraint(equalTo: icons[0].bottomAnchor, constant: iconSpacing),
            icons[3].leadingAnchor.constraint(equalTo: cardView.centerXAnchor, constant: -80),
            icons[4].topAnchor.constraint(equalTo: icons[3].topAnchor),
            icons[4].leadingAnchor.constraint(equalTo: cardView.centerXAnchor, constant: 10),
            
            galleryTitleLabel.topAnchor.constraint(equalTo: icons[3].bottomAnchor, constant: 40),
            galleryTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: cardPadding),
            galleryTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -cardPadding),
            
            galleryView.topAnchor.constraint(equalTo: galleryTitleLabel.bottomAnchor, constant: 16),
            galleryView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: cardPadding),
            galleryView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -cardPadding),
            galleryView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -cardPadding)
        ])
    }
}
