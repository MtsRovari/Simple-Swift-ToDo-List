//
//  TasksController.swift
//  Taskly
//
//  Created by Mateus Rovari on 17/03/19.
//  Copyright © 2019 Mateus Rovari. All rights reserved.
//

import UIKit

class TasksController: UITableViewController {
    
    var taskStore: TaskStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        print("Add task")
        // Setting up our alert controller
        
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        
        // Set up the actions
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            
            // Grab text field tet
            guard let name = alertController.textFields?.first?.text else { return }
            
            // Create task
            let  newTask = Task(name: name)
            
            // Add task
            self.taskStore.add(newTask, at: 0)
            
            // Reload data in table view
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        
        addAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Add the text field
        alertController.addTextField { textField in
            
            textField.placeholder = "Enter a task"
            textField.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        }
        
        // Add actions
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        // Present
        present(alertController, animated: true)
    }
    
    @objc private func handleTextChanged(_ sender: UITextField) {
        
        // Grab the alert controller and add action
        guard
            let alertController = presentedViewController as? UIAlertController,
            let addAction = alertController.actions.first,
            let text = sender.text
            else {return}
    
        // Enable add action based on if text is empty or contains whitespace
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
}

// MARK:  - DataSource
extension TasksController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "To-Do" : "Done"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return taskStore.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.tasks[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = taskStore.tasks[indexPath.section][indexPath.row].name
        
        return cell
    }
}

// MARK: - Delegate
extension TasksController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
}
