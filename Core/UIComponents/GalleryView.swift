//
//  GalleryView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 11.08.2025.
//

import Foundation
import UIKit

final class GalleryView: UIView {
    
    private lazy var mainStackView: UIStackView = .build {
        $0.axis = .vertical
        $0.spacing = Layout.rowSpacing
        $0.distribution = .fillEqually
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withItemCount count: Int) {
        mainStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        addGalleryRows(for: count)
    }
}
    // MARK: - Setup UI
private extension GalleryView {
    
    func addUI() {
        addMainStackView()
    }

    func addMainStackView() {
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }
    
    func addGalleryRows(for count: Int) {
        guard count > 0 else { return }
        
        let numberOfRows = (count + 1) / 2
        
        for index in 0..<numberOfRows {
            let rowStackView = createGalleryRow(at: index, totalItemCount: count)
            mainStackView.addArrangedSubview(rowStackView)
        }
    }
    
    func createGalleryRow(at rowIndex: Int, totalItemCount: Int) -> UIStackView {
        let rowStackView: UIStackView = .build {
            $0.axis = .horizontal
            $0.spacing = Layout.itemSpacing
            $0.distribution = .fillEqually
        }
        
        let item1 = makeGalleryItemView()
        rowStackView.addArrangedSubview(item1)
        
        let secondItemIndex = rowIndex * 2 + 1
        if secondItemIndex < totalItemCount {
            let item2 = makeGalleryItemView()
            rowStackView.addArrangedSubview(item2)
        } else {
            let placeholderView = UIView()
            rowStackView.addArrangedSubview(placeholderView)
        }
        
        return rowStackView
    }
    
    func makeGalleryItemView() -> UIView {
        let view: UIView = .build {
            $0.backgroundColor = .systemGray6
            $0.layer.cornerRadius = Layout.itemCornerRadius
            $0.clipsToBounds = true
        }

        let imageView: UIImageView = .build {
            $0.image = UIImage(systemName: "ladybug.fill")
            $0.tintColor = .systemPurple
            $0.contentMode = .scaleAspectFit
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Layout.imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Layout.imageSize.height),
            view.heightAnchor.constraint(equalToConstant: Layout.itemHeight)
        ])
        
        return view
    }
}
private extension GalleryView {
    struct Layout {
        static let rowSpacing: CGFloat = 16
        static let itemSpacing: CGFloat = 16
        static let itemCornerRadius: CGFloat = 15
        static let itemHeight: CGFloat = 120
        static let imageSize: CGSize = .init(width: 60, height: 60)
    }
}
