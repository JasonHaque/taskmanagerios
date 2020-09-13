//
//  ProfileViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 12/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit

enum ProfileViewModelType{
    case info , logout
}

struct ProfileViewModel{
    
    let viewModelType : ProfileViewModelType
    let title : String
    let handler : (() -> Void)?
 
}

class ProfileViewController: UIViewController {
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self

        title = "Profile"
        
        view.addSubview(tableView)
    }
    

    

}

extension ProfileViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    
}
