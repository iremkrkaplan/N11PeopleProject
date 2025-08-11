//
//  ProfileView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 11.08.2025.
//

import UIKit

class ProfileView: UIView {
    
    // MARK: - UI Components
    private lazy var avatarView: AvatarView = .build()
    
    private lazy var nameLabel: UILabel = .build {
        $0.font = .systemFont(ofSize: 17, weight: .medium)
        $0.textAlignment = .center
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(avatarView)
        addSubview(nameLabel)
        
        let avatarSize: CGFloat = 100
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: self.topAnchor),
            avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: avatarSize),
            avatarView.heightAnchor.constraint(equalToConstant: avatarSize),
            
            nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(image: UIImage?, name: String) {
        avatarView.image = image
        avatarView.tintColor = .white
        nameLabel.text = name
    }
}
