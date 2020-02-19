//
//  ContentView.swift
//  TodoList
//
//  Created by farnaz on 2020-01-23.
//  Copyright © 2020 farnaz. All rights reserved.
//

import SwiftUI
import Foundation
struct TaskItem: View {
    @State var task : Task
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var taskData: UserData
    @ObservedObject private var keyboard = KeyboardResponder()
    var body: some View {        
        VStack{
        Form{
            
            Section(header: Text("Details").font(.headline)){
                HStack{
                    TextField("Title", text: $task.title ).font(Font.headline)
                    
                }
                TextField("Description", text: $task.description)
                    .font(Font.body)
            }
            Section{
                Toggle("Mark as Done", isOn: $task.isDone)
            }
            Section{
                Picker(selection: $task.priority, label: Text("priority")) {
                    Text("High").tag(2)
                    Text("Medium").tag(1)
                    Text("Low").tag(0)
                }.pickerStyle(SegmentedPickerStyle()).padding(5)
            }
        }
        .padding(.bottom, keyboard.currentHeight)
        .edgesIgnoringSafeArea(.bottom)
        .animation(.easeOut(duration: 0.16))
        .navigationBarItems(trailing: Button(action: {

            self.taskData.saveEditedData(task: self.task)
            self.presentationMode.wrappedValue.dismiss()
        }, label:{
            Text("save")
        }))
            Spacer()
            GADBannerViewController().frame( height: 50, alignment: .center)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItem(task: Task(id: 1001, creationDate: "2020/01/20", creationDateYear: "2020", creationDateMonth: "02", creationDateDay: "20", dueDate: "2020", time: "12", title: "Finish Todo List", description: "DO IT WRITE", priority: 1, isDone: false))
    }
}
