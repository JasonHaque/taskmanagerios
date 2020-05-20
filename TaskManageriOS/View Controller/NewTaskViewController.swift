//
//  NewTaskViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 8/4/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit
import Firebase
class NewTaskViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    
    

    @IBOutlet weak var TaskErrorlabel: UILabel!
    @IBOutlet weak var TaskNameField: UITextField!
    @IBOutlet weak var TaskDescription: UITextField!
    
    @IBOutlet weak var Tabletaskview: UITableView!
    var taskList = [TaskModel]()
    var dummyTasks = [TaskModel]()
    var model = TaskManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskErrorlabel.text = ""
        
        model.getTask { (taskArray) in
            for tasks in taskArray{
                self.dummyTasks.append(tasks)
            }
            print(self.dummyTasks)
            
            self.Tabletaskview.reloadData()
        }
        
        
      
       
        
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        let taskName = TaskNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let taskDescription = TaskDescription.text!.trimmingCharacters(in: .newlines)
        
        let error = verifyInputs(taskName,taskDescription)
        
        if(error != ""){
            TaskErrorlabel.text = error
            return
        }
        TaskErrorlabel.text = ""
        model.saveTask(taskName: taskName, taskDesc: taskDescription)
    }
    
    func verifyInputs(_ taskName:String,_ taskDescription:String)-> String{
        if(taskName=="" || taskDescription==""){
            return "Fill up the fields properly"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return dummyTasks.count
     }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

         return 150
     }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let task = dummyTasks[indexPath.row]
         let alertController = UIAlertController(title: task.taskName, message: "New Task Desc" ,preferredStyle: .alert)
         
         let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
             let id = task.id
             let taskName = alertController.textFields?[0].text
             let taskDesc = alertController.textFields?[1].text
             
             self.model.updateTask(id: id!, name: taskName!, desc: taskDesc!)
             
            
             
         }
         let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
             self.model.deleteTask(id: task.id!)
             
             
         }
         alertController.addTextField { (UITextField) in
             UITextField.text = task.taskName
         }
         alertController.addTextField { (UITextField) in
             UITextField.text = task.taskDesc
         }
         alertController.addAction(updateAction)
         alertController.addAction(deleteAction)
         present(alertController,animated: true,completion: nil)
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
         let task : TaskModel
         task = dummyTasks[indexPath.row]
         print("dummy data \(dummyTasks[indexPath.row])")
         cell.taskName.text = task.taskName
         cell.taskDesc.text = task.taskDesc
         
         return cell
     }
   
    
    
    

}
