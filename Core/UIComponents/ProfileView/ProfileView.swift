//
//  ProfileView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 11.08.2025.
//
import UIKit

final class ProfileView: UIView {
    
    private lazy var avatarView: AvatarView = .build()
    private lazy var usernameView: UILabel = .build()
    private lazy var nameView: UILabel = .build()
    private var layout: Layout = .init()
    private var avatarShape: AvatarShape = .rectangle
    
    override init(frame: CGRect) {
        self.layout = .init()
        super.init(frame: frame)
        addUI()
    }
    
    private init(frame: CGRect, layout: Layout) {
        self.layout = layout
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
        nameView.font = .systemFont(ofSize: layout.nameFontSize, weight: .bold)
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
        usernameView.font = .systemFont(ofSize: layout.UserNameFontSize)

          addSubview(usernameView)
          
          let bottomConstraint = usernameView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
          bottomConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            usernameView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: layout.textSpacing),
            usernameView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            usernameView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            usernameView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
      }
  }

extension ProfileView {
    static func build(avatarSize: CGFloat) -> ProfileView {
        let customLayout = Layout(avatarSize: avatarSize)
        return ProfileView(frame: .zero, layout: customLayout)
    }
}

private extension ProfileView {
    private struct Layout {
        var avatarSize: CGFloat = 100
        let nameFontSize: CGFloat = 27
        let UserNameFontSize: CGFloat = 17
        let verticalSpacing: CGFloat = 12
        let textSpacing: CGFloat = 8
        init(avatarSize: CGFloat = 100) {
            self.avatarSize = avatarSize
        }
        //TODO: 
    }
}
