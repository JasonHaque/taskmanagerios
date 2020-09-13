//
//  HomeUIViewController.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 12/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit
import Firebase

class HomeUIViewController: UIViewController {
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var data = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Tasks"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapCreateNewTask))

        checkAuthStatus()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkAuthStatus()
        
        startListeningForTasks()
        view.addSubview(tableView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func checkAuthStatus(){
        
        if Auth.auth().currentUser == nil{
            
            let vc = LogInViewController()
            vc.title = "Log In"
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav,animated: false)
        }
        
    }
    
    private func startListeningForTasks(){
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else{
            return
        }
        DatabaseManager.shared.getAllTasks(with: email) { [weak self] result in
            
            switch result{
                
            case .success(let tasks):
                print(tasks)
                self?.data = tasks
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print("Shitty error \(error)")
            }
        }
    }
    
    //objc methods
    
    @objc func didTapCreateNewTask(){
        
        let vc = NewTaskViewController()
        vc.title = "Create a task"
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav,animated: false)
        
        
    }

  

}

extension HomeUIViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row].taskName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = data[indexPath.row]
        
        let vc = ShowTaskViewController(task: model)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let id = data[indexPath.row].taskId
            
            tableView.beginUpdates()
            
            DatabaseManager.shared.deleteTask(with: id) {[weak self] success in
                if success{
                    
                }
                else{
                    self?.data.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .left)
                }
            }
            tableView.endUpdates()
        }
    }
}
