//
//  ToDoListView.swift
//  ToDoListApp
//
//  Created by Minori Olguin on 2025-10-02.
//

import SwiftUI

struct ToDoListView: View {
    @State private var searchText: String = ""
    @State private var isExpanded: Bool = false
    @StateObject private var todomodel = ToDoViewModel()
    @State private var editMode: EditMode = .inactive
    @State private var editingIndex: Int? = nil
        
    private func matches(_ item: ToDoItem) -> Bool {
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        func contains(_ s: String?) -> Bool {
            (s ?? "").lowercased().contains(search)
        }

        return contains(item.title) ||
               contains(item.description) ||
               contains(item.location)
    }
    
    var body: some View {
        VStack {
            Button(action: {
                print("Edit button tapped")
                editMode = (editMode == .active ? .inactive : .active)
            }) {
                if editMode == .active {
                    Image(systemName: "checkmark")
                        .padding(12)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .accessibilityLabel("checkmark")
                        .accessibilityHint("Tap this button to finish editing task list")
                } else {
                    Text("Edit")
                        .padding(13)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .accessibilityLabel("Edit")
                        .accessibilityHint("Tap this button to edit task list")
                }
            }
            .clipShape(.circle)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text("To-Do List")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .accessibilityHeading(.h1)
                .accessibilityLabel("To-Do List")

            TextField("Search tasks...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .accessibilityHint("Enter a search term to filter tasks")
            
            let filteredIndices = todomodel.items.indices.filter { i in
                searchText.isEmpty || matches(todomodel.items[i])
            }
            
            if !todomodel.items.isEmpty {
                List {
                    ForEach(filteredIndices, id: \.self) { i in
                        HStack {
                            Image(systemName: todomodel.items[i].isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(todomodel.items[i].isCompleted ? .green : .gray)
                                .onTapGesture {
                                    todomodel.items[i].isCompleted.toggle()
                                    .accessibilityLabel(item.isCompleted ? "Task completed" : "Task not completed")
                                    .accessibilityHint(item.isCompleted ? "Tap this button to mark this task as not completed"
                                                                        : "Tap this button to mark this task as completed")
                                }

                            VStack(alignment: .leading, spacing: 4) {
                                if !todomodel.items[i].title.isEmpty {
                                    Text(todomodel.items[i].title)
                                        .font(.title2)
                                        .bold()
                                        .strikethrough(todomodel.items[i].isCompleted)
                                }
                                if !todomodel.items[i].description.isEmpty {
                                    Text(todomodel.items[i].description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Text(todomodel.items[i].date, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                if !todomodel.items[i].location.isEmpty {
                                    Text(todomodel.items[i].location)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if editMode == .active {
                                editingIndex = i
                            } else {
                                todomodel.items[i].isCompleted.toggle()
                            }
                        }
                    }
                    .onDelete { offsets in
                        let real = IndexSet(offsets.map { filteredIndices[$0] })
                        todomodel.remove(at: real)
                    }
                }
            } else {
                Spacer()
            }
                            
            Button(action: {
                isExpanded = true
                print("Add task button tapped")
            }) {
                Text("Add Item")
                    .foregroundStyle(.blue)
                    .padding()
            }
            .accessibilityLabel("Add new task")
            .accessibilityHint("Tap this button to open the add task sheet")
            .sheet(isPresented: $isExpanded) {
                AddToDoView { newItem in
                    todomodel.add(newItem)
                }
            }
        }
        .sheet (
            isPresented: Binding(
                get: { editingIndex != nil },
                set: { if !$0 { editingIndex = nil } }
            )
        ) {
            if let i = editingIndex, todomodel.items.indices.contains(i) {
                EditToDoView(item: $todomodel.items[i])
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.editMode, $editMode)
    }
}


#Preview {
    ToDoListView()
}
