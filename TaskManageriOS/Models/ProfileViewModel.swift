//
//  ProfileViewModel.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 13/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import Foundation


enum ProfileViewModelType{
    case info , logout
}

struct ProfileViewModel{
    
    let viewModelType : ProfileViewModelType
    let title : String
    let handler : (() -> Void)?
 
}
