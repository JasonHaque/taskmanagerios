//
//  LogInViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 12/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let EmailTextField : UITextField = {
       let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address Please"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let passwordField : UITextField = {
        
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password Please"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        field.isSecureTextEntry = true
        return field
    }()
    
    private let logInButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        EmailTextField.delegate = self
        passwordField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        logInButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(EmailTextField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(logInButton)
        view.addSubview(scrollView)
        
    }
    
    
    //set up frames
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = view.width/3
        
        imageView.frame = CGRect(x: (view.width - size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        EmailTextField.frame = CGRect(x: 30,
                                      y: imageView.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: EmailTextField.bottom+10,
                                     width: scrollView.width-60,
                                     height: 52)
        logInButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom+10,
                                   width: scrollView.width-60,
                                   height: 52)
    }
    
    //methods
    
    @objc func didTapRegister(){
        
        let vc = RegistrationViewController()
        vc.title = "Create User Account"
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func didTapLogIn(){
        
        EmailTextField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        
        
        guard let email = EmailTextField.text , let password = passwordField.text,
            !email.isEmpty, !password.isEmpty , password.count >= 6 else {
                
                presentloginError()
            
                return
        }
        
        //Call LogIn
        
        Authmanager.shared.logInUser(email: email, password: password) {[weak self] success in
            
            if success{
                //successfully logged in
                self?.navigationController?.dismiss(animated: true, completion: nil)
                
            }
            else{
                //log in failure
                
                
            }
        }
        
        
    }
    
    //alert function
    
    func presentloginError(){
        
        let alert = UIAlertController(title: "Woops", message: "An error occured while loggin in", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert,animated: true)
        
    }
    

   

}

//extension TextField delegate

extension LogInViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == EmailTextField {
            passwordField.becomeFirstResponder()
        }
        
        else if textField == passwordField{
            didTapLogIn()
        }
        
        return true
    }
    
}
