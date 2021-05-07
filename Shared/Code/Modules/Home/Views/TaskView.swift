//
//  TaskView.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import Combine
import SwiftUI

struct TaskView: View {
    
    // MARK:- variables
    @State var addTaskPressed: Bool = false
    @State var viewAppeared = false
    
    @State var blurRadius: CGFloat = 0
    @State var oldPercentage: CGFloat = 0
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var taskManager: TaskManager
    
    let screenWidth: CGFloat =  UIScreen.main.bounds.width - 48
    
    // MARK:- views
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            Color.getBackgroundColor(colorScheme: colorScheme)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                TopBar(viewAppeared: $viewAppeared)
                    .environmentObject(taskManager)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Today's Progress")
                            .font(TypefaceTwo.medium.font(size: 20))
                            .textCase(.uppercase)
                            .opacity(self.viewAppeared ? 0.65 : 0)
                            .foregroundColor(Color.label)
                            .opacity(self.viewAppeared ? 1 : 0)
                        Spacer()
                        Text("\(Double(self.taskManager.completionPercentage * 100).clean(places: 1))%")
                            .foregroundColor(Color.label)
                            .font(TypefaceTwo.bold.font(size: 28))
                    }
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .opacity(0.35)
                            .foregroundColor(Color.label)
                            .shadow(color: Color.label, radius: 4)
                        Rectangle()
                            .frame(width: screenWidth * CGFloat(taskManager.completionPercentage))
                            .foregroundColor(Color.green)
                            .animation(Animation.easeOut(duration: 0.25).delay(0.3))
                    }.cornerRadius(45.0)
                    .frame(width: screenWidth, height: 8)
                }.padding(.top, 32)
                .opacity(progressOpacity)
                VStack(alignment: .leading) {
                    Text("Your Tasks")
                        .font(TypefaceOne.medium.font(size: 30))
                        .foregroundColor(Color.label)
                        .shadow(color: Color.label.opacity(0.35), radius: 0.5)
                        .padding(.top, 24)
                        .padding(.bottom, 20)
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(Array(zip(taskManager.tasks.indices, taskManager.tasks)), id: \.0) { (index, taskViewModel) in
                            TaskRowView(task: taskManager.tasks[index], index: index)
                                .frame(height: 44)
                                .environmentObject(taskManager)
                                .padding(.bottom, 20)
                                .opacity(self.viewAppeared ? 1 : 0)
                        }
                    }.padding(.bottom, 32)
                }.opacity(taskListOpacity)
                Spacer()
            }.padding(24)
            .blur(radius: blurRadius)
            TaskAdditionView(addTaskPressed: $addTaskPressed) {
                withAnimation(Animation.easeOut(duration: 0.4)) {
                    self.blurRadius = 6
                }
            } onDismiss: {
                withAnimation(Animation.easeOut(duration: 0.3)) {
                    self.blurRadius = 0
                }
            }
            .offset(y: taskAddViewYOffset)
            .offset(y: UIScreen.main.bounds.height / 2.25)
            .environmentObject(taskManager)
            if (taskManager.completionPercentage == 1) {
                SuccessView(thumbsColor: Color.label, blurRadius: $blurRadius)
                    .opacity(taskManager.completionPercentage == 1 ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 0.35).delay(0.2))
                    .offset(y: -100)
            }
            PatternOne(colorOne: Color.blue.opacity(0.1), colorTwo: Color.gray.opacity(0.1))
                .opacity(0.25)
                .scaleEffect(2)
                .rotationEffect(.degrees(90))
                .offset(x: 140)
        }.onAppear() {
            self.viewAppeared.toggle()
            
            withAnimation(Animation.easeOut(duration: 0.3).delay(0.25)) {
                progressOpacity = 1
            }
            
            withAnimation(Animation.easeIn(duration: 0.3).delay(0.3)) {
                taskListOpacity = 1
            }
            
            withAnimation(Animation.easeIn(duration: 0.2).delay(0.1)) {
                self.taskAddViewYOffset = 0
            }
        }
    }
    
    @State var progressOpacity: Double = 0
    @State var taskListOpacity: Double = 0
    @State var taskAddViewYOffset: CGFloat = 100
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(taskManager: TaskManager())
            .colorScheme(.light)
    }
}


extension Double {
    
    func clean(places: Int) -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.\(places)f", self)
    }
}


extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
