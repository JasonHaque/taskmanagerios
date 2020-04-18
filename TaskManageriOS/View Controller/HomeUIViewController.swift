//
//  HomeUIViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 7/4/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeUIViewController: UIViewController {
    @IBOutlet weak var UserLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let welcome = UserLabel.text!
        UserLabel.text = welcome+" "+(Auth.auth().currentUser?.email)!
    }
    
    @IBAction func LogOutTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
               do {
                 try firebaseAuth.signOut()
                   print("Signed out")
                   self.transitionStart()
               } catch let signOutError as NSError {
                 print ("Error signing out: %@", signOutError)
               }
    }
    
    func transitionStart(){
        let homeView = storyboard?.instantiateViewController(identifier: "StartView") as? ViewController
        view.window?.rootViewController = homeView
        view.window?.makeKeyAndVisible()
    }
    
}
