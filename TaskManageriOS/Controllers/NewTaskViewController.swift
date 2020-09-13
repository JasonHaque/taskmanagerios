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
        
        return textView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(taskNameField)
        view.addSubview(taskDescriptionField)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        taskNameField.frame = CGRect(x: 30,
                                     y: 100,
                                     width: view.width - 60,
                                     height: 52)
        taskDescriptionField.frame = CGRect(x: 30,
                                            y: taskNameField.bottom + 20,
                                            width: view.width - 60,
                                            height: 52)
    }

   

}
