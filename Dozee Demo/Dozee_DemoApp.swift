//
//  Dozee_DemoApp.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 01/11/20.
//

import SwiftUI

@main
struct Dozee_DemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Dashboard()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: UIApplication.shared.switchHostingController)
                
        }
        
       
    }
    
}

class HostingController: UIHostingController<Dashboard> {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIApplication {
    func switchHostingController() {
        windows.first?.rootViewController = HostingController(rootView: Dashboard()
        )
        
    }
}
