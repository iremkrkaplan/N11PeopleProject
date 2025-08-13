//
//  QuickActionButton.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 12.08.2025.
//

import Foundation
import UIKit

final class QuickActionButton: UIButton {
    
    private lazy var containerStackView: UIStackView = .build()
    private lazy var circleView: UIView = .build ()
    private lazy var iconView: UIImageView = .build ()
    private lazy var titleLabelView: UILabel = .build ()
    
    private var actionHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: QuickActionButtonPresentationModel) {
        titleLabelView.text = model.title
        iconView.image = UIImage(systemName: model.iconName)
        circleView.backgroundColor = model.color
        self.actionHandler = model.action
    }
    
}
private extension QuickActionButton {
    
    func addUI() {
        addContainerStackView()
        addCircleView()
        addTitleLabelView()
        configureButton()
    }
    
    func addContainerStackView() {
        containerStackView.axis = .vertical
        containerStackView.spacing = Layout.stackViewSpacing
        containerStackView.alignment = .center
        containerStackView.isUserInteractionEnabled = false
        
        addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.verticalPadding),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Layout.verticalPadding)
        ])
    }
    
    func addCircleView() {
        circleView.layer.cornerRadius = Layout.cornerRadius
        containerStackView.addArrangedSubview(circleView)
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: Layout.circleSize),
            circleView.heightAnchor.constraint(equalToConstant: Layout.circleSize)
        ])
        
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .white
        circleView.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            iconView.heightAnchor.constraint(equalToConstant: Layout.iconSize)
        ])
    }
    
    func addTitleLabelView() {
        titleLabelView.font = .systemFont(ofSize: 14)
        titleLabelView.textColor = .black
        titleLabelView.textAlignment = .center
        titleLabelView.numberOfLines = 0
        
        containerStackView.addArrangedSubview(titleLabelView)
    }
    
    func configureButton() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        actionHandler?()
    }
}

private extension QuickActionButton {
    struct Layout {
        static let circleSize: CGFloat = 70.0
        static let iconSize: CGFloat = 40.0
        static let stackViewSpacing: CGFloat = 8.0
        static let verticalPadding: CGFloat = 10.0
        static var cornerRadius: CGFloat { circleSize / 2.0 }
    }
}
