//
//  RootTableViewCellViewModel.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 18.11.2024.
//

import Foundation

struct RootTableViewCellViewModel: Equatable {
    
    private let task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    public var taskText: String {
        task.taskText
    }
    
    public var description: String {
        task.description
    }
    
    public var isCompleted: Bool {
        task.isCompleted
    }
    
    static func == (lhs: RootTableViewCellViewModel, rhs: RootTableViewCellViewModel) -> Bool {
        lhs.task.id == rhs.task.id
    }
}
