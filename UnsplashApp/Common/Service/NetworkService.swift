//
//  NetworkService.swift
//  UnsplashApp
//
//  Created by Петр Постников on 29.03.2024.
//

import Foundation

final class NetworkService {
    
    func request(searchText: String, completion: @escaping (Data?, Error?) -> Void) {
        let parameters = getParameters(searchText: searchText)
        guard let url = url(params: parameters) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = getHeasder()
        request.httpMethod = "get"
        createDataTask(from: request, completion: completion).resume()
    }
    
    private func getHeasder() -> [String: String] {
        var headers: [String: String] = [:]
        headers["Authorization"] = "Client-ID cQWQxOD7M_2_J0GSZtIbP94jrgxIyb2KQpXGnnvjP0Y"
        return headers
    }
    
    private func getParameters(searchText: String?) -> [String: String] {
        var param: [String: String] = [:]
        param["query"] = searchText
        param["page"] = String(1)
        param["per_page"] = String(20)
        return param
    }
    
    private func url(params: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request) { data, responce, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
