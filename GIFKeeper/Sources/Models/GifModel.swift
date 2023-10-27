//
//  GifModel.swift
//  GIFKeeper
//
//  Created by Sonata Girl on 21.10.2023.
//

import UIKit

struct GifModel {
    let name: String
    let imageName: String?
}

// FIXME: Temporary model
#warning("Must change it")
extension GifModel {
    static func getEditGroups() -> [GifModel] {
        [
            GifModel(name: "Добавить группы", imageName: "plus"),
            GifModel(name: "Cats", imageName: nil),
            GifModel(name: "Friends", imageName: nil),
            GifModel(name: "Mornings", imageName: nil),
            GifModel(name: "Animals", imageName: nil),
        ]
    }
}
