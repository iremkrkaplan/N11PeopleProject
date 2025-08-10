//
//  DashboardViewControllerRevised.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import Foundation
import UIKit

// BaseViewController +
// BaseScrollViewController +

// Navigation bar large title -> Dashboard

// AvatarView
// GalleryView - UIImageView

final class DashboardViewControllerRevised: UIViewController {

//    private lazy var scrollView: UIScrollView = .build()
//    private lazy var contentView: UIView = .build()
    private lazy var titleView: UILabel = .build()
    private lazy var cardView: UIView = .build()
    private lazy var dashBoardView: UILabel = .build() //dashboardlabel view
    private lazy var settingsActionView: UIButton = .build()
    private lazy var profileStackView: UIView = .build()
    private lazy var settingsButton: UIButton = .build()
    private lazy var galleryView: UIImageView = .build()
    private lazy var AvatarView: UIImageView = .build()
    // ...
    
    private let layout: Layout = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        addUI()
    }
}


extension DashboardViewControllerRevised {
    private func addUI() {
        addScroll()
    }
    
    private func addScroll() {
        addSettingsAction()
    }
    
    private func addSettingsAction() {
        /// .configuration
        /// UIButton.Configuration
        
        var configuration = UIButton.Configuration.filled(UIColor)
        /// layout
        scrollView.addSubview(settingsActionView)
        NSLayoutConstraint.activate([
            
        ])
        
        /// action
        settingsActionView.addAction(
            .init(handler: { _ in
            
            }),
            for: .touchUpInside
        )
    }
}
extension DashboardViewControllerRevised {
    private struct Layout {
        // CGFloat
        // CGSize
        // NSDirectionalEdgeInsets
    }
}
