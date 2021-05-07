//
//  TaskAdditionView.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI
import Combine

struct TaskAdditionView: View {
    
    // MARK:- variables
    @Binding var addTaskPressed: Bool
    @State var barOffset: CGFloat = UIScreen.main.bounds.height / 1.875
    @State var enteredTask = ""
    @State var titleText = "New Task"
    
    @State var focusTextfield: Bool = false
    @State var keyboardHeight: CGFloat = 0
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var taskManager: TaskManager
    
    let animationDuration: TimeInterval = 0.4
    var onTap: () -> () = {}
    var onDismiss: () -> () = {}
    
    
    // MARK:- views
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .foregroundColor(Color.label)
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .center) {
                        Text(DateManager().getCurrentDate())
                            .foregroundColor(.background)
                            .font(TypefaceOne.semibold.font(size: 20))
                        Text(DateManager().getCurrentDay())
                            .foregroundColor(.background)
                        
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.background.opacity(0.7), lineWidth: 2)
                            .frame(width: 56, height: 56)
                            .foregroundColor(.background)
                    ).offset(x: 12)
                    
                    Spacer()
                    Text(self.addTaskPressed ? titleText : "\(self.taskManager.totalTasks == 0 ? "No Task" : self.taskManager.totalTasks == 1 ? "\(taskManager.totalTasks) Task" : "\(taskManager.totalTasks) Tasks")")
                        .foregroundColor(.background)
                        .font(TypefaceOne.semibold.font(size: 26))
                        .frame(alignment: Alignment(horizontal: .leading, vertical: .center))
                        .animation(Animation.default)
                    Spacer()
                    Button(action: {
                        // open notes add
                        if (self.addTaskPressed) {
                            dismiss()
                        } else {
                            onTap()
                        }
                        self.addTaskPressed.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.getColorForTick(colorScheme: colorScheme))
                            .font(.system(size: 24, weight: .bold, design: .monospaced))
                            .rotationEffect(self.addTaskPressed ? .degrees(43) : .degrees(0))
                    }
                }.padding(.top, 24)
                .padding([.leading, .trailing],8)
                Text("Task Name")
                    .foregroundColor(Color.background)
                    .font(TypefaceOne.semibold.font(size: 19))
                    .padding(.top, 48)
                CustomTextField(placeholderView: {
                    Text("Enter Task Here")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.background)
                        .opacity(0.5)
                }, entry: $enteredTask, viewFocused: $focusTextfield, commit: {
                    addTask()
                })
                .onTapGesture {
                    focusTextfield = true
                }
                .animation(.default)
                
                Button(action: {
                    addTask()
                }) {
                    HStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 180, height: 48)
                            .foregroundColor(.background)
                            .overlay(
                                Text("Add Task")
                                    .foregroundColor(.label)
                                    .accentColor(Color.label.opacity(0.8))
                                    .font(TypefaceOne.bold.font(size: 22))
                            )
                            .offset(y: -6)
                        Spacer()
                    }
                    .padding(.top, 42)
                }.frame(alignment: .center)
            }.padding([.leading, .trailing], 24)
        }.edgesIgnoringSafeArea(.all)
        .frame(height: self.addTaskPressed ? 340 : 64)
        .offset(y: self.addTaskPressed ? 110 : barOffset)
        .offset(y: keyboardHeight)
        .animation(Animation.default)
        .onReceive(Publishers.keyboardHeight) {
            let newHeight = $0
            withAnimation(Animation.default) {
                self.keyboardHeight = -newHeight * 1.05
            }
            print("keyboard height", self.keyboardHeight)
        }
    }
    
    
    // MARK:- functions
    func dismiss() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        self.titleText = "Add New Task"
        self.enteredTask = ""
        self.focusTextfield = false
        onDismiss()
    }
    
    func addTask() {
        if (enteredTask.count > 0) {
            taskManager.addTask(task:  Task(id: Int.random(in: 4..<4000), taskName: enteredTask, taskCompleted: false, createdDate: Date()))
            dismiss()
            //                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.addTaskPressed.toggle()
            //                        }
        } else {
            self.titleText = "Invalid Task name"
        }
    }
}

struct TaskAdditionView_Previews: PreviewProvider {
    static var previews: some View {
//        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            TaskAdditionView(addTaskPressed: .constant(false))
                .environmentObject(TaskManager())
//        }
    }
}
