//
//  QuickActionButton.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 12.08.2025.
//

import UIKit

final class QuickActionButton: UIButton {
    
    private lazy var containerStackView: UIStackView = .build()
    private lazy var circleView: UIView = .build ()
    private lazy var iconView: UIImageView = .build ()
    private lazy var titleLabelView: UILabel = .build ()
    private let layout: Layout = .init()
    
    private var actionHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(with model: QuickActionButtonPresentationModel) {
        titleLabelView.text = model.title
        iconView.image = UIImage(systemName: model.iconName)
        circleView.backgroundColor = model.color
        
        self.addAction(UIAction(handler: { action in
            model.action()
        }), for: .touchUpInside)
    }
}

private extension QuickActionButton {
    
    func addUI() {
        addContainerStackView()
        addCircleView()
        addTitleLabelView()
    }
    
    func addContainerStackView() {
        containerStackView.axis = .vertical
        containerStackView.spacing = layout.stackViewSpacing
        containerStackView.alignment = .center
        containerStackView.isUserInteractionEnabled = false
        
        addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: layout.verticalPadding),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -layout.verticalPadding)
        ])
    }
    
    func addCircleView() {
        circleView.layer.cornerRadius = layout.cornerRadius
        containerStackView.addArrangedSubview(circleView)
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: layout.circleSize),
            circleView.heightAnchor.constraint(equalToConstant: layout.circleSize)
        ])
        
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .white
        circleView.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: layout.iconSize),
            iconView.heightAnchor.constraint(equalToConstant: layout.iconSize)
        ])
    }
    
    func addTitleLabelView() {
        titleLabelView.font = .systemFont(ofSize: 14)
        titleLabelView.textColor = .black
        titleLabelView.textAlignment = .center
        titleLabelView.numberOfLines = 0
        
        containerStackView.addArrangedSubview(titleLabelView)
    }
}

private extension QuickActionButton {
    struct Layout {
        let circleSize: CGFloat = 70.0
        let iconSize: CGFloat = 40.0
        let stackViewSpacing: CGFloat = 8.0
        let verticalPadding: CGFloat = 10.0
        var cornerRadius: CGFloat { circleSize / 2.0 }
    }
}
