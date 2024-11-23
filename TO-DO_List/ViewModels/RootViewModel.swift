//
//  RootViewModel.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 18.11.2024.
//

import Foundation
import CoreData

protocol RootViewModelDelegate: AnyObject {
    func didFetchTasks()
    func didUpdateTasks()
}

final class RootViewModel: NSObject {
    
    public weak var delegate: RootViewModelDelegate?
    private lazy var fetchedResultsController: NSFetchedResultsController<TaskEntity> = {
        let fetchRequest = NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: StorageManager.shared.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        frc.delegate = self
        return frc
    }()
    
    public var numberOfTasks: Int {
        fetchedResultsController.fetchedObjects?.count ?? 0
    }
    public private(set) var cellViewModels: [RootTableViewCellViewModel] = []
    
    // MARK: - init
    override init() {
        super.init()
    }
    
    public func fetchTasks() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Can't fetch tasks: \(error.localizedDescription)")
        }
        delegate?.didFetchTasks()
    }
    
    public func getTask(for indexPath: IndexPath) -> Task{
        let taskEntity = fetchedResultsController.object(at: indexPath)
        return Task(
            id: taskEntity.id,
            taskText: taskEntity.taskText,
            description: taskEntity.taskDescription,
            isCompleted: taskEntity.isCompleted,
            createdAt: taskEntity.createdAt,
            deadline: taskEntity.deadline
        )
    }
    
    public func deleteTask(for indexPath: IndexPath) {
        let task = getTask(for: indexPath)
        StorageManager.shared.deleteTask(with: task.id)
    }
    
    public func addNewTask(with task: Task) {
        StorageManager.shared.createEntity(with: task)
        delegate?.didUpdateTasks()
    }
}

extension RootViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        delegate?.didUpdateTasks()
    }
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        delegate?.didUpdateTasks()
    }
}
