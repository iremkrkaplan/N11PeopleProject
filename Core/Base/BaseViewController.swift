//
//  BaseViewController.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import Foundation
import UIKit

class BaseViewController<P: AnyObject>: UIViewController {
    var presenter: P?
    override func viewDidLoad(){
        super.viewDidLoad()
        //view.backgroundColor
        setupUI()
        bindViewModel()
    }
    open func setupUI(){}
    open func bindViewModel(){}
}
