//
//  DatabaseManager.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 12/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase


public class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //MARK:- public function calls
    
    public func userExists(email : String,completion : @escaping (Bool) -> Void){
        
        database.child(email.safeDatabaseKey()).observeSingleEvent(of: .value) { snapshot in
            
            guard snapshot.exists() else{
                completion(false)
                return
            }
            completion(true)
            return
        }
        
    }
    
    public func createNewUser(email : String, userName : String,completion : @escaping (Bool) -> Void){
        
        database.child(email.safeDatabaseKey()).setValue(["username" : userName],withCompletionBlock:{error,_ in
            
            guard error == nil else{
                completion(false)
                return
            }
            
            completion(true)
            return
            
        } )
        
    }
    
    public func getUserName(email : String,completion: @escaping (Result <String, Error>) -> Void){
        
        database.child(email.safeDatabaseKey()).observeSingleEvent(of: .value) { snapshot in
            
            guard let value = snapshot.value as? [String : String] else{
                completion(.failure("Error getting user Name" as! Error))
                return
            }
            guard let userName = value["username"] as? String else{
                completion(.failure("Error parsing user Name" as! Error))
                return
            }
            print(userName)
            
            completion(.success(userName))
            return
        }
        
    }
}

//MARK: - public function calls for firebase calls for saving and getting data

extension DatabaseManager{
    
    public func saveTask(with taskName : String , taskDescription : String , completion : @escaping (Bool) -> Void){
        
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else{
            return
        }
        
        guard let key = database.child("\(email.safeDatabaseKey())/tasks").childByAutoId().key  as? String else{
            completion(false)
            print("error getting key")
            return
        }
        
        let task = [
            "id" : key,
            "task_name" : taskName,
            "task_desc" : taskDescription
        ]
        
        database.child("\(email.safeDatabaseKey())/tasks").child(key).setValue(task,withCompletionBlock: { error ,_ in
            
            guard error == nil else{
                completion(false)
                return
            }
            
            completion(true)
            return
            
        })
        
    }
    
    public func getAllTasks(with email : String , completion : @escaping (Result<[Task],Error>) -> Void ){
        
        database.child("\(email.safeDatabaseKey())/tasks").observe(.value) { snapshot in
            
            var data = [Task]()
            guard snapshot.childrenCount > 0 else{
                //completion(.failure("error fetching data" as! Error))
                print("could not get data")
                return
            }
            data.removeAll()
            for tasks in snapshot.children.allObjects as! [DataSnapshot]{
                let taskObject = tasks.value as? [String : AnyObject]
                
                let taskId = taskObject?["id"] as! String
                let taskName = taskObject?["task_name"] as! String
                let taskDesc = taskObject?["task_desc"] as! String
                
                data.append(Task(taskId: taskId, taskName: taskName, taskDesc: taskDesc))
            }
            print(data)
            completion(.success(data))
        }
        
        
    }
    
}

public struct Task {
    let taskId : String
    let taskName : String
    let taskDesc : String
}
