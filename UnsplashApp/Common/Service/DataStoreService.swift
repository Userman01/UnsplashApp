//
//  DataStore.swift
//  UnsplashApp
//
//  Created by Петр Постников on 30.03.2024.
//

import UIKit

final class DataStoreService {
    
    static var keys: [String] = []
    
    static let defaults = UserDefaults.standard
    
    static func saveData(model: SaveModel) -> Bool {
        getKyes()
        let encoder = JSONEncoder()
        let id = model.id
        if let encode = try? encoder.encode(model) {
            defaults.set(encode, forKey: id)
        } else {
            return false
        }
        if !keys.contains(id) {
            keys.append(id)
        }
        if let encode = try? encoder.encode(keys) {
            defaults.set(encode, forKey: "keys")
        }
        // defaults.bool not working
        if let object = defaults.object(forKey: id) as? Data {
            return true
        } else {
            return false
        }
    }
    
    static func getKyes() {
        keys = []
        if let object = defaults.object(forKey: "keys") as? Data {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode([String].self, from: object) {
                object.forEach { key in
                    keys.append(key)
                }
            }
        }
    }
    
    static func getData() -> [SaveModel] {
        getKyes()
        var models: [SaveModel] = []
        keys.forEach { key in
            if let object = defaults.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let object = try? decoder.decode(SaveModel.self, from: object) {
                    models.append(object)
                }
            }
        }
        return models
    }
}
