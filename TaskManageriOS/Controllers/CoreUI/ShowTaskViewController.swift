//
//  ShowTaskViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 13/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit
import JGProgressHUD

/// updates a task

class ShowTaskViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let taskNameField : UITextField = {
           let textfield = UITextField()
           textfield.autocorrectionType = .no
           textfield.autocapitalizationType = .none
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
    
    private var task : Task?
    init(task : Task){
        
        self.task = task
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        
        setUpData()
        
        view.addSubview(taskNameField)
        view.addSubview(taskDescriptionField)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(didTapUpdate))

       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpData()
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
                                            height: view.height - taskNameField.height - 170)
    }
    
    func setUpData(){
        guard let task = task else{
            return
        }
        taskNameField.text = task.taskName
        taskDescriptionField.text = task.taskDesc
    }
    
    @objc func didTapUpdate(){
        
        print("Will Update")
        
        guard let task = task ,let updatedTaskName = taskNameField.text , let updatedDescription = taskDescriptionField.text ,
            !updatedTaskName.isEmpty , !updatedDescription.isEmpty else {
            return
        }
        
        spinner.textLabel.text = "Updating Task"
        spinner.show(in: view)
        
        DatabaseManager.shared.updateTask(with: task.taskId, taskName: updatedTaskName, taskDesc: updatedDescription, completion: { [weak self] updated in
            
            DispatchQueue.main.async {
                self?.spinner.dismiss()
            }
            
            if updated{
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
            else{
                
                self?.showUpdateError()
                
            }
            
            
            
        })
        
    }
    
    private func showUpdateError(){
        let alert = UIAlertController(title: "Oops", message: "there was an error while updating data", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert,animated: true)
    }

    

}
