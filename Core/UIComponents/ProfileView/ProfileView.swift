//
//  ProfileView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 11.08.2025.
//
import UIKit

final class ProfileView: UIView {
    
    private lazy var avatarView: AvatarView = .build()
    private lazy var nameView: UILabel = .build()
    private let layout: Layout = .init()
    private var avatarShape: AvatarShape = .rectangle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        TODO: will be moved
        switch avatarShape {
        case .circle:
            avatarView.layer.cornerRadius = avatarView.bounds.width / 2
        case .rectangle:
            break;
        }
    }
    
    func bind(_ model: ProfilePresentationModel) {
        avatarView.bind(model.avatarModel)
        nameView.text = model.nameText
        self.avatarShape = model.avatarModel.shape
        setNeedsLayout()
    }
}

private extension ProfileView {
    
    func addUI() {
        addAvatarView()
        addNameView()
    }
    
    func addAvatarView() {
        
        addSubview(avatarView)
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: self.topAnchor),
            avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: layout.avatarSize),
            avatarView.heightAnchor.constraint(equalToConstant: layout.avatarSize)
        ])
    }
    
    func addNameView() {
        nameView.font = .systemFont(ofSize: layout.nameFontSize, weight: .medium)
        nameView.textAlignment = .center
        nameView.textColor = .label
        
        addSubview(nameView)
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: layout.verticalSpacing),
            nameView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
private extension ProfileView {
    struct Layout {
        let avatarSize: CGFloat = 100
        let nameFontSize: CGFloat = 17
        let verticalSpacing: CGFloat = 8
    }
}
