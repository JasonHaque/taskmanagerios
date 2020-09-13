//
//  ProfileTableViewCell.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 13/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUp(with viewModel : ProfileViewModel){
        
        self.textLabel?.text = viewModel.title
        
        switch viewModel.viewModelType{
            
        case .info:
            self.textLabel?.textAlignment = .left
            self.selectionStyle = .none
        case .logout:
            self.textLabel?.textAlignment = .center
            self.textLabel?.textColor = .red
            
        }
    }
    
    
    
}
