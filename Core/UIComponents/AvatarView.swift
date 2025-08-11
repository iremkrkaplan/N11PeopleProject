//
//  AvatarView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 10.08.2025.
//
import Foundation
import UIKit

class AvatarView: UIView {
    
    private let avatarSize: CGFloat

    private lazy var avatarImageView: UIImageView = .build {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var nameLabel: UILabel = .build {
        $0.font = .systemFont(ofSize: 17, weight: .medium)
    }
    
    // MARK: - Initializer
    init(size: CGFloat) {
        self.avatarSize = size
        super.init(frame: .zero)
        setupUI()
    }
    /*override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    } */
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarSize),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(with image: UIImage?, name: String) {
        avatarImageView.image = image
        nameLabel.text = name
    }
}
