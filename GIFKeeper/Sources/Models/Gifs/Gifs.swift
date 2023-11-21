//
//  Gifs.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 10.11.2023.
//

// FIXME: Temporary model
#warning("Refactoring model")
struct Gifs: Codable {
    let data: [Image]
    let pagination: Pagination
}
