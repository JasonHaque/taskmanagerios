//
//  ProfileViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 12/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit



class ProfileViewController: UIViewController {
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return table
    }()
    
    var data = [ProfileViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self

        title = "Profile"
        
        let name = UserDefaults.standard.value(forKey: "userName") as? String
        let email = UserDefaults.standard.value(forKey: "email") as? String
        
        data.append(ProfileViewModel(viewModelType: .info, title: "Name : \(name!)", handler: nil))
        data.append(ProfileViewModel(viewModelType: .info, title: "Email : \(email!)", handler: nil))
        data.append(ProfileViewModel(viewModelType: .logout, title: "Log Out", handler: {
            
            //add log out code
            print("Logging you out")
            
            self.showLogOutAction()
        }))
        
        view.addSubview(tableView)
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    func showLogOutAction(){
        let actionsheet = UIAlertController(title: "Log Out", message: "Are you sure you want to proceed?", preferredStyle: .actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
            
            self?.logOut()
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionsheet,animated: true)
    }
    
    func logOut(){
        Authmanager.shared.logUserOut { [weak self] loggedOut in
            if loggedOut{
                DispatchQueue.main.async {
                    let vc = LogInViewController()
                    vc.title = "Log In"
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    self?.present(nav,animated: false)
                }
            }
            else{
                
                //this shouldn't bloody happen
                
            }
        }
    }

}

extension ProfileViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        let model = data[indexPath.row]
        
        cell.setUp(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        data[indexPath.row].handler?()
        
    }
    
    
}
