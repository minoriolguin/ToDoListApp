//
//  ToDoItem.swift
//  ToDoListApp
//
//  Created by Minori Olguin on 2025-10-02.
//
import SwiftUI

struct ToDoItem: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var date: Date
    var location: String
    var isCompleted: Bool = false
}
