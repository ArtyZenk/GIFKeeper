//
//  NetworkAPI.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 10.11.2023.
//

enum NetworkAPI: String {
    case trending, search, random
    
    static let apiKey = ["api_key": "nDUgO92yiVJQvP8TuJIjqkUueEn3vkUU"]
    static let baseURL = "https://api.giphy.com/v1/gifs/"
    
    var fullURL: String { NetworkAPI.baseURL + self.rawValue }
}
