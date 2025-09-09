//
//  EmptyStatePresentationModel.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 8.09.2025.
//

import Foundation

struct EmptyStatePresentationModel {
    let titleViewText: String
    let subtitleViewText: String
    let imageName: String?
    
    static let emptyState = EmptyStatePresentationModel(
        titleViewText: "Favori listeniz boş!",
        subtitleViewText: "kalp ikonuna tıklayarak favoriye ekleyebilirsiniz",
        imageName: "PlaceHolder"
    )
}
