//
//  NewTaskViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 13/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    private let taskNameField : UITextField = {
        let textfield = UITextField()
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.placeholder = "Enter the name of the Task"
        textfield.layer.cornerRadius = 12
        textfield.layer.borderWidth = 1
        textfield.returnKeyType = .continue
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.backgroundColor = .secondarySystemBackground
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textfield.leftViewMode = .always
        return textfield
    }()
    
    private let taskDescriptionField : UITextView = {
        
        let textView = UITextView()
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        return textView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(taskNameField)
        view.addSubview(taskDescriptionField)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        taskNameField.frame = CGRect(x: 30,
                                     y: 100,
                                     width: view.width - 60,
                                     height: 52)
        taskDescriptionField.frame = CGRect(x: 30,
                                            y: taskNameField.bottom + 10,
                                            width: view.width - 60,
                                            height: view.height - taskNameField.height - 130)
    }
    
    @objc func didTapSaveButton(){
        
        guard let taskName = taskNameField.text , let taskDesc = taskDescriptionField.text,
            !taskName.isEmpty , !taskDesc.isEmpty else {
                //show an error here
                return
        }
        
        //proceed to call db and save data
        
        DatabaseManager.shared.saveTask(with: taskName, taskDescription: taskDesc) { dataSaved in
            
            if dataSaved{
                
            }
            else{
                
            }
            
        }
        
    }

   

}
