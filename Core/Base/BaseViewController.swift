//
//  BaseViewController.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import UIKit

class BaseViewController: UIViewController {
    let contentView: UIView = .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        addUI()
    }
    func addUI() {
        view.addSubview(contentView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
