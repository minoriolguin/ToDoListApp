//
//  EditToDoView.swift
//  ToDoListApp
//
//  Created by Minori Olguin on 2025-10-02.
//

import SwiftUI

struct EditToDoView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var item: ToDoItem
    
    var body: some View {
        Text("Edit Task")
            .font(.title)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        Form {
            Section("Task Details") {
                TextField("Title", text: $item.title)
                TextField("Description", text: $item.description)
            }
            
            Section("Additional Info") {
                DatePicker("Date", selection: $item.date, displayedComponents: [.date])
                TextField("Location", text: $item.location)
            }
            
            Section {
                Toggle("Completed", isOn: $item.isCompleted)
            }
        }
        
        Button(action: {
            dismiss()
            print("Save pressed")
        }) {
            VStack{
                Text("Save")
                    .frame(maxWidth: .infinity)
            }
        }
        .modifier(SaveButtonStyle())
        
    }
}


#Preview {
    HomeView()
}
