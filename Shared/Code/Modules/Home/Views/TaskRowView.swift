//
//  TaskRowView.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI

struct TaskRowView: View {
    
    // MARK:- variables
    @ObservedObject var task: TaskViewModel
    @State var viewOffset: CGFloat = 2
    @State var deleteOpacity: Double = 0
    
    @EnvironmentObject var taskManager: TaskManager
    @Environment(\.colorScheme) var colorScheme
    
    var index: Int = 0
    let deleteOffset: CGFloat = -40
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                    withAnimation(Animation.easeOut(duration: 0.35)) {
                        viewOffset = deleteOffset
                        deleteOpacity = 1
                    }
                }
                else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                    withAnimation(Animation.easeOut(duration: 0.35)) {
                        viewOffset = 2
                        deleteOpacity = 0
                    }
                }
            }
    }
    
    // MARK:- views
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack {
                Color.getBackgroundColor(colorScheme: colorScheme)
                HStack(spacing: 12) {
                    Button(action: {
                        taskManager.toggleStatusForTask(index: index)
                    }) {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 34, height: 34)
                                .foregroundColor(task.isTaskCompleted ? Color.green : Color.gray.opacity(0.5))
                                .colorMultiply(task.isTaskCompleted ? Color.green : Color.gray.opacity(0.5))
                                .animation(task.isTaskCompleted ? Animation.easeOut(duration: 0.3) : .default)
                            if (task.isTaskCompleted) {
                                Tick(scaleFactor: 0.2)
                                    .trim(from: 0, to: task.isTaskCompleted ? 1 : 0)
                                    .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .miter))
                                    .foregroundColor(Color.white)
                                    .frame(width: 24, height: 24)
                                    .offset(x: -3, y: 3)
                                    .animation(Animation.easeOut(duration: 0.25))
                            }
                        }
                    }
                    ZStack(alignment: .leading) {
                        Text(task.taskName)
                            .font(TypefaceOne.medium.font(size: 20))
                            .colorMultiply(task.isTaskCompleted ? Color.green : Color.label)
                            .animation(Animation.easeOut(duration: 0.3).delay(0.05))
                            .onTapGesture {
                                taskManager.toggleStatusForTask(index: index)
                            }
                        CurveLine()
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color.getColorForStrikeout(colorScheme: colorScheme))
                            .offset(y: 2)
                            .opacity(task.isTaskCompleted ? 1 : 0)
                            .frame(width: task.isTaskCompleted ? task.taskName.getWidth(UIFont(name: "NocturneSerif-Medium", size: 20)!, height: 26.7) : 0, height: 1)
                            .animation(.default)
                    }
                    .offset(x: 8)
                    Spacer()
                }
            }.zIndex(2)
            .offset(x: viewOffset)
            .frame(width: 370)
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.red)
                    Button(action: {
                        taskManager.deleteTask(taskVM: task)
                        self.deleteOpacity = 0
                        withAnimation(.default) {
                            viewOffset = 2
                        }
                    }) {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                .opacity(deleteOpacity)
            }.zIndex(0)
        }.onAppear() {
            self.viewOffset = 2
            
        }.gesture(dragGesture)
    }
    
    // MARK:- functions
    func animate() {
        
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.getBackgroundColor(colorScheme: .dark)
                .edgesIgnoringSafeArea(.all)
            TaskRowView(task: TaskViewModel(task: Task(id: 0, taskName: "Demo Task hehehehehehe", taskCompleted: false, createdDate: Date())))
                .frame(height: 44)
                .padding(24)
        }
        .colorScheme(.dark)
    }
}
