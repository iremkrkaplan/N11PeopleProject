//
//  QuickActionButton.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 12.08.2025.
//

import Foundation
import UIKit

// MARK: - Presentation Model
struct QuickActionButtonPresentationModel {
    let title: String
    let iconName: String
    let color: UIColor
    let action: () -> Void
}

// MARK: - QuickActionButton
final class QuickActionButton: UIButton {

    // MARK: - UI Components
    private lazy var containerStackView: UIStackView = .build {
        $0.axis = .vertical
        $0.spacing = Layout.stackViewSpacing
        $0.alignment = .center
        $0.isUserInteractionEnabled = false
    }

    private lazy var circleView: UIView = .build {
        $0.layer.cornerRadius = Layout.cornerRadius
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var iconView: UIImageView = .build {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }

    private lazy var titleLabelView: UILabel = .build {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private var actionHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(circleView)
        containerStackView.addArrangedSubview(titleLabelView)
        circleView.addSubview(iconView)
    }

    private func setupConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Layout.verticalPadding),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Layout.verticalPadding),
            
            circleView.widthAnchor.constraint(equalToConstant: Layout.circleSize),
            circleView.heightAnchor.constraint(equalToConstant: Layout.circleSize),
            
            iconView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: Layout.iconSize),
            iconView.heightAnchor.constraint(equalToConstant: Layout.iconSize)
        ])
    }

    func configure(with model: QuickActionButtonPresentationModel) {
        titleLabelView.text = model.title
        iconView.image = UIImage(systemName: model.iconName)
        circleView.backgroundColor = model.color
        self.actionHandler = model.action
    }
    
    @objc private func buttonTapped() {
        actionHandler?()
    }
    private struct Layout {
        static let circleSize: CGFloat = 70.0
        static let iconSize: CGFloat = 40.0
        static let stackViewSpacing: CGFloat = 8.0
        static let verticalPadding: CGFloat = 10.0
        static var cornerRadius: CGFloat { circleSize / 2.0 }
    }
}
