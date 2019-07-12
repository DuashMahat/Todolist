//
//  ViewController.swift
//  Todolist
//
//  Created by Duale on 7/12/19.
//  Copyright © 2019 Duale. All rights reserved.
//

import UIKit

// change the uiviewcontroller to uitable view so that the class inherits from the uitableview
class TodolistViewController : UITableViewController {
    
    // let us create a an array
    // this array is for cell one , cell two and cell three in my tableview
    let itemArray = ["Meet Duale" , "Cook the food" , "Meditate"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK - TableView Datasource : tHE NUMBER OF ROWS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray.count
    }
    
    // MARK - The data specification of what is to be added into a row
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // the identifier is the
       let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListIdentifier", for: indexPath)
        
        //set the textlabel in every single cell to the the name and the color of the cell and the accesorty type
       cell.tintColor = UIColor.green
       cell.textLabel?.text = itemArray[indexPath.row]
        
        // return the cell
       return cell
    }

    
    //MARK- table view delegate methods that detects which row was selected and use that information to do some stuffs 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       print(indexPath.row)
//       print(itemArray[indexPath.row])
     
        
        // adding a check mark
        
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        
        // removing the checkmark once seleced: if the cell has already a checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
          tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
//        // once u select  we need to diselect it the animation
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

