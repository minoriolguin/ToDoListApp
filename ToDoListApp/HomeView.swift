//
//  HomeView.swift
//  ToDoListApp
//
//  Created by Minori Olguin on 2025-10-02.
//
import SwiftUI

struct ButtonStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundStyle(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
                .shadow(radius: 2)
        }
}

struct SaveButtonStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundStyle(.blue)
                .padding()
//                .background(Color.white)
                .cornerRadius(24)
        }
}

extension View {
    func brandButtonStyle() -> some View {
        self.modifier(ButtonStyle())
    }
    func saveButtonStyle() -> some View {
        self.modifier(SaveButtonStyle())
    }
}

struct HomeView: View {
    var body: some View {
        NavigationStack {
            Text("Welcome to the To-Do List App")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
                
                NavigationLink(destination: ToDoListView()) {
                    Text("Go to To-Do List")
                        .padding(.horizontal, 24)
                }
                .modifier(ButtonStyle())
        }
        .tint(.black)
        .padding()
    }
}


#Preview {
    HomeView()
}
