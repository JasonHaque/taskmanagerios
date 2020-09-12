//
//  HomeUIViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 12/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit
import Firebase

class HomeUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        checkAuthStatus()
    }
    
    
    private func checkAuthStatus(){
        
        if Auth.auth().currentUser == nil{
            
            let vc = LogInViewController()
            vc.title = "Log In"
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav,animated: false)
        }
        
    }

  

}
