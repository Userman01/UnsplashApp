//
//  NetworkProvider.swift
//  UnsplashApp
//
//  Created by Петр Постников on 29.03.2024.
//

import Foundation

final class NetworkProvider {
    
    var networkService = NetworkService()
    
    func getImages(searchText: String, completion: @escaping (ResultsModel?) -> ()) {
        networkService.request(searchText: searchText) { [weak self] data, error in
            if let error {
                print(error.localizedDescription)
                completion(nil)
            } else {
                let decode = self?.decodeJSON(type: ResultsModel.self, data: data)
                completion(decode)
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        guard let data else { return nil }
        let decoder = JSONDecoder()
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let error {
            print(error)
            return nil
        }
    }
}
