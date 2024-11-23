//
//  Model.swift
//  TO-DO_List
//
//  Created by Глеб Поляков on 18.11.2024.
//

import Foundation

public struct Task {
    public let id: UUID
    public let taskText: String
    public let description: String
    public let isCompleted: Bool
    public let createdAt: Date
    public let deadline: Date
}
