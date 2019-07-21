//
//  SwipeTableViewController.swift
//  Todolist
//
//  Created by Duale on 7/18/19.
//  Copyright © 2019 Duale. All rights reserved.
//
 /*THIS WILL BE THE SUPERCLASS IN WHICH THE REST WILL INHERIT FROM*/
import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController , SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        increaseCellHeight()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // when i swipe my phone from right , then i should be able to triger this closure and do what is neccesary
            // handle action by updating model with deletion
            // we have to remove this things from the database
            //            tableView.reloadData() because OPTION IN THE FUNCTION BELOW WILL REMOVE THE ROW FROM THE LIST
            
            self.updateDataModel(at: indexPath)
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
    
        return [deleteAction]
    }
    
    
    //MARK- Add some data sources
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for:  indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    
    // swipe all the way to delete without having to click
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        
//        options.transitionStyle = .border
        return options
    }
    
    
    func updateDataModel (at indexPath: IndexPath ) {
       // update data models
    }

    
    func increaseCellHeight () {
        tableView.rowHeight = 100.00
    }
    
}

