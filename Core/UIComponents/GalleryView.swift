//
//  GalleryView.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 11.08.2025.
//

import Foundation
import UIKit

class GalleryView: UIView {
    
    // MARK: - UI Components
    private lazy var mainStackView: UIStackView = .build {
        $0.axis = .vertical
        $0.spacing = 16
        $0.distribution = .fillEqually
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        addGalleryItems(count: 6)
    }
    
    // MARK: - Helper Functions
    private func createRowStackView() -> UIStackView {
        let stackView: UIStackView = .build {
            $0.axis = .horizontal
            $0.spacing = 16
            $0.distribution = .fillEqually
        }
        return stackView
    }
    
    private func makeGalleryItemView() -> UIView {
        let view: UIView = .build {
            $0.backgroundColor = .systemGray6
            $0.layer.cornerRadius = 15
            $0.clipsToBounds = true
        }

        let ladybugImageView: UIImageView = .build {
            $0.image = UIImage(systemName: "ladybug.fill")
            $0.tintColor = .systemPurple
            $0.contentMode = .scaleAspectFit
        }

        view.addSubview(ladybugImageView)
        
        NSLayoutConstraint.activate([
            ladybugImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ladybugImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ladybugImageView.widthAnchor.constraint(equalToConstant: 60),
            ladybugImageView.heightAnchor.constraint(equalToConstant: 60),
            view.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        return view
    }
    
    private func addGalleryItems(count: Int) {
        let numberOfRows = (count + 1) / 2
        
        for rowIndex in 0..<numberOfRows {
            let rowStackView = createRowStackView()
            
            let item1 = makeGalleryItemView()
            rowStackView.addArrangedSubview(item1)

            let item2Index = rowIndex * 2 + 1
            if item2Index < count {
                let item2 = makeGalleryItemView()
                rowStackView.addArrangedSubview(item2)
            } else {
                let placeholderView = UIView()
                rowStackView.addArrangedSubview(placeholderView)
            }
            
            mainStackView.addArrangedSubview(rowStackView)
        }
    }
}
