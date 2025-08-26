//
//  AvatarPresentationModel.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 13.08.2025.
//
import Foundation

struct AvatarPresentationModel {
    let url: URL?
    let placeholderImageName: String?
    let shape: AvatarShape
    
    init(
        url: URL?,
        placeholderImageName: String?,
        shape: AvatarShape = .circle
    ) {
        self.url = url
        self.placeholderImageName = placeholderImageName
        self.shape = shape
    }
    
}

enum AvatarShape {
    case rectangle
    case circle
}
