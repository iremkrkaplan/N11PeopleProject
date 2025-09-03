//
//  GalleryCell.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 14.08.2025.
//

import UIKit
final class GalleryCell: UIView {

    private lazy var iconImageView: UIImageView = .build()
    private let layout: Layout = .init()
    
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
        self.layer.cornerRadius = layout.cornerRadius
        self.clipsToBounds = true
        addIconImageView()
    }
    
    func addIconImageView(){
        iconImageView.contentMode = .scaleAspectFit
        
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: layout.height),

            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: layout.iconSize.width),
            iconImageView.heightAnchor.constraint(equalToConstant: layout.iconSize.height)
        ])
    }
}
private extension GalleryCell {
    struct Layout {
        let height: CGFloat = 120
        let cornerRadius: CGFloat = 15
        let iconSize: CGSize = .init(width: 60, height: 60)
    }
}
