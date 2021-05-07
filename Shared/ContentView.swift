//
//  ContentView.swift
//  Shared
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: {
                    self.authenticate()
                })
            if isUnlocked {
                TaskView(taskManager: TaskManager())
            }
            
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your notes."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                        print("IsUnlocked")
                    } else {
                        // there was a problem
                        print("IsUnlocked__false")
                        print(authenticationError?.localizedDescription ?? "")
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
