//
//  ProfileView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 11.08.2025.
//
import UIKit

final class ProfileView: UIView {
//    TODO: Allignments for better UI
    
    private lazy var avatarView: AvatarView = .build()
    private lazy var usernameView: UILabel = .build()
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
        switch avatarShape {
        case .circle:
            avatarView.layer.cornerRadius = avatarView.bounds.width / 2
        case .rectangle:
            break;
        }
    }
    
    func bind(_ model: ProfilePresentationModel) {
        avatarView.bind(model.avatarModel)
        usernameView.text = model.userNameText
        
        if let fullName = model.nameText, !fullName.isEmpty {
            nameView.text = fullName
            nameView.isHidden = false
        } else {
            nameView.text = nil
            nameView.isHidden = true
        }
        self.avatarShape = model.avatarModel.shape
        setNeedsLayout()
    }
}

private extension ProfileView {
    
    func addUI() {
        addAvatarView()
        addNameView()
        addUsernameView()
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
        nameView.textColor = .label
        nameView.textAlignment = .center
        
        addSubview(nameView)
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: layout.verticalSpacing),
            nameView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func addUsernameView() {
          usernameView.textColor = .secondaryLabel
          usernameView.textAlignment = .center
          
          addSubview(usernameView)
          
          let bottomConstraint = usernameView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
          bottomConstraint.priority = .defaultHigh
          NSLayoutConstraint.activate([

            usernameView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: layout.textSpacing),
              usernameView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              usernameView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              bottomConstraint,
              nameView.bottomAnchor.constraint(lessThanOrEqualTo: usernameView.topAnchor)
          ])
      }
  }


private extension ProfileView {
    private struct Layout {
        let avatarSize: CGFloat = 100
        let nameFontSize: CGFloat = 27
        let UserNameFontSize: CGFloat = 17
        let verticalSpacing: CGFloat = 12
        let textSpacing: CGFloat = 8
    }
}
