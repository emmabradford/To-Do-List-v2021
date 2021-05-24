//
//  ContentView.swift
//  To Do List
//
//  Created by Emma Bradford on 1/28/21.
//

import SwiftUI

struct ContentView: View
{
    @ObservedObject var toDoList = ToDoList()
    @State private var showingAddItemView = false
    
    var body: some View
    {
        NavigationView
        {
            List
            {
                ForEach(toDoList.items)
                {
                    item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.priority).font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform:
                {
                    indices, newOffset in toDoList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    toDoList.items.remove(atOffsets: indexSet)
                })
            }
            .sheet(isPresented: $showingAddItemView, content:
            {
                AddItemView(toDoList: toDoList)

            })
            .navigationBarTitle("To Do List")
            .navigationBarItems(leading: EditButton(), trailing: Button(action:
            {
                showingAddItemView = true})
            {
                Image(systemName: "plus")
            })
            //.navigationBarTitle("Add new to do item")
            
        }
            //.padding()
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}

struct ToDoItem : Identifiable, Codable
{
    var id = UUID()
    var priority = String()
    var description = String()
    var dueDate = Date()
}

