//
//  Category.swift
//  Todolist
//
//  Created by Duale on 7/17/19.
//  Copyright © 2019 Duale. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
     @objc dynamic var name : String = ""
    
     /* relationship in realm : categories point  towards items and items point toward categpries */
       // create constants items that has an empty list
          // this is pretty much forward relationship inside each category there is pretty much a list of items
    // one to many : each category can be linked to many items : Remember the data models
    
     @objc dynamic var color : String = ""
    
     let items = List<Item>()   // each category can have a number of items 
}
