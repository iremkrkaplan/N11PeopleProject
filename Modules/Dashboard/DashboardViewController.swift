//
//  DashboardViewController.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import UIKit

// Static dispatch
// Dynamic dispatch
final class DashboardViewController: UIViewController {

    // MARK: - UI Elements (Lazy initialization)

    private lazy var scrollView: UIScrollView = UIScrollView()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
//1
    private lazy var dashboardLabel: UILabel = {
        let label = UILabel()
        label.text = "Dashboard"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var dashboardLabel2: UILabel = .init()

    //1
    private lazy var whiteCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        view.layer.cornerRadius = 30
        return view
    }()
    
    // MARK: - Main Stack (inside the white card)
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            profileStackView,
            titleStackView,
            iconsRow1StackView,
            iconsRow2StackView,
            galleryTitleLabel,
            galleryGridStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 25
        return stackView
    }()
    
    // MARK: - Profile Section

    private lazy var profileStackView: UIView = {
        let container = UIView()

        let profileImageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        profileImageView.tintColor = .purple
        profileImageView.contentMode = .scaleAspectFit
        
        let nameLabel = UILabel()
        nameLabel.text = "İrem Karakaplan"
        nameLabel.font = .systemFont(ofSize: 17, weight: .medium)
        
        let profileInfoVStack = UIStackView(arrangedSubviews: [profileImageView, nameLabel])
        profileInfoVStack.axis = .vertical
        profileInfoVStack.spacing = 8
        profileInfoVStack.alignment = .center
        container.addSubview(profileInfoVStack)
        container.addSubview(settingsButton)
        
        profileInfoVStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileInfoVStack.topAnchor.constraint(equalTo: container.topAnchor),
            profileInfoVStack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            profileInfoVStack.centerXAnchor.constraint(equalTo: container.centerXAnchor),

            settingsButton.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            settingsButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),

            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70)
        ])

        return container
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        button.setImage(UIImage(systemName: "gearshape.fill", withConfiguration: config), for: .normal)
        button.backgroundColor = UIColor.purple
        button.tintColor = .white

        let buttonSize: CGFloat = 40
        button.layer.cornerRadius = buttonSize / 2
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: buttonSize),
            button.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
        return button
    }()

    // MARK: - Title Section
    
    private lazy var titleStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.text = "Yönetim Paneli"
        titleLabel.font = .systemFont(ofSize: 34, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.purple
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "n11 Kültür"
        subtitleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    // MARK: - Icons Section

    private lazy var iconsRow1StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            makeIconView(iconName: "magnifyingglass", text: "Kayıt Sorgulama", color: .systemPink),
            makeIconView(iconName: "heart.fill", text: "Favorilediklerim", color: .systemPurple),
            makeIconView(iconName: "eye.fill", text: "Görüntülediklerim", color: .systemPink)
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var iconsRow2StackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            makeIconView(iconName: "person.2.fill", text: "Arkadaşlarım", color: .systemPurple),
            makeIconView(iconName: "birthday.cake.fill", text: "Bu Ay Doğanlar", color: .systemPink)
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        let leadingSpacer = UIView()
        let trailingSpacer = UIView()
        stackView.insertArrangedSubview(leadingSpacer, at: 0)
        stackView.addArrangedSubview(trailingSpacer)
        
        NSLayoutConstraint.activate([
            leadingSpacer.widthAnchor.constraint(equalTo: trailingSpacer.widthAnchor)
        ])
        return stackView
    }()
    
    // MARK: - Gallery Section
    
    private lazy var galleryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "n11 Galeri"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.4, alpha: 1.0)
        return label
    }()
    
    private lazy var galleryGridStackView: UIStackView = {
        let row1 = UIStackView(arrangedSubviews: [makeGalleryItemView(), makeGalleryItemView()])
        row1.axis = .horizontal
        row1.spacing = 16
        row1.distribution = .fillEqually
        
        let row2 = UIStackView(arrangedSubviews: [makeGalleryItemView(), makeGalleryItemView()])
        row2.axis = .horizontal
        row2.spacing = 16
        row2.distribution = .fillEqually
        
        let row3 = UIStackView(arrangedSubviews: [makeGalleryItemView(), makeGalleryItemView()])
        row3.axis = .horizontal
        row3.spacing = 16
        row3.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [row1, row2, row3])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        setupLayout()
    }
    
    // MARK: - Layout Setup

    private func setupLayout() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            
        ])

        activateLayout(contentView, in: scrollView, with: [
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        activateLayout(dashboardLabel, in: contentView, with: [
            dashboardLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dashboardLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        activateLayout(whiteCardView, in: contentView, with: [
            whiteCardView.topAnchor.constraint(equalTo: dashboardLabel.bottomAnchor, constant: 20),
            whiteCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            whiteCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            whiteCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        activateLayout(mainStackView, in: whiteCardView, with: [
            mainStackView.topAnchor.constraint(equalTo: whiteCardView.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: whiteCardView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: whiteCardView.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: whiteCardView.bottomAnchor, constant: -20)
        ])
    }

    private func makeIconView(iconName: String, text: String, color: UIColor) -> UIView {
        let iconImageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        iconImageView.image = UIImage(systemName: iconName, withConfiguration: config)
        iconImageView.tintColor = .white
        iconImageView.backgroundColor = color.withAlphaComponent(0.8)
        iconImageView.contentMode = .center
        iconImageView.layer.cornerRadius = 30
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60)
        ])

        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, label])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        
        return stackView
    }
    
    private func makeGalleryItemView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        
        let ladybugImageView = UIImageView()
        ladybugImageView.image = UIImage(systemName: "ladybug.fill")
        ladybugImageView.tintColor = .systemPurple
        ladybugImageView.contentMode = .scaleAspectFit
        
        activateLayout(ladybugImageView, in: view, with: [
            ladybugImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ladybugImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ladybugImageView.widthAnchor.constraint(equalToConstant: 60),
            ladybugImageView.heightAnchor.constraint(equalToConstant: 60)
        ])

        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        return view
    }
    
    private func activateLayout(_ viewComponent: UIView, in parentView: UIView, with constraints: [NSLayoutConstraint]) {
//        viewComponent.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(viewComponent)
        NSLayoutConstraint.activate(constraints)
    }
}
