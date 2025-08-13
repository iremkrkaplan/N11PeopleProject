//
//  BaseScrollViewController.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import Foundation
import UIKit

class BaseScrollViewController:  BaseViewController{
    let scrollView: UIScrollView = .build {
        $0.showsVerticalScrollIndicator = false
        $0.bounces = true
        $0.alwaysBounceVertical = true
    }

    let contentView: UIView = .build()
    
    func addScroll() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    
    }
    
    override func addUI() {
        super.addUI()
        addScroll()
    }
}
