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
    @State private var listItems: [ToDoItem] = []
        
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
            
            Text("To-Do List")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("Search tasks...", text: $searchText)
                .textFieldStyle(.roundedBorder)
            
            if !listItems.isEmpty {
                List {
                    ForEach(listItems) { item in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
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
            }
            .sheet(isPresented: $isExpanded) {
                AddToDoView { newItem in
                    listItems.append(newItem)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()

    }
}

struct AddToDoView: View {
    @Environment(\.dismiss) var dissmiss
    
    @State private var inputTitle: String = ""
    @State private var inputDescription: String = ""
    @State private var inputDate: Date = Date()
    @State private var inputLocation: String = ""
    
    let onSave: (ToDoItem) -> Void


    var body: some View {
        VStack(alignment: .leading) {
            Text("Add New Task")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $inputTitle)
                    TextField("Description", text: $inputDescription)
                }
                .padding(4)
                
                Section(header: Text("Additional Info")) {
                    DatePicker("Date", selection: $inputDate, displayedComponents: [.date])
                    TextField("Location", text: $inputLocation)
                }
                .padding(4)
            }

            Button(action: {
                let item = ToDoItem(
                    title: inputTitle,
                    description: inputDescription,
                    date: inputDate,
                    location: inputLocation
                )
                onSave(item)
                dissmiss()
                print("Save pressed")
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
            }
            .modifier(SaveButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .background(Color("LightGrey"))
    }
}

#Preview {
    ToDoListView()
}
