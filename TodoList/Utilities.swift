//
//  Utilities.swift
//  TodoList
//
//  Created by farnaz on 2020-01-31.
//  Copyright © 2020 farnaz. All rights reserved.
//

import Foundation
func splitDate(date: String) -> (String, String, String) {
    let array = date.components(separatedBy: "/ ")
   
    return (array[0], array[1], array[2])
}
//let dateFormatter = DateFormatter()
//   dateFormatter.dateFormat = "yyyy/mm/dd"
//   let date = dateFormatter.date(from:someDate)!
//   print(date)
//   let calendar = Calendar.current
//   let components = calendar.dateComponents([.year, .month, .day], from: date)
