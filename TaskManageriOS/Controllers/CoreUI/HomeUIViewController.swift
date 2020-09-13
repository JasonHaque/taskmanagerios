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
    
    private let tableView : UITableView = {
        let table = UITableView()
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Tasks"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapCreateNewTask))

        checkAuthStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    //objc methods
    
    @objc func didTapCreateNewTask(){
        
        let vc = NewTaskViewController()
        vc.title = "Create a task"
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav,animated: false)
        
        
    }

  

}
