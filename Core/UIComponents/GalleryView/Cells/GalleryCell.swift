//
//  GalleryCell.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 14.08.2025.
//

import UIKit
final class GalleryCell: UIView {

    private lazy var iconImageView: UIImageView = .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(with model: GalleryItemPresentationModel) {
        iconImageView.image = UIImage(systemName: model.imageSystemName)
        iconImageView.tintColor = model.tintColor
    }
}
private extension GalleryCell{
    
    func addUI(){
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = Layout.cornerRadius
        self.clipsToBounds = true
        addIconImageView()
    }
    
    func addIconImageView(){
        iconImageView.contentMode = .scaleAspectFit
        
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Layout.height),

            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Layout.iconSize.width),
            iconImageView.heightAnchor.constraint(equalToConstant: Layout.iconSize.height)
        ])
    }
}
private extension GalleryCell {
    struct Layout {
        static let height: CGFloat = 120
        static let cornerRadius: CGFloat = 15
        static let iconSize: CGSize = .init(width: 60, height: 60)
    }
}
