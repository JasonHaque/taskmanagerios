//
//  AuthManager.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 12/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import Foundation
import FirebaseAuth

public class Authmanager {
    
    
    static let shared = Authmanager()
    
    //MARK: - public function calls
    
    public func logInUser(email : String , password : String , completion : @escaping (Bool) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { result , error in
            
            guard let result = result , error == nil else{
                completion(false)
                return
            }
            completion(true)
            return
        }
        
    }
    
    public func createNewUser(email : String , userName : String, password : String , completion : @escaping (Bool) -> Void){
        
    }
}
