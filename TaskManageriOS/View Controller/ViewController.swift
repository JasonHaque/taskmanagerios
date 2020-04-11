//
//  ViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 6/4/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkCurrentUser()
        
    }
    
    func checkCurrentUser(){
       Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.transitionHome()
            } else {
                 // user is not signed in
                 // go to login controller
            }
        }
    }
    
    func transitionHome(){
        let homeView = storyboard?.instantiateViewController(identifier: "HomeView") as? HomeUIViewController
        view.window?.rootViewController = homeView
        view.window?.makeKeyAndVisible()
    }


}

