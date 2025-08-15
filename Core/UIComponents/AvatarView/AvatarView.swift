//
//  AvatarView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 10.08.2025.
//
import UIKit

final class AvatarView: UIView {
    
    private lazy var imageView: UIImageView = .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ model: AvatarPresentationModel) {
        self.imageView.image = model.placeholderImage ?? UIImage(systemName: "person.fill")
        // TODO: - Kingfisher lib
       /* if let url = model.url {
            self.kf.setImage(with: url, placeholder: mdoel.placeholderImage)
        } else {
            self.image = model.placeholderImage
        } */
    }
}

private extension AvatarView {
    
    private func addUI() {
        contentMode = .center
        clipsToBounds = true
        tintColor = .systemPurple
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = Layout.borderWidth
        
        addImageView()
    }
    
    func addImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

private extension AvatarView {
    struct Layout {
        static let borderWidth: CGFloat = 1.0
    }
}
