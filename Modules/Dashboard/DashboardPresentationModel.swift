//
//  DashboardPresentationModel.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 14.08.2025.
//

import UIKit


struct DashboardViewData {
    let titleViewText: String
    let subtitleViewText: String
    let galleryTitleLabelText: String
    
    let profileModel: ProfilePresentationModel
    let quickActionModels: [[QuickActionButtonPresentationModel]]
    let settingsButtonModel: SimpleActionPresentationModel

    let galleryModel: GalleryPresentationModel?
}

struct SimpleActionPresentationModel {
    let iconName: String
    let action: () -> Void
}
