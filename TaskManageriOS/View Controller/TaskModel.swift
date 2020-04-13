//
//  TaskModel.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 13/4/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

class TaskModel{
    var id : String?
    var taskName : String?
    var taskDec : String?
    
    init(id : String?,taskName:String?,taskDesc:String?) {
        self.id = id
        self.taskName = taskName
        self.taskDec = taskDesc
    }
}
