//
//  ProfileView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 11.08.2025.
//
import UIKit

struct ProfilePresentationModel {
    let avatarModel: AvatarPresentationModel
    let nameText: String
}

final class ProfileView: UIView {
    
    private lazy var avatarView: AvatarView = .build()
    private lazy var nameView: UILabel = .build()
    
    var isAvatarCircular: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.layer.cornerRadius = isAvatarCircular ? avatarView.bounds.width / 2 : 0
    }
    
    func bind(_ model: ProfilePresentationModel) {
        avatarView.bind(model.avatarModel)
        nameView.text = model.nameText
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
            avatarView.widthAnchor.constraint(equalToConstant: Layout.avatarSize),
            avatarView.heightAnchor.constraint(equalToConstant: Layout.avatarSize)
        ])
    }
    
    func addNameView() {
        nameView.font = .systemFont(ofSize: Layout.nameFontSize, weight: .medium)
        nameView.textAlignment = .center
        nameView.textColor = .label
        
        addSubview(nameView)
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: Layout.verticalSpacing),
            nameView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
private extension ProfileView {
    struct Layout {
        static let avatarSize: CGFloat = 100
        static let nameFontSize: CGFloat = 17
        static let verticalSpacing: CGFloat = 8
    }
}
