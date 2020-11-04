//
//  Dozee_DemoApp.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 01/11/20.
//

import SwiftUI
import CoreData

@main
struct Dozee_DemoApp: App {


    let persistenceController = PersistenceController.shared
    @StateObject var dashboardVM : DashboardViewModel
    
    init(){
        let managedObjectContext = persistenceController.container.viewContext
        let storage = DashboardViewModel(viewContext: managedObjectContext)
        self._dashboardVM = StateObject(wrappedValue: storage)
    }
    
    var body: some Scene {
        WindowGroup {
            Dashboard(dashboardVM: dashboardVM)
                .onAppear(perform: {
                    Api().getPosts()
                })
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .onAppear(perform: UIApplication.shared.switchHostingController)
                
        }
        
       
    }
    
}

//class HostingController: UIHostingController<ContentView> {
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//}
//
//extension UIApplication {
//    func switchHostingController() {
//        windows.first?.rootViewController = HostingController(rootView: ContentView()
//        )
//
//    }
//}
