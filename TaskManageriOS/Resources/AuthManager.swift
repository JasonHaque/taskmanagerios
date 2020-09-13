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
        
        
        DatabaseManager.shared.userExists(email: email) { userExists in
            
            if userExists{
                
                print("User Already exists")
                completion(false)
                return
                
            }
            else{
                print("started creating user")
                
                Auth.auth().createUser(withEmail: email, password: password) { result , error in
                    
                    guard let result = result , error == nil else{
                        completion(false)
                        return
                    }
                    
                    DatabaseManager.shared.createNewUser(email: email, userName: userName) { success in
                        
                        if success{
                            print("User registered")
                            completion(true)
                            return
                        }
                        else{
                            
                            print("Error creating user")
                            completion(false)
                            return
                            
                        }
                    }
                }
                
            }
        }
        
        
        
    }
    
    public func logUserOut(completion : @escaping (Bool) -> Void){
        
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch{
            print(error)
            completion(false)
            return
            
        }
        
    }
}
