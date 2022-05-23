//
//  DataModel.swift
//  Halodoc_Exercise
//
//  Created by MacBook Noob on 29/09/21.
//

import UIKit

struct Datas: Codable {
    let hits: [Hits]
}

struct Hits: Codable {
    let title: String
    let url: String?
}

struct News {
    let title: String
    let newsURL: String
}

struct Constant {
    static let url = "https://hn.algolia.com/api/v1/search"
}
