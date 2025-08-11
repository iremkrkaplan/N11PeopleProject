//
//  AvatarView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 10.08.2025.
//
import Foundation
import UIKit

class AvatarView: UIImageView {
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var avatarImageView: UIImageView = .build {
        $0.contentMode = .scaleAspectFit
    }

    // MARK: - Setup
    private func setupDefaults() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        backgroundColor = .systemGray
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}
