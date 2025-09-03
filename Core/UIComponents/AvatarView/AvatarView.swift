//
//  AvatarView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 10.08.2025.
//
import UIKit
import Kingfisher

final class AvatarView: UIView {
    
    private lazy var imageView: UIImageView = .build()
    private let layout: Layout = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ model: AvatarPresentationModel) {
        var placeholderImage: UIImage?
        if let imageName = model.placeholderImageName{
            placeholderImage = UIImage(named: imageName)
        }
        self.imageView.image = placeholderImage
        

        imageView.kf.setImage(
            with: model.url,
            placeholder: placeholderImage,
            options: [.transition(.fade(0.2))]
        )
    }
}

private extension AvatarView {
    
    private func addUI() {
        contentMode = .center
        clipsToBounds = true
        tintColor = .systemPurple
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = layout.borderWidth
        
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
        let borderWidth: CGFloat = 1.0
    }
}