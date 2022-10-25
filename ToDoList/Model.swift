//
//  Model.swift
//  ToDoList
//
//  Created by darkhan on 23.10.2022.
//

import Foundation
import UserNotifications
import UIKit



var ToDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoDateKey")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoDateKey") as? [[String: Any]] {
            return  array
        } else {
            return  []
        }
    }
}

func addItem(nameItem: String, isCompleted: Bool = false) {
    ToDoItems.append(["Name": nameItem, "isCompleted": isCompleted])
    setBage()
}

func removeItem(at index: Int) {
    ToDoItems.remove(at: index)
    setBage()
}

func moveItem(fromIndex: Int, toIndex: Int) {
    let from = ToDoItems[fromIndex]
    ToDoItems.remove(at: fromIndex)
    ToDoItems.insert(from, at: toIndex)
}

func changeState(at item: Int) -> Bool {
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    
    setBage()
    return ToDoItems[item]["isCompleted"] as! Bool
}

func requestForNotifications() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
        if isEnabled {
            print("согласие получено")
        } else {
            print("Пришел отказ")
        }
    }
}

func setBage() {
    var totalBageNumber = 0
    for item in ToDoItems {
        if item["isCompleted"] as! Bool == false {
            totalBageNumber += 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = totalBageNumber
}


