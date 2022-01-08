//
//  TodosView.swift
//  SwiftUIDeepLink
//
//  Created by JeongminKim on 2022/01/07.
//

import SwiftUI

struct TodoItem: Identifiable {
    var id: UUID
    var title: String
}

func prepareData() -> [TodoItem] {
    var newList = [TodoItem]()
    
    for i in 0...20 {
        let newTodo = TodoItem(id: UUID(), title: "Task \(i)")
        print("newTodo.id: \(newTodo.id) / title: \(newTodo.title)")
        newList.append(newTodo)
    }
    
    return newList
}

struct TodosView: View {
    
    @State var todoItems = [TodoItem]()
    @State var activeUUID: UUID?
    
    init() {
        _todoItems = State(initialValue: prepareData())
    }
    
    var body: some View {
        NavigationView {
            List(todoItems) { todoItem in
                
                NavigationLink(
                    destination: Text("\(todoItem.title)"),
                    tag: todoItem.id,
                    selection: $activeUUID, // Move to destination when activeUUID is changed.
                    label: {
                        Text("\(todoItem.title)")
                    })
            }
            .navigationTitle(Text("Todo List"))
            .onOpenURL(perform: { url in
                if case .todoItem(let id) = url.detailPage {
                    print("received id: \(id)")
                    activeUUID = id
                }
                
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
