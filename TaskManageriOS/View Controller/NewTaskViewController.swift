//
//  NewTaskViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 8/4/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit
import Firebase
class NewTaskViewController: UIViewController {

    @IBOutlet weak var TaskErrorlabel: UILabel!
    @IBOutlet weak var TaskNameField: UITextField!
    @IBOutlet weak var TaskDescription: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskErrorlabel.text = ""
        
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
