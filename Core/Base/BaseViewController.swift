//
//  BaseViewController.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addUI()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
}

extension BaseViewController{
    private func addUI() {}
}
