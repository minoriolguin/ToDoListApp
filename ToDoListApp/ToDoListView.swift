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
            
            if !todomodel.items.isEmpty {
                List {
                    ForEach($todomodel.items) { $item in
                        if searchText.isEmpty || matches(item) {
                            
                            HStack {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .green : .gray)
                                    .accessibilityLabel(item.isCompleted ? "Task completed" : "Task not completed")
                                    .accessibilityHint(item.isCompleted ? "Tap this button to mark this task as not completed"
                                                                        : "Tap this button to mark this task as completed")
                                    .onTapGesture {
                                        item.isCompleted.toggle()
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    if !item.title.isEmpty {
                                        Text(item.title)
                                            .font(.title2)
                                            .bold()
                                            .strikethrough(item.isCompleted)
                                    }
                                    
                                    if !item.description.isEmpty {
                                        Text(item.description)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Text(item.date, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    if !item.location.isEmpty {
                                        Text(item.location)
                                            .font(.caption)
                                            .foregroundColor(.gray)

                                    }
                                    
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .onDelete{ offsets in
                        todomodel.remove(at: offsets) }
                }
            }
            else {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.editMode, $editMode)
    }
}


#Preview {
    ToDoListView()
}
