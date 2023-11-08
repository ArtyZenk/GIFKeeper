//
//  NetworkManager.swift
//  GIFKeeper
//
//  Created by Artyom Guzenko on 08.11.2023.
//

import Foundation
import Alamofire

// MARK: - Network Manager

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchGifs<T: Decodable>(
        dataType: T.Type,
        from url: String,
        completion: @escaping(Result<T, NetworkError>) -> Void
    ) {
        AF.request(url, parameters: NetworkAPI.apiKey)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    guard let data else {
                        completion(.failure(.noData))
                        return
                    }
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    guard
                        let gifs = try? decoder.decode(T.self, from: data)
                    else {
                        completion(.failure(.decodingError))
                        return
                    }
                    
                    completion(.success(gifs))
                case .failure:
                    completion(.failure(.invalidURL))
                }
            }
        
        // TODO: Add new parameter after refactor model
    }
}
