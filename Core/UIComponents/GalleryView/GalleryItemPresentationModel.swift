//
//  GalleryItemPresentationModel.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 13.08.2025.
//


import UIKit

struct GalleryItemPresentationModel {
    let imageSystemName: String
    let tintColor: UIColor
}

struct GalleryPresentationModel {
    let items: [GalleryItemPresentationModel]
}
