//
//  SaveModel.swift
//  UnsplashApp
//
//  Created by Петр Постников on 30.03.2024.
//

import Foundation

struct SaveModel: Codable {
    let id: String
    let urlImage: String
    let name: String
    let description: String
    let instagramUsername: String
    let portfolioURL: String
    let width, height: Int
}
