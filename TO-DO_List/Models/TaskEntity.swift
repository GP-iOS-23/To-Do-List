//
//  TaskEntity.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 19.11.2024.
//

import Foundation
import CoreData

@objc(TaskEntity)
public class TaskEntity: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var taskText: String
    @NSManaged public var taskDescription: String
    @NSManaged public var createdAt: Date
    @NSManaged public var deadline: Date
    @NSManaged public var isCompleted: Bool
}
