//
//  AvatarPresentationModel.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 13.08.2025.
//
import UIKit

struct AvatarPresentationModel {
    let url: URL?
    let placeholderImage: UIImage?
    let shape: AvatarShape
    
    internal init(
        url: URL?,
        placeholderImage: UIImage?,
        shape: AvatarShape = .circle
    ) {
        self.url = url
        self.placeholderImage = placeholderImage
        self.shape = shape
    }
    
    enum AvatarShape {
        case rectangle
        case circle
    }
}

