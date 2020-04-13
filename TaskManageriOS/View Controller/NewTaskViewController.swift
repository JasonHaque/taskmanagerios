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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        let task : TaskModel
        task = taskList[indexPath.row]
        cell.taskName.text = task.taskName
        cell.taskDesc.text = task.taskDesc
        
        return cell
    }
    

    @IBOutlet weak var TaskErrorlabel: UILabel!
    @IBOutlet weak var TaskNameField: UITextField!
    @IBOutlet weak var TaskDescription: UITextField!
    
    @IBOutlet weak var Tabletaskview: UITableView!
    var taskList = [TaskModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskErrorlabel.text = ""
        
        let email = (Auth.auth().currentUser?.email)!.split(separator: "@")
        let user = String(email[0])
        let dref = Database.database().reference().child("Users").child(user)
        dref.observe(DataEventType.value, with: {(DataSnapshot) in
            if (DataSnapshot.childrenCount > 0){
                self.taskList.removeAll()
                for tasks in DataSnapshot.children.allObjects as! [DataSnapshot]{
                    let taskObject = tasks.value as? [String : AnyObject]
                    let taskName = taskObject?["taskName"]
                    let taskDesc = taskObject?["taskDesc"]
                    let id = taskObject?["Id"]
                    
                    let task = TaskModel(id: id as! String?, taskName: taskName as! String?, taskDesc: taskDesc as! String?)
                    self.taskList.append(task)
                    
                }
            }
            print(self.taskList)
            self.Tabletaskview.reloadData()
        })
        
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
        let email = (Auth.auth().currentUser?.email)!.split(separator: "@")
        let user = String(email[0])
        let ref = Database.database().reference()
        let key = ref.child("Users").child(user).childByAutoId().key
        let taskdata = [
            "Id" : key,
            "taskName" : taskName,
            "taskDesc" : taskDescription
        ]
        ref.child("Users").child(user).child((key)!).setValue(taskdata)
        TaskErrorlabel.text = "Successfully saved data"
        
    }
    
    func verifyInputs(_ taskName:String,_ taskDescription:String)-> String{
        if(taskName=="" || taskDescription==""){
            return "Fill up the fields properly"
        }
        return ""
    }
    
    

}
