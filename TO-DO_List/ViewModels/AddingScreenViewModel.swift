//
//  AddingScreenViewModel.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 19.11.2024.
//

import Foundation

final class AddindScreenViewModel {
    
    // MARK: - init
    init() {}
    
    public func saveData(task: Task) {
        NotificationCenter.default.post(name: .didAddTask, object: task)
    }
}
