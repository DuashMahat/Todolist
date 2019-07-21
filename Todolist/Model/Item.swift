//
//  Item.swift
//  Todolist
//
//  Created by Duale on 7/17/19.
//  Copyright © 2019 Duale. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var data : String = ""
    @objc dynamic var isChecked : Bool = false
    @objc dynamic var dateCreated : Date?
//    @objc dynamic var colorStr : String = ""
       // this is inverse relation from many to one
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}


