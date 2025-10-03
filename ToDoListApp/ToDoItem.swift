//
//  ToDoItem.swift
//  ToDoListApp
//
//  Created by Minori Olguin on 2025-10-02.
//
import Foundation

struct ToDoItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var date: Date
    var location: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, description: String, date: Date, location: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.location = location
        self.isCompleted = isCompleted
    }
}
