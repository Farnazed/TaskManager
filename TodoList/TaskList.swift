//
//  TaskList.swift
//  TodoList
//
//  Created by farnaz on 2020-01-28.
//  Copyright © 2020 farnaz. All rights reserved.
//

import SwiftUI

struct TaskList: View {
    @State var tag:Int? = nil
    @State private var showModal = false
    @EnvironmentObject var taskData: UserData
    @State var showImportantsOnly = false
    @State var inNewTaskView : Bool = false
var checkmark = ""
    var body: some View {
        Group{
            NavigationView{
                VStack{
                    List{
                        Toggle(isOn: $showImportantsOnly) {
                            Text("Importants only")
                        }
                        ForEach(taskData.taskData){ task in
                            if !self.showImportantsOnly || task.priority==2{
                                HStack{
                                    Image(systemName: "circle.fill").resizable().frame(width: 5.0 , height: 5.0)
                                        .foregroundColor(.gray)
                                                                               
//                                    if task.isDone {
//                                        Image(systemName: "checkmark.circle.fill")
//                                            .foregroundColor(.green)
//
//                                    }
//                                    else{
//                                        Image(systemName: "circle")
//                                            .foregroundColor(.green)
//                                    }
                                    NavigationLink(destination: TaskItem(task: task)) {
                                        TaskRow(task: task)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    .onMove(perform: move)
                    }
                    .navigationBarTitle("Todo List")
                        .navigationBarItems(trailing:EditButton())

                    NavigationLink(destination: NewTask(title: "", description: "", priority: 2, creationDateYear: "2020", creationDateMonth: "12",creationDateDay: "06"), tag: 1, selection: self.$tag) {
                        EmptyView()
                    }
                }
                
            }
            HStack{
                Spacer()
                
                if !inNewTaskView{
                    Button(action: {
                        self.tag = 1
                        print("save was pressed")
                    }, label: {
                        Image(systemName: "plus.circle.fill").padding(.bottom, CGFloat(integerLiteral: 10))
                        Text("Add Task").padding(.trailing, CGFloat(integerLiteral: 10)).padding(.bottom, CGFloat(integerLiteral: 10)).font(Font.headline)
                    })
                }
            }
        }
        
    }
    func delete(at offsets: IndexSet) {
        taskData.taskData.remove(atOffsets: offsets)
        
        save(taskData: taskData.taskData)
    }
    func move (from source : IndexSet, to destination : Int){
        taskData.taskData.move(fromOffsets: source, toOffset: destination)
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
    }
}
