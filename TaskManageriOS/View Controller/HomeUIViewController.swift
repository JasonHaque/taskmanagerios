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
        UserLabel.text = Auth.auth().currentUser?.email
    }
    

}
