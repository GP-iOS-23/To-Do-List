//
//  StorageManager.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 19.11.2024.
//

import Foundation
import CoreData
import UIKit

public final class StorageManager: NSObject {
    public static let shared = StorageManager()
    
    private var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    public var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
    
    // MARK: - init
    private override init() { }
    
    public func createEntity(with newTask: Task) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TaskEntity", in: context)
        else {
            print("Failed to create description trying to create entity")
            return
        }
        
        let task = TaskEntity(entity: entityDescription, insertInto: context)
        task.id = newTask.id
        task.taskText = newTask.taskText
        task.taskDescription = newTask.description
        task.isCompleted = newTask.isCompleted
        task.createdAt = newTask.createdAt
        task.deadline = newTask.deadline
        
        appDelegate.saveContext()
    }
    
    public func fetchAllTasks() -> [TaskEntity] {
        do {
            return try context.fetch(fetchRequest) as! [TaskEntity]
        } catch {
            print("Failed to fetch tasks: \(error.localizedDescription)")
            return []
        }
    }
    
    public func fetchTask(with id: UUID) -> TaskEntity? {
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        return fetchAllTasks().first
    }
    
    public func updateTask(with id: UUID, taskText: String = "", description: String = "", deadline: Date) {
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        guard let task = fetchAllTasks().first
        else {
            print("Failed to fetch task to edit")
            return
        }
        
        task.taskText = taskText
        task.taskDescription = description
        task.deadline = deadline
        
        appDelegate.saveContext()
    }
    
    public func deleteAllTasks() {
        do {
            let tasks = try? context.fetch(fetchRequest) as? [TaskEntity]
            tasks?.forEach {
                context.delete($0)
            }
        }
        appDelegate.saveContext()
    }
    
    public func deleteTask(with id: UUID) {
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        guard let task = fetchAllTasks().first
        else {
            print("Failed to fetch task to delete")
            return
        }
        
        context.delete(task)
        appDelegate.saveContext()
    }
}
