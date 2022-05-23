//
//  GamesData.swift
//  Game-List
//
//  Created by MacBook Noob on 21/08/21.
//

import UIKit

// MARK: Game List JSON objects
struct Games: Codable {
    let results: [Game]
}

struct Game: Codable {
    let id: Int
    let name: String
    let background_image: String
    let rating: Double
    let released: String
    let ratings_count: Int
}

// MARK: Game Detail JSON objects
struct GameDetail: Codable {
    let description_raw: String
    let parent_platforms: [ParentPlatforms]
    let genres: [Genres]
    let developers: [Developers]
    let publishers: [Publishers]
    let esrb_rating: ESRBRating
}

struct ParentPlatforms: Codable {
    let platform: Platform
}

struct Platform: Codable {
    let name: String
}

struct Genres: Codable {
    let name: String
}

struct Developers: Codable {
    let name: String
}

struct Publishers: Codable {
    let name: String
}

struct ESRBRating: Codable {
    let name: String
}
// MARK: Game List Objects
struct GameList {
    let id: Int
    let name: String
    let rating: Double
    let released: String
    let imageURL: String
    let ratingCount: Int
}

// MARK: Game Detail Objects
struct DetailOfGame {
    let description: String
    let parentPlatform: [String]
    let genres: [String]
    let developers: [String]
    let publishers: [String]
    let esrbRating: String
}

struct FavGameModel {
    let id: Int
    let name: String
    let rating: String
    let releasedDate: String
    let ratingCount: Int
    let gameDescription: String
    let parentPlatform: String
    let genres: String
    let developers: String
    let publishers: String
    let esrbRating: String
    let image: Data
}
