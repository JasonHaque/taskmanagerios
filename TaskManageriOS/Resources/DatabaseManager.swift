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
    
    public func userExists(email : String){
        
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
}
