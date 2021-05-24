//
//  AddItemView.swift
//  To Do List
//
//  Created by Emma Bradford on 2/2/21.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var toDoList: ToDoList
    @State private var priority = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment (\.presentationMode) var presentationMode
    static let priorities = ["High", "Medium", "Low"]
    
    var body: some View {
        NavigationView
        {
            Form
            {
                Picker("Priority", selection: $priority)
                {
                    ForEach(Self.priorities, id: \.self)
                    {
                        priority in Text(priority)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("add new todo item")
            .navigationBarItems(trailing: Button("save")
            {
                if(priority.count > 0 && description.count > 0)
                {
                    let item = ToDoItem(id: UUID(), priority: priority, description: description, dueDate: dueDate)
                    toDoList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(toDoList: ToDoList())
    }
}
