//
//  UserCell.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 29.08.2025.
//

import UIKit
import Kingfisher

final class UserCell: UICollectionViewCell {
    private lazy var profileView: ProfileView = .build()
    private lazy var favoriteButton: UIButton = .build()
    var onFavoriteButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
        configureFavoriteButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(with model: UserListCellModel) {
        let profileModel = ProfilePresentationModel(
            avatarModel: .init(
                url: model.avatarURL,
                placeholderImageName: "PlaceHolder",
                shape: .rectangle
            ),
            nameText: model.username
        )
        profileView.bind(profileModel)
        let heartImageName = model.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: heartImageName), for: .normal)
    }
}

private extension UserCell {
    private func addUI() {
        addProfileView()
        addFavoriteButton()
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = Layout.cellCornerRadius
    }
    
    private func addProfileView() {
        contentView.addSubview(profileView)
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.verticalPadding),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.horizontalPadding),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.horizontalPadding),
            profileView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.verticalPadding)
        ])
    }
    
    func addFavoriteButton(){
        contentView.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.centerXAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.horizontalOffset),
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.verticalOffset),
            favoriteButton.widthAnchor.constraint(equalToConstant: Layout.buttonSize),
            favoriteButton.heightAnchor.constraint(equalToConstant: Layout.buttonSize)])
    }
    
    private func configureFavoriteButton() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart")
        config.baseForegroundColor = .systemPink
        
        favoriteButton.configuration = config
        favoriteButton.addAction(UIAction { [weak self] _ in
            self?.onFavoriteButtonTapped?()
        }, for: .touchUpInside)
    }
}

private extension UserCell {
    struct Layout {
        static let horizontalPadding: CGFloat = 8
        static let verticalPadding: CGFloat = 16
        static let cellCornerRadius: CGFloat = 16
        static let buttonSize: CGFloat = 44
        static let verticalOffset: CGFloat = 17
        static let horizontalOffset: CGFloat = 18
    }
}
