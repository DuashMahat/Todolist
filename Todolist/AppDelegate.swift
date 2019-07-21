//
//  AppDelegate.swift
//  Todolist
//
//  Created by Duale on 7/12/19.
//  Copyright © 2019 Duale. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // let us print the file
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        // create new realm
        
        
        
        
        do {
            _ = try Realm()  // not using a variable use underscore 
        } catch {
           print("Error in in initializing new realm \(error)")
        }
        
      
       
        
        // realm allows us to use object oriented programming and PERSIST objects 
        
//        print("Did finish lauching woith options")
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        // gets called when your app loads up
        // Override point for customization after application launch.
        return true
    }

}

