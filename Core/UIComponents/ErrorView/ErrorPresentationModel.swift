//
//  ErrorPresentationModel.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 21.08.2025.
//

import UIKit

struct ErrorPresentationModel {
    let titleViewText: String
    let subtitleViewText: String
    let imageView: UIImage?
    let retryButtonModel: RetryActionPresentationModel
}

struct RetryActionPresentationModel {
    let buttonTitle: String
    let action: () -> Void
}

//TODO: Will be moved to presenter
extension ErrorPresentationModel{
    
    static func createViewData() -> ErrorPresentationModel {
        return .init(titleViewText: "Oops!",
                     subtitleViewText: "There is no connection",
                     imageView:  UIImage(named: "NetworkErrorImage") ?? UIImage(systemName: "wifi.exclamationmark"),
                     retryButtonModel: createPlaceholderRetryButtonModel())
    }
    
    static func createPlaceholderRetryButtonModel() -> RetryActionPresentationModel {
        return .init(buttonTitle: "Retry", action: {
            print("Retry button tapped")
        })
    }
}
