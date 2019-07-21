//
//  CategoryTableViewController.swift
//  Todolist
//
//  Created by Duale on 7/16/19.
//  Copyright © 2019 Duale. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController  {
//     var category = [Category]()
        //
     var category : Results<Category>?
     let realm = try! Realm()   // this is how we create a realm object
//    var cellClr : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
//        increaseCellHeight()
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            //To change iOS 11 navigationBar largeTitle color
            
            UINavigationBar.appearance().prefersLargeTitles = true
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        } else {
            // for default navigation bar title color
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        }
        
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
        
    
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFiled = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
//            let newCategory = Category(context: self.context)
            let newCategory = Category()  // for realm our category is a straight up object
            newCategory.name = textFiled.text!
            newCategory.color = UIColor.randomFlat.hexValue()
//            self.category.append(newCategory) no need for this line because category is an auto updating container
            self.save(category: newCategory)
        }
        let action_two = UIAlertAction (title: "Back", style: .default) { (action_two) in
        
        }
        
        alert.addAction(action)
        alert.addAction(action_two)
        alert.addTextField { (field) in
            textFiled = field
            textFiled.placeholder = "Add a new category"
        }
        // view controller to present
        
       present(alert, animated: true, completion: nil )
    }
    
    
    //MARK - Table view data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // The nil coalescing operator
         return category?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // the next code is going to tab into the super class we are inheriting from
//        let cell = super.tableView(tableView, cellForRowAt: indexPath)
//        cell.textLabel?.text = category?[indexPath.row].name ?? "No categories added yet"
//        cell.backgroundColor = UIColor(hexString: category?[indexPath.row].color ?? "3A30FF")
////        cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn: <#T##UIColor#>, isFlat: <#T##Bool#>)
////        cellClr = (cell.backgroundColor?.hexValue())!
////        setCatCellColor(str: cellClr , indPath: indexPath)
//        return cell
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let categor = category?[indexPath.row] {
            cell.textLabel?.text = categor.name
             guard let categoryColor = UIColor(hexString: categor.color) else {fatalError()}
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        return cell
        
    }
    
    //MARK - Table View Delegate Methods
    
    //DATA manipulation methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // when we click on a cell we go and lead ourselves
        performSegue(withIdentifier: "goToItems", sender: self)
    }
      // before we perform the seque we need to prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           //
      let destinationVC = segue.destination as! TodolistViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = category?[indexPath.row]
        }
    }
    
    
    //MARK- SAVE
    func save(category : Category) {
        do {   // saving data into our realm database
            try realm.write {
                realm.add(category) // add our new category to our realm database   
            }
            
        } catch {
           print("There is an error \(error)")
        }
        tableView.reloadData()
    }
    
    // MARK:  loading ..........
    func loadCategories() {
    
        category = realm.objects(Category.self)
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//        do {
//            category = try context.fetch(request)
//        } catch {
//            print("An error has occured \(error)")
//        }
        
        
        tableView.reloadData()
    }
    
    
    //MARK: Delete data from swipe
        // getting from our superclass
    override func updateDataModel(at indexPath: IndexPath) {
//           super.updateDataModel(at: indexPath)  this will call the suporclass method and no overidding
        
          if let categoryDeleted = self.category?[indexPath.row] {
            do {
                try self.realm.write {
                   self.realm.delete(categoryDeleted)
                }

            } catch {
                print("Can not be deleted")
            }
          }
     }
    
}


