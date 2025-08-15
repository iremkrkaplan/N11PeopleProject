//
//  UIVIew+Layout.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.08.2025.
//

import Foundation
import UIKit

extension UIView {
    static func build<T: UIView>(
        _ configure: ((T) -> Void)? = nil
    ) -> T {
        build {
            let view = T()
            configure?(view)
            return view
        }
    }

    static func build<T: UIView>(
        _ build: () -> T
    ) -> T {
        let view = build()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
