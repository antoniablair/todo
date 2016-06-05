//
//  TodoTableViewController.swift
//  Crowlie
//
//  Created by Antonia Blair on 5/29/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {
    
    // MARK: Properties

    var todos = [Todo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()

        if let savedTodos = loadTodos() {
            todos += savedTodos
        }
        
        if !(NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce")) {
            print ("First-time launch")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
            NSUserDefaults.standardUserDefaults().synchronize()
            loadSampleTodos()
        }
        else {
            if todos.count == 0 {
                // Change this to a more eloquent reminder to make a todo list
                LoadReminderTodo()
            }
        }
    }
    
    func loadSampleTodos() {
        let todo1 = Todo(name: "Drop off laundry", frequency: "Weekly", completed: false)
        let todo2 = Todo(name: "Feed Sal and Edie", frequency: "Daily", completed: true)
        let todo3 = Todo(name: "Work on iOS", frequency: "Once", completed: true)
        
        todos += [todo1!, todo2!, todo3!]
    }
    
    func LoadReminderTodo() {
        let reminder = Todo(name: "Create a todo list!", frequency: "Daily", completed: false)
        todos += [reminder!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // visual grouping of cells within table view (simples ones just need 1)
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TodoTableViewCell" // resue identifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TodoTableViewCell

        // Fetches the todos for each row
        let todo = todos[indexPath.row]
        
        cell.nameLabel.text = todo.name
        cell.frequencyLabel.text = todo.frequency

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Deletes
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            todos.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            // (Not using right now)
        }
        saveTodos()
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            print ("Show");
            let TodoDetailViewController = segue.destinationViewController as! TodoViewController
            // Get the cell that generated this segue.
            if let selectedTodoCell = sender as? TodoTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedTodoCell)!
                let selectedTodo = todos[indexPath.row]
                TodoDetailViewController.todo = selectedTodo
            }
        }
        else if segue.identifier == "AddItem" {
            print ("Add")
        }
    }
    
    // MARK: Actions
    @IBAction func unwindToTodoList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? TodoViewController, todo = sourceViewController.todo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                todos[selectedIndexPath.row] = todo
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                // Add a new meal.
                let newIndexPath = NSIndexPath(forRow: todos.count, inSection: 0)
                todos.append(todo)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
         saveTodos()
        }
    }
    
    
    // MARK: NSCoding
    func saveTodos() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(todos, toFile: Todo.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save todos...")
        } else {
            print("Saved!!!!")
        }
    }
    func loadTodos() -> [Todo]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Todo.ArchiveURL.path!) as? [Todo]
    }
}
