//
//  ResultsModel.swift
//  UnsplashApp
//
//  Created by Петр Постников on 29.03.2024.
//

import Foundation

// MARK: - ResultsModel
struct ResultsModel: Decodable {
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let id: String?
    let createdAt: String?
    let width, height: Int?
    let color, blurHash: String?
    let likes: Int?
    let likedByUser: Bool
    let description: String?
    let user: User?
    let urls: [Urls.RawValue: String]

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width, height, color
        case blurHash = "blur_hash"
        case likes
        case likedByUser = "liked_by_user"
        case description, user
        case urls
    }
}

// MARK: - ResultLinks
struct ResultLinks: Decodable {
    let linksSelf: String
    let html, download: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
    }
}

// MARK: - Urls
enum Urls: String {
    case raw, full, regular, small, thumb
}

// MARK: - User
struct User: Decodable {
    let id, username, name, firstName: String?
    let lastName, instagramUsername, twitterUsername: String?
    let portfolioURL: String?

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case instagramUsername = "instagram_username"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
    }
}
