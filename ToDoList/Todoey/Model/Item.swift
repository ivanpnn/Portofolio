//
//  Item.swift
//  Todoey
//
//  Created by Macbook on 05/01/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var state: Bool = false
    @objc dynamic var dateCreated: Double = 0.0
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
