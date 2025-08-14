//
//  ProfilePresentationModel.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 13.08.2025.
//

import UIKit

struct ProfilePresentationModel {
    
    let avatarModel: AvatarPresentationModel
    let nameText: String
    let shape: Shape
    
    init(
        avatarModel: AvatarPresentationModel,
        nameText: String,
        shape: ProfilePresentationModel.Shape = .circle
    ) {
        self.avatarModel = avatarModel
        self.nameText = nameText
        self.shape = shape
    }
    
    enum Shape {
        case rectangle
        case circle
    }
}
