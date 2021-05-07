//
//  DefaultsHandler.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import Foundation

struct DefaultsHandler {
    
    func save(task: Task) {
        var tasks: [Task] = [Task]()
        if (self.getTasks() != nil) {
            tasks.append(contentsOf: self.getTasks()!)
        }
        tasks.append(task)
        do {
            let data = try PropertyListEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: "SavedTasks")
        } catch {
            print(error)
        }
    }
    
    func saveState(tasks: [Task]) {
        do {
            let data = try PropertyListEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: "SavedTasks")
        } catch {
            print(error)
        }
    }
    
    func getTasks() -> [Task]? {
        if let tasks = UserDefaults.standard.data(forKey: "SavedTasks") {
            do {
                let tasksArray = try PropertyListDecoder().decode([Task].self, from: tasks)
                return tasksArray
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    func deleteTasks(task: Task) -> [Task]? {
        if let tasks = UserDefaults.standard.data(forKey: "SavedTasks") {
            do {
                var tasksArray = try PropertyListDecoder().decode([Task].self, from: tasks)
                tasksArray = tasksArray.filter{$0.id != task.id}
                
                let data = try PropertyListEncoder().encode(tasksArray)
                UserDefaults.standard.set(data, forKey: "SavedTasks")
                return tasksArray
            } catch {
                print(error)
            }
        }
        return nil
    }
}

//    func modifyTasks() -> Bool {
//
//    }

