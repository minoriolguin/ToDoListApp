//
//  AddToDoView.swift
//  ToDoListApp
//
//  Created by Minori Olguin on 2025-10-02.
//
import SwiftUI

struct AddToDoView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var inputTitle: String = ""
    @State private var inputDescription: String = ""
    @State private var inputDate: Date = Date()
    @State private var inputLocation: String = ""
    @State private var hasTitle: Bool = true
    
    var onSave: (ToDoItem) -> Void


    var body: some View {
        VStack(alignment: .leading) {
            Text("Add New Task")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityHeading(.h1)
                .accessibilityHint("This is the add new task page")
            
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $inputTitle)
                        .accessibilityHint("Type the title of the task here")
                    TextField("Description", text: $inputDescription)
                        .accessibilityHint("Type the description of the task here")
                }
                .padding(4)
                
                Section(header: Text("Additional Info")) {
                    DatePicker("Date", selection: $inputDate, displayedComponents: [.date])
                    TextField("Location", text: $inputLocation)
                        .accessibilityHint("Type the location of the task here")
                }
                .padding(4)
            }

            Button(action: {
                if !inputTitle.isEmpty {
                    onSave(ToDoItem(
                        title: inputTitle,
                        description: inputDescription,
                        date: inputDate,
                        location: inputLocation
                    ))
                    dismiss()
                } else {
                   hasTitle = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        hasTitle = true
                    }

                }
                print("Save pressed")
            }) {
                VStack{
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .accessibilityHint("Tap this button to save the task")
                    
                    if !hasTitle {
                        Text("Title is required to save a task.")
                            .foregroundColor(.red)
                            .transition(.opacity)
                    }
                }
                .animation(.easeOut(duration: 1), value: hasTitle)

                
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

