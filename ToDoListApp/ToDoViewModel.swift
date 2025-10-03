//
//  ToDoViewModel.swift
//  ToDoListApp
//
//  Created by Minori Olguin on 2025-10-02.
//

import Foundation

class ToDoViewModel: ObservableObject {
    @Published var items: [ToDoItem] = [] {
        didSet { save() }
    }

    private let fileName = "todoitems.json"

    
    private var fileURL: URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent(fileName)
    }
    
    init() {
        load()
    }


    func add(_ item: ToDoItem) {
        items.append(item)
    }

    func remove(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func toggleCompleted(for id: UUID) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].isCompleted.toggle()
        }
    }

    private func load() {
        do {
            let data = try Data(contentsOf: fileURL)
            items = try JSONDecoder().decode([ToDoItem].self, from: data)
        } catch {
            items = []
        }
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: fileURL, options: [.atomic])
        } catch {
            print("Error saving tasks: \(error)")
        }
    }
}
