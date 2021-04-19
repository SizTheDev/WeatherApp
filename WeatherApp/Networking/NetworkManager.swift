//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import Foundation

final class NetworkManager<T: Codable> {
    static func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //only proceed if error is nil else return with completion stating network api failed due to error
            guard error == nil else {
                print(String(describing: error!))
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            //convert response to httpresponse and check if status code 200 else return with completion failure invalid response
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            //check if data is valid else return with completion failed invalid data
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            //all checks passed attempt to decode if failed return decoding error
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch let err {
                print(String(describing: err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
            
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String)
    case decodingError(err: String)
}
