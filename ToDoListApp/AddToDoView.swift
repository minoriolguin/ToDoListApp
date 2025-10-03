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
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        hasTitle = true
                    }

                }
                print("Save pressed")
            }) {
                VStack{
                    Text("Save")
                        .frame(maxWidth: .infinity)
                    
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

