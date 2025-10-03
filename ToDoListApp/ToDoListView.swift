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
            }) {
                Text("Edit")
                    .padding(4)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            
            Text("To-Do List")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            TextField("Search tasks...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            if !todomodel.items.isEmpty {
                List {
                    ForEach($todomodel.items) { $item in
                        if searchText.isEmpty || matches(item) {
                            
                            HStack {
                                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(item.isCompleted ? .green : .gray)
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
            .sheet(isPresented: $isExpanded) {
                AddToDoView { newItem in
                    todomodel.add(newItem)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    ToDoListView()
}
