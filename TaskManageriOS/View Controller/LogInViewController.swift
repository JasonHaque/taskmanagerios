//
//  LogInViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 6/4/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ErrorLabel.text = ""

    }
    

    
    @IBAction func LogInTapped(_ sender: Any) {
       let email = EmailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       let passWord = PasswordField.text!.trimmingCharacters(in: .newlines)
             
       let error = verifyInputs(email,passWord)
             if(error != ""){
                 ErrorLabel.text = error
                 return
             }
      ErrorLabel.text = ""
    }
    
    func verifyInputs(_ email:String,_ password:String) -> String {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if (email == "" || password == "") {
            return "Fill up the fields properly"
        }
        else if(!emailPred.evaluate(with: email)){
            return "Not an email address"
        }
        
        return ""
    }
    
}
