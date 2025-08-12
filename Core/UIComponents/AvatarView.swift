//
//  AvatarView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 10.08.2025.
//
import Foundation
import UIKit

struct AvatarPresentationModel {
    let url: URL?
}

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
    
    func bind(_ model: AvatarPresentationModel) {
        self.image = nil
        self.image = UIImage(systemName: "person.circle.fill")
        
        // TODO: - Kingfisher lib
       /* if let url = model.url {
            self.kf.setImage(with: url, placeholder: UIImage(systemName: "person.circle.fill"))
        } else {
            self.image = UIImage(systemName: "person.circle.fill")
        } */
    }

    // MARK: - Setup
    private func setupDefaults() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        tintColor = .systemPurple
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}
