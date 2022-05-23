//
//  Category.swift
//  Todoey
//
//  Created by Macbook on 05/01/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colorHex: String = ""
    var items = List<Item>()
}
