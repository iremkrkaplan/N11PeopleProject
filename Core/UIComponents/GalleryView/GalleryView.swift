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
    //  TODO: FIX: custom view olarak yap
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(with model: GalleryPresentationModel) {
        mainStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        addGalleryRows(for: model.items)
    }
}

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
    
    func addGalleryRows(for items: [GalleryItemPresentationModel]) {
        guard !items.isEmpty else { return }
        
        let numberOfRows = (items.count + 1) / 2
        
        for index in 0..<numberOfRows {
            let item1Index = index * 2
            let item1Model = items[item1Index]
            
            var item2Model: GalleryItemPresentationModel? = nil
            let item2Index = item1Index + 1
            if item2Index < items.count {
                item2Model = items[item2Index]
            }
            
            let rowStackView = createGalleryRow(item1: item1Model, item2: item2Model)
            mainStackView.addArrangedSubview(rowStackView)
        }
    }
    //    view yap custom
    func createGalleryRow(item1: GalleryItemPresentationModel, item2: GalleryItemPresentationModel?) -> UIStackView {
          let rowStackView: UIStackView = .build {
              $0.axis = .horizontal
              $0.spacing = Layout.itemSpacing
              $0.distribution = .fillEqually
          }
          
          let item1View = makeGalleryItemView(with: item1)
          rowStackView.addArrangedSubview(item1View)
          
          if let item2Model = item2 {
              let item2View = makeGalleryItemView(with: item2Model)
              rowStackView.addArrangedSubview(item2View)
          } else {
              let placeholderView = UIView()
              rowStackView.addArrangedSubview(placeholderView)
          }
          
          return rowStackView
      }
    
    func makeGalleryItemView(with model: GalleryItemPresentationModel) -> UIView {
         let view: UIView = .build {
             $0.backgroundColor = .systemGray6
             $0.layer.cornerRadius = Layout.itemCornerRadius
             $0.clipsToBounds = true
         }

         let imageView: UIImageView = .build {
             $0.image = UIImage(systemName: model.imageSystemName)
             $0.tintColor = model.tintColor
             $0.contentMode = .scaleAspectFit
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
