//
//  Network+Helper.swift
//  Game-List
//
//  Created by MacBook Noob on 14/08/21.
//

import UIKit

struct Constants {
    static let key = "d21b67d141244e29a46ec93de875b0da"
    static let baseURL = "https://api.rawg.io/api/"
    static let gameList = "games"
    static let gameDesc = "games/"
}

enum DownloadState {
    case new, downloaded, failed
}

class GameContent {
    let id: Int
    let title: String
    let releasedDate: String
    let rating: Double
    let poster: URL
    let ratingCount: Int
 
    var image: UIImage?
    var state: DownloadState = .new
 
    init(id: Int, title: String, releasedDate: String, rating: Double, poster: URL, ratingCount: Int) {
        self.id = id
        self.title = title
        self.releasedDate = releasedDate
        self.rating = rating
        self.poster = poster
        self.ratingCount = ratingCount
    }
}
