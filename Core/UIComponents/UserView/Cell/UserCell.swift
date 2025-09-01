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
    private let layout: Layout = .init()
    
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
        contentView.layer.cornerRadius = layout.cellCornerRadius
    }
    
    private func addProfileView() {
        contentView.addSubview(profileView)
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: layout.contentInsets.top),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: layout.contentInsets.leading),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -layout.contentInsets.trailing),
            profileView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -layout.contentInsets.bottom)
        ])
    }
    
    func addFavoriteButton(){
        contentView.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.centerXAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -layout.horizontalOffset),
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: layout.verticalOffset),
            favoriteButton.widthAnchor.constraint(equalToConstant: layout.buttonSize),
            favoriteButton.heightAnchor.constraint(equalToConstant: layout.buttonSize)
        ])
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
    private struct Layout {
        let contentInsets: NSDirectionalEdgeInsets = .init(
            top: 16,
            leading: 8,
            bottom: 16,
            trailing: 8
        )
        
        let cellCornerRadius: CGFloat = 16
        let buttonSize: CGFloat = 44
        let verticalOffset: CGFloat = 17
        let horizontalOffset: CGFloat = 18
    }
}
