//
//  SignUpViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 6/4/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var SignUpEmail: UITextField!
    @IBOutlet weak var SignUpPassword: UITextField!
    
    @IBOutlet weak var SignUpErrorLabel: UILabel!
    @IBOutlet weak var ConfirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        SignUpErrorLabel.text = ""
    }
    

    @IBAction func SignUpTapped(_ sender: Any) {
        print("Sign Up Tapped")
        let email = SignUpEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passWord = SignUpPassword.text!.trimmingCharacters(in: .newlines)
        let confirmPassword = ConfirmPassword.text!.trimmingCharacters(in: .newlines)
        let error = verifyInputs(email,passWord,confirmPassword)
        if(error != ""){
            SignUpErrorLabel.text = error
            return
        }
        SignUpErrorLabel.text = ""
        
        Auth.auth().createUser(withEmail: email, password: passWord) { (result, error) in
                   if(error != nil){
                       self.SignUpErrorLabel.text = error!.localizedDescription
                   }
                   self.transitionHome()
               }
    }
    
    func verifyInputs(_ email:String,_ password:String,_ confirmPassowrd:String) -> String {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if (email == "" || password == "" || confirmPassowrd == "") {
            return "Fill up the fields properly"
        }
        else if(!emailPred.evaluate(with: email)){
            return "Not an email address"
        }
        else if(password != confirmPassowrd){
            return "Passwords not matching"
        }
        return ""
    }
    
    func transitionHome(){
        let homeView = storyboard?.instantiateViewController(identifier: "HomeView") as? HomeUIViewController
        view.window?.rootViewController = homeView
        view.window?.makeKeyAndVisible()
    }
    
}
