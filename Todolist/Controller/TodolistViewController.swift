//
//  ViewController.swift
//  Todolist
//
//  Created by Duale on 7/12/19.
//  Copyright © 2019 Duale. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework

// change the uiviewcontroller to uitable view so that the class inherits from the uitableview
class TodolistViewController : SwipeTableViewController  {
    
    @IBOutlet weak var searchBarOne: UISearchBar!
    var itemArray : Results <Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category?  {  // optional : will be nil until we
        didSet {
            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
            // making the navigation bar color the same as the color of the categiory
              // this optional binding is something i have to master
       
       
    }
    override func viewWillAppear(_ animated: Bool) {
        
     
        if let colorHex = selectedCategory?.color {
                title = selectedCategory!.name
               guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist")}
            
            
            if let navBarColor = UIColor(hexString: colorHex) {
                navBar.barTintColor = navBarColor
                navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
                navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
                searchBarOne.barTintColor = navBarColor
            }
         

        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let originalColor = UIColor(hexString: "ID98B6") else {fatalError("No color beeded")}
        navigationController?.navigationBar.barTintColor = originalColor
          navigationController?.navigationBar.tintColor =  FlatWhite()
          navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: FlatWhite()]
        
    }
    
    //MARK - TableView Datasource : tHE NUMBER OF ROWS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray?.count ?? 1
    }
    
    // MARK - The data specification of what is to be added into a row : RETURN A CELL AND ALL THAT IT CONTAINS
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // the identifier is the
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        //set the textlabel in every single cell to the the name and the color of the cell and the accesorty type
        cell.tintColor = UIColor.green
        
        if  let item = itemArray?[indexPath.row]  {
            cell.textLabel?.text = item.data    // grapping the data from item in and putting it into the text of the cell
//            cell.backgroundView = FlatSkyBlue().darken(byPercentage: CGFont(
//               indexPath.row / itemArray?.count
//            ))
            
            if let colour = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage:CGFloat(indexPath.row) / CGFloat(itemArray!.count)) {
               cell.backgroundColor = colour
               cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
               cell.tintColor = ContrastColorOf(colour, returnFlat: true)
            }
            cell.accessoryType = item.isChecked == true ? .checkmark  : .none
//            cell.backgroundColor = UIColor(hexString: item.col    orStr )
        } else {
            cell.textLabel?.text = "No items Added"
        }
        
        return cell
    }

    //MARK- table view delegate methods that detects which row was selected and use that information to do some stuffs 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itemArray?[indexPath.row] {  // if the current selected row is not nil
            // update realm : UPDATE DATA USING REALM
            do {
               try realm.write {  // put this into real item
//                realm.delete(item) this if you want to delete
                item.isChecked = !item.isChecked
              }
            } catch {
              print("Error \(error)")
            }
        }
        
        tableView.reloadData()
//        itemArray[indexPath.row].isChecked = !itemArray[indexPath.row].isChecked
//         saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Adding new UI button for adding new stuffs/lists 
    @IBAction func addItemsOnPressed(_ sender: UIBarButtonItem) {
        // create a text field that is global to this function
        
        var textField = UITextField()
        // here we need a pop once a user press the add and then list that in the uiviewtable and have a ui alert
           // this is for the alert message pop up that alerts the user of what to put
        let alert = UIAlertController(title: "Add your new to do item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Plan", style: .default) { (action) in
            // add code for what will happen when the user clicks add button on the "Add plan" uialer
            if let currentCategory = self.selectedCategory {  // optional binding 
                do {
                  try self.realm.write {
                     let newItem = Item()
                     newItem.data = textField.text!
                    newItem.dateCreated = Date()
//                    newItem.colorStr = UIColor.randomFlat.hexValue()
                     currentCategory.items.append(newItem)
                   }
                }
                catch {
                    print("Error in generating this \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        let action_two_ = UIAlertAction(title: "Back", style: .default) { (action_two_) in
            
        }
        
        // adding a textfield in the ui alertcontroller
        
        alert.addTextField { (alertTextField) in
          alertTextField.placeholder = "Type your new to do plan"
//            print(alertTextField.text!)
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(action_two_)
        
        // now we want to show our alert
        
        present(alert , animated: true , completion: nil)
    }
    
    // Mark: Model manipulation methods
    
//    func saveItems  () {
//
//        tableView.reloadData()
//    }

    
    func loadItems () {
        itemArray = selectedCategory?.items.sorted(byKeyPath: "data" , ascending: true)
        tableView.reloadData()
    }
    
    override func updateDataModel(at indexPath: IndexPath) {
        if let itemSelected = self.itemArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(itemSelected)
                }
                
            } catch {
                print("Can not be deleted")
                
            }
        }
    }
   
}


// MARK: Extension of the class ToDOlISRT

extension TodolistViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           
        /*REALM : When our search bar gets clicked : when we need to filter our array of items */
        
//    itemArray = itemArray?.filter("data CONTAINS[cd] %@" , searchBar.text!).sorted(byKeyPath: "data", ascending: true)
        
        itemArray = itemArray?.filter("data CONTAINS[cd] %@" , searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                loadItems()
                // we are done with the search bar and it should not be a point of focus . the text mark is done as well as keyboard popup
                //            searchBar.resignFirstResponder()
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
            }
        }
    

    }

    
    
//     GETTING BACK TO THE CELLS ONCE WE ARE DONE WITH A SERACH BAR
//         Any time our search bar text has changed we do something t
    

