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
            .accessibilityHeading(.h1)
            .accessibilityLabel("This is the edit task page")
        
        Form {
            Section("Task Details") {
                TextField("Title", text: $item.title)
                    .accessibilityHint("Edit the title of the task here")
                TextField("Description", text: $item.description)
                    .accessibilityHint("Edit the description of the task here")
            }
            
            Section("Additional Info") {
                DatePicker("Date", selection: $item.date, displayedComponents: [.date])
                TextField("Location", text: $item.location)
                    .accessibilityHint("Edit the location of the task here")
            }
            
            Section {
                Toggle("Completed", isOn: $item.isCompleted)
                    .accessibilityLabel("Task completion toggle")
                    .accessibilityHint(item.isCompleted
                                ? "Press this button to set the task as not completed"
                                : "Press this button to set the task as completed")
            }
        }
        
        Button(action: {
            dismiss()
            print("Save pressed")
        }) {
            VStack{
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .accessibilityHint("Tap this button to save your edits")
            }
        }
        .modifier(SaveButtonStyle())
        
    }
}


#Preview {
    HomeView()
}
