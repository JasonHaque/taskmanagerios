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
    
    func getTask()->[TaskModel]{
        var taskArray = [TaskModel]()
        let email = (Auth.auth().currentUser?.email)!.split(separator: "@")
               let user = String(email[0])
               let dref = Database.database().reference().child("Users").child(user)
               dref.observe(DataEventType.value, with: {(DataSnapshot) in
                   if (DataSnapshot.childrenCount > 0){
                       //self.taskList.removeAll()
                       for tasks in DataSnapshot.children.allObjects as! [DataSnapshot]{
                           let taskObject = tasks.value as? [String : AnyObject]
                           let taskName = taskObject?["taskName"]
                           let taskDesc = taskObject?["taskDesc"]
                           let id = taskObject?["Id"]
                           
                           let task = TaskModel(id: id as! String?, taskName: taskName as! String?, taskDesc: taskDesc as! String?)
                           //self.taskList.append(task)
                        taskArray.append(task)
                            
                           
                       }
                   }
                   //print(self.taskList)
                   //self.Tabletaskview.reloadData()
               })
        return taskArray
    }
}
