//
//  NewTask.swift
//  TodoList
//
//  Created by farnaz on 2020-01-31.
//  Copyright © 2020 farnaz. All rights reserved.
//

import SwiftUI
import UIKit
import SwiftyJSON


struct NewTask: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var taskData: UserData
    @State  var title : String
    @State  var description : String
    @State var priority : Int = 2
    @State var creationDateYear : String
    @State var creationDateMonth : String
    @State var creationDateDay  : String
    
   @State private var didChange = false
   @ObservedObject private var keyboard = KeyboardResponder()
   
    var body: some View {
       // let date = Calendar.current.date(from: components)
        Form{
            Section(header: Text("Detail")){
                TextField("Title", text: $title, onEditingChanged: { (changed) in
                    if changed {
                        if(self.title != "title"){
                            print("title changed")
                            self.didChange = true
                        }
                    }
                })
                TextView(text: $description).frame(numLines: 3)
            }
            Section{
                Picker(selection: $priority, label: Text("Priority")) {
                    Text("High").tag(2)
                    Text("Medium").tag(1)
                    Text("Low").tag(0)                }.pickerStyle(SegmentedPickerStyle()).padding(.leading,20).padding(.trailing,20)
            }.padding()
                .padding(.bottom, keyboard.currentHeight)
                .edgesIgnoringSafeArea(.bottom)
                .animation(.easeOut(duration: 0.16))
        }.navigationBarItems(trailing: Button(action: {
            print(self.didChange)
            if (self.didChange){
                self.taskData.saveNewData(title: self.title, description: self.description, priority: self.priority)
                self.presentationMode.wrappedValue.dismiss()
            }
        }, label:{
            Text("Save")
            }))
    }
    
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        NewTask(title: "", description: "", creationDateYear: "2020", creationDateMonth: "09", creationDateDay: "24")
    }
}

