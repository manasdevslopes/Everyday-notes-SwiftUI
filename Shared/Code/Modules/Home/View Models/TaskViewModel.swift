//
//  TaskViewModel.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    
    var taskName: String
    let taskId: Int
    let taskDate: String
    var isTaskCompleted: Bool
    var taskCreatedDate: Date
    
    init(task: Task) {
        self.taskId = task.id
        self.taskName = task.taskName
        self.taskCreatedDate = task.createdDate
        self.taskDate = Constants.dayFormatter.string(from: task.createdDate)
        self.isTaskCompleted = task.taskCompleted
    }
    
    func toggleStatus() {
        self.isTaskCompleted.toggle()
    }
}

class TaskManager: ObservableObject {
    
    // MARK:- variables
    let defaultsHandler: DefaultsHandler
    var calender: Calendar
    
    @Published var tasks: [TaskViewModel] = [] {
        didSet {
            self.calculatePercentage()
        }
    }
    
    @Published var finishedTasks = 0
    @Published var totalTasks = 0
    @Published var pendingTasks = 0
    @Published var completionPercentage: Double = 0
    
    lazy var greeting: String = {
        let date = Date()
        guard let hour = Int(Constants.hourFormatter.string(from: date)) else { return "" }
        if (hour > 0 && hour < 12) {
            return "Good Morning,"
        } else if (hour >= 12 && hour < 16) {
            return "Good Afternoon,"
        } else {
            return "Good Evening,"
        }
    }()
    
    // MARK:- inits
    init(defaults: DefaultsHandler = DefaultsHandler()) {
        self.defaultsHandler = defaults
        self.calender = Calendar.current
        self.calender.timeZone = TimeZone.current
        
        fetchAllTasksForDate(date: Date())
    }
    
    // MARK:- functions
    private func fetchAllTasksForDate(date: Date) {
        guard let fetchedTasks = defaultsHandler.getTasks()?.filter({ task -> Bool in
            return self.calender.compare(task.createdDate, to: Date(), toGranularity: .day) == .orderedSame
        }) else { return }
        
        compute(fetchedTasks: fetchedTasks)
    }
    
    func compute(fetchedTasks: [Task]) {
        
        DispatchQueue.main.async {
            self.tasks = fetchedTasks.map {
                TaskViewModel(task: $0)
            }
        }
        self.totalTasks = fetchedTasks.count
        self.pendingTasks = (fetchedTasks.filter{$0.taskCompleted == false}).count
        self.calculatePercentage()
    }
    
    func calculatePercentage() {
        self.finishedTasks = self.totalTasks - self.pendingTasks
        if (self.totalTasks == 0) {
            self.completionPercentage = 0
        } else {
            self.completionPercentage = Double( self.finishedTasks) / Double(self.totalTasks)
        }
    }
    
    func addTask(task: Task) {
        defaultsHandler.save(task: task)
        self.tasks.append(TaskViewModel(task: task))
        
        self.pendingTasks = tasks.filter{$0.isTaskCompleted == false}.count
        self.totalTasks = self.tasks.count
        calculatePercentage()
    }
    
    func deleteTask(taskVM: TaskViewModel) {
        guard let newTasks = self.defaultsHandler.deleteTasks(task: Task(id: taskVM.taskId, taskName: taskVM.taskName, taskCompleted: taskVM.isTaskCompleted, createdDate: taskVM.taskCreatedDate)) else { return }
        compute(fetchedTasks: newTasks)
    }
    
    func toggleStatusForTask(index: Int) {
        self.tasks[index].toggleStatus()
        if (!self.tasks[index].isTaskCompleted) {
            self.finishedTasks -= 1
            self.pendingTasks += 1
        } else  {
            self.finishedTasks += 1
            self.pendingTasks -= 1
        }
        self.defaultsHandler.saveState(tasks: self.tasks.map({Task(id: $0.taskId, taskName: $0.taskName, taskCompleted: $0.isTaskCompleted, createdDate: $0.taskCreatedDate)}))
        calculatePercentage()
    }
}
