//
//  TaskManager.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 15/5/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import Foundation
import Firebase

public class TaskManager{
    
   
    
    func getTask(completion: @escaping ([TaskModel]) -> Void){
        var taskArray = [TaskModel]()
        
           
        let email = (Auth.auth().currentUser?.email)!.split(separator: "@")
               let user = String(email[0])
               let dref = Database.database().reference().child("Users").child(user)
               dref.observe(DataEventType.value, with: {(DataSnapshot) in
                   if (DataSnapshot.childrenCount > 0){
                    taskArray.removeAll()
                       for tasks in DataSnapshot.children.allObjects as! [DataSnapshot]{
                           let taskObject = tasks.value as? [String : AnyObject]
                           let taskName = taskObject?["taskName"]
                           let taskDesc = taskObject?["taskDesc"]
                           let id = taskObject?["Id"]
                           
                           let task = TaskModel(id: id as! String?, taskName: taskName as! String?, taskDesc: taskDesc as! String?)
                           
                         taskArray.append(task)
                        
                    
                       }
                   }
                
                completion(taskArray)
               })
        
      
        
    }
    
    func saveTask(taskName:String,taskDesc:String){
        let email = (Auth.auth().currentUser?.email)!.split(separator: "@")
        let user = String(email[0])
        let ref = Database.database().reference()
        let key = ref.child("Users").child(user).childByAutoId().key
        let taskdata = [
            "Id" : key,
            "taskName" : taskName,
            "taskDesc" : taskDesc
        ]
        ref.child("Users").child(user).child((key)!).setValue(taskdata)
               
               
    }
    
    func updateTask(id : String,name : String,desc:String){
           let email = (Auth.auth().currentUser?.email)!.split(separator: "@")
           let user = String(email[0])
           let ref = Database.database().reference()
           let taskdata = [
                      "Id" : id,
                      "taskName" : name,
                      "taskDesc" : desc
                  ]
           ref.child("Users").child(user).child(id).setValue(taskdata)
           //TaskErrorlabel.text = "Successfully updated data"
       }
    
    func deleteTask(id:String){
        let email = (Auth.auth().currentUser?.email)!.split(separator: "@")
        let user = String(email[0])
        let ref = Database.database().reference()
        ref.child("Users").child(user).child(id).setValue(nil)
        //TaskErrorlabel.text = "Successfully deleted data"
    }
}
