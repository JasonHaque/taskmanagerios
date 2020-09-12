//
//  RegistrationViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 12/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
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
    
    private let UserNameField : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "User Name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
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
    
    private let RegisterButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemGreen
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
        UserNameField.delegate = self
        passwordField.delegate = self
        
        RegisterButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(UserNameField)
        scrollView.addSubview(EmailTextField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(RegisterButton)
        view.addSubview(scrollView)
        
        
        
    }
    
    //set up frames for views
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let size = view.width/3
        
        imageView.frame = CGRect(x: (view.width - size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        UserNameField.frame = CGRect(x: 30,
                                     y: imageView.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)
        
        
        EmailTextField.frame = CGRect(x: 30,
                                      y: UserNameField.bottom + 10,
                                      width: scrollView.width-60,
                                      height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: EmailTextField.bottom+10,
                                     width: scrollView.width-60,
                                     height: 52)
        RegisterButton.frame = CGRect(x: 30,
                                      y: passwordField.bottom+10,
                                      width: scrollView.width-60,
                                      height: 52)
        
    }
    
    
    //objc methods
    
    @objc func didTapSignUp(){
        
        UserNameField.resignFirstResponder()
        EmailTextField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        //call sign Up
        
    }
    
    
    
    
}

extension RegistrationViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == UserNameField {
            EmailTextField.becomeFirstResponder()
        }
        else if textField == EmailTextField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            didTapSignUp()
        }
        
        return true
    }
}
