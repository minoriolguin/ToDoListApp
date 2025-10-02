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
    @State private var listItems: [String] = []
        
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
                
            Spacer()
            
            Button(action: {
                isExpanded = true
                print("Add task button tapped")
            }) {
                Text("Add Item")
                    .foregroundStyle(.blue)
            }
            .sheet(isPresented: $isExpanded) {
                AddToDoView()
            }
        }
        .padding()

    }
}

struct AddToDoView: View {
    @Environment(\.dismiss) var dissmiss
    
//    Placeholders
    @State private var itemName: String = ""
    @State private var itemDetails: String = ""
    @State private var itemDueDate: Date = Date()
    @State private var itemLocation: String = ""
//    Replace with to do list item

    var body: some View {
        VStack(alignment: .leading) {
            Text("Add New Task")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $itemName)
                    TextField("Description", text: $itemDetails)
                }
                .padding(4)
                
                Section(header: Text("Additional Info")) {
                    DatePicker("Date", selection: $itemDueDate, displayedComponents: [.date])
                    TextField("Location", text: $itemLocation)
                }
                .padding(4)
            }

            Button(action: {
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
