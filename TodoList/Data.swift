//
//  Data.swift
//  TodoList
//
//  Created by farnaz on 2020-01-28.
//  Copyright © 2020 farnaz. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation
class UserData : ObservableObject {
    let date = Date()
    let calendar = Calendar.current
    
    @Published var taskData: [Task] = load("taskData")
    func getTask()-> [Task]{
        return taskData
    }
    func saveEditedData(task : Task){
        var result :[Task]
        
        result = save(id: task.id,
                      creationDate: task.creationDate,
                      creationDateYear: task.creationDateYear,
                      creationDateMonth: task.creationDateMonth,
                      creationDateDay: task.creationDateDay,
                      dueDate: task.dueDate,
                      time: task.time,
                      title: task.title,
                      description: task.description,
                      priority: task.priority,
                      isDone: task.isDone, taskData: taskData)
        taskData = result
    }
    func saveNewData(title :String, description :String, priority : Int){
        print("saving...")
        var result :[Task]
        result = save(id: UUID().hashValue,
                      creationDate: self.getDate(),
                      creationDateYear: String(describing:self.calendar.component(.year, from: self.date)),
                      creationDateMonth: String(describing:self.calendar.component(.month, from: self.date)),
                      creationDateDay: String(describing:self.calendar.component(.day, from: self.date)),
                      dueDate: self.getDate(),
                      time: String(describing:self.calendar.component(.timeZone, from: self.date)),
                      title: title,
                      description: description,
                      priority: priority,
                      isDone: false, taskData: taskData)
        taskData = result
        
    }
    func getDate()-> String{
        let creationDate = String(describing:calendar.component(.year, from: date))+"/"+String(describing:calendar.component(.month, from: date))+"/"+String(describing:calendar.component(.day, from: date))
        return creationDate
    }
}

 

func load(_ filename: String) -> [Task] {
    let data: Data
    var fileURL: URL
    do{
        fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("taskData.json")
        print(fileURL)
    }catch {
        print(error)
        return []
    }
    if !FileManager.default.fileExists(atPath: fileURL.path){
        print("the file doesnt exists")
        return []
    }else{
        print(fileURL.path,"exists")
    }
    
    do {
        data = try Data(contentsOf: fileURL)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        let temp = try decoder.decode([String:Array<Task>].self, from: data)
        return temp["items"] ?? []
    } catch {
        print(error)
        fatalError("Couldn't parse \(filename)")
    }
}

func getJsonObj(data :  [Task]) -> [String: [Any]]{
    var dict  = ["items":[]]
    var array: [[String:Any]] = []
    for item in data{
        var newItem : [String: Any] = [:]
        newItem["id"] = item.id
        newItem["creationDate"] = item.creationDate
        newItem["creationDateYear"] = item.creationDateYear
        newItem["creationDateMonth"] = item.creationDateMonth
        newItem["creationDateDay"] = item.creationDateDay
        newItem["dueDate"] = item.dueDate
        newItem["time"] = item.time
        newItem["title"] = item.title
        newItem["description"] = item.description
        newItem["priority"] = item.priority
        newItem["isDone"] = item.isDone
        array.append(newItem)
    }
    dict["items"] = array
    return dict
}
func save(taskData:[Task]){
    if var data = taskData as? [Task]{
        let dictionary: [String: [Any]] = getJsonObj(data: data)
        //            let fileName = "taskData"
        
        do{
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("taskData.json")
            do {
                try JSONSerialization.data(withJSONObject: dictionary,options:.prettyPrinted).write(to: fileURL)
                print("save to ", fileURL.path)
                print(fileURL.absoluteString)
                if FileManager.default.fileExists(atPath: fileURL.path){
                    print("the file exists1")
                }else{
                    print("thie file not exist1")
                }
            } catch  {
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}
func save (id : Int, creationDate: String, creationDateYear: String, creationDateMonth : String, creationDateDay : String, dueDate : String, time : String, title: String, description : String , priority : Int, isDone : Bool, taskData: [Task])-> [Task]{
    
    let newTask = Task(id: id,
                       creationDate: creationDate,
                       creationDateYear: creationDateYear,
                       creationDateMonth: creationDateMonth,
                       creationDateDay:  creationDateDay,
                       dueDate: creationDate,
                       time: time,
                       title: title,
                       description: description,
                       priority: priority,
                       isDone: isDone)
    
    if var data = taskData as? [Task]{
        if !taskExist(task: newTask, data: data).1{
            data.append(newTask)
            print("task does not exist creating new one")
            let dictionary: [String: [Any]] = getJsonObj(data: data)
            //            let fileName = "taskData"
            
            do{
                let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("taskData.json")
                do {
                    try JSONSerialization.data(withJSONObject: dictionary,options:.prettyPrinted).write(to: fileURL)
                    
                    print("save to ", fileURL.path)
                    print(fileURL.absoluteString)
                    if FileManager.default.fileExists(atPath: fileURL.path){
                        print("the file exists1")
                    }else{
                        print("thie file not exist1")
                    }
                } catch  {
                    print(error.localizedDescription)
                }
            }catch{
                print(error.localizedDescription)
            }
            
            return data
        } else{
            let editedData = taskExist(task: newTask, data: data).0
            let dictionary: [String: [Any]] = getJsonObj(data: editedData)
            //            let fileName = "taskData"
            
            do{
                let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("taskData.json")
                do {
                    try JSONSerialization.data(withJSONObject: dictionary,options:.prettyPrinted).write(to: fileURL)
                    print("save to ", fileURL.path)
                    print(fileURL.absoluteString)
                    if FileManager.default.fileExists(atPath: fileURL.path){
                        print("the file exists1")
                    }else{
                        print("thie file not exist1")
                    }
                } catch  {
                    print(error.localizedDescription)
                }
            }catch{
                print(error.localizedDescription)
            }
            return editedData
        }
    }
    return taskData
}

func taskExist(task: Task, data: [Task]) -> ([Task],Bool){
    var count  = 0
    if var taskData = data as? [Task]{
        for item in taskData {
            if item.id == task.id{
                taskData[count].creationDate = task.creationDate
                taskData[count].creationDateDay = task.creationDateDay
                taskData[count].creationDateMonth = task.creationDateMonth
                taskData[count].creationDateYear = task.creationDateYear
                taskData[count].description = task.description
                taskData[count].dueDate = task.dueDate
                taskData[count].isDone = task.isDone
                taskData[count].priority = task.priority
                taskData[count].time = task.time
                taskData[count].title = task.title
                return (taskData, true)
            }
            count += 1
        }
    }
    return (data, false)
}
