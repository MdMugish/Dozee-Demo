//
//  ContentView.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 01/11/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
//    var viewContext = PersistenceController.shared.container.viewContext
    @StateObject var vm = DeocdeJSONAction()
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SampleDataTwo.time, ascending: true)],
        animation: .default)
    private var data: FetchedResults<SampleDataTwo>

    var body: some View {
        VStack{
            List {
                Text("Hola")
                ForEach(data) { item in
                    VStack{
                        Text("BP Diastole at \(item.bloodPressure!.diastole)")
                        Text("BP Systole at \(item.bloodPressure!.systole)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            
            Button(action : {
                
                let newItem = SampleDataTwo(context: viewContext)
                newItem.heartRate = 78
                newItem.bloodPressure = BloodPressureType(context: viewContext)
                newItem.bloodPressure!.diastole = 99
                newItem.bloodPressure!.systole = 33
                
                do {
                    try viewContext.save()
                } catch {
                    print("Error while saving the data")
                }
                
            }){
                Text("ADD Item")
            }
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

      
        }
    }



    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { data[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
