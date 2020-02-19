//
//  TaskRow.swift
//  TodoList
//
//  Created by farnaz on 2020-01-28.
//  Copyright © 2020 farnaz. All rights reserved.
//

import SwiftUI

struct TaskRow: View {
    var task : Task
    var body: some View {
        HStack{           
            VStack{
                HStack{
                    if task.isDone{
                        Text(task.title).font(.headline).strikethrough().foregroundColor(Color.gray)
                    }else{
                        Text(task.title).font(.headline)
                    }
                    Spacer()
                }
                HStack{
                    if !task.isDone{                         Text(task.description).fontWeight(.medium).italic().foregroundColor(.gray)
                        .font(.footnote).padding(.leading, 5).frame( height: 30, alignment: .leading)
                    }
                    
                    
                    Spacer()
                }
                
            }.padding(.leading, 3)
            if task.priority == 2{
                Circle().fill(Color.white)
                    .frame(width: 25, height: 25, alignment: .center).overlay(Circle().stroke(Color.gray))
                    .overlay(Text("!!!").foregroundColor(Color.yellow))
            } else if task.priority == 1{
                Circle().fill(Color.white)
                .frame(width: 25, height: 25, alignment: .center).overlay(Circle().stroke(Color.gray))
                .overlay(Text("!!").foregroundColor(Color.yellow))
            } else if task.priority == 0 {
                Circle().fill(Color.white)
                .frame(width: 25, height: 25, alignment: .center).overlay(Circle().stroke(Color.gray))
                .overlay(Text("!").foregroundColor(Color.yellow))
            }
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    
    static var previews: some View {
        TaskRow(task:Task(id: 1001, creationDate: "2020/01/20", creationDateYear: "2020", creationDateMonth: "02", creationDateDay: "20", dueDate: "2020", time: "12", title: "Finish Todo List", description: "DO IT WRITE hhhhhhhhhhhh hhhhhhhhh hhhhhh hhhhhh hhhhh hhhhhh hhhhhhh", priority: 2, isDone: false))
    }
}
