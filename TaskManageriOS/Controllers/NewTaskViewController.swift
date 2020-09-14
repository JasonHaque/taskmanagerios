//
//  NewTaskViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 13/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit
import JGProgressHUD

/// create a new task
class NewTaskViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
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
        spinner.textLabel.text = "Saving Task"
        spinner.show(in: view)
        
        //proceed to call db and save data
        
        DatabaseManager.shared.saveTask(with: taskName, taskDescription: taskDesc) {[weak self] dataSaved in
            
            DispatchQueue.main.async {
                self?.spinner.dismiss()
            }
            
            if dataSaved{
                DispatchQueue.main.async {
                    print("Data saved")
                    
                    self?.navigationController?.dismiss(animated: true, completion: nil)
                }
                
            }
            else{
                
                print("not saved")
                
            }
            
        }
        
    }
    
    //show error saving data alert
    
    func showErrorWhileSaving(){
        let alert = UIAlertController(title: "Oops", message: "there was an error while saving data", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert,animated: true)
        
    }

   

}
