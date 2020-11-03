//
//  DeocdeJSON.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 03/11/20.
//

import Foundation

class DeocdeJSONAction : ObservableObject {
    
    
    init(){
        print("DEcode JSON Init()")
        SaveJSON()
    }
    
    func SaveJSON(){
        guard let jsonFilePath = Bundle.main.path(forResource: "Alpha_5", ofType: "json") else {
            fatalError("Unable to load JSON for ListOfForms.json")
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFilePath)) else {
            fatalError("Unable to load data from \(jsonFilePath)")
        }


        do {
       let myData =  try JSONDecoder().decode([SampleDataTwo].self, from: data)
            for data in myData{
                saveToLocal(data: data)
            }
            
        }catch{
            print("Error while decoding \(error)")
        }
        
    }
    
    
    func saveToLocal(data : SampleDataTwo){
        let viewContext = PersistenceController.shared.container.viewContext

        let newItem = SampleDataTwo(context: viewContext)
        newItem.heartRate = data.heartRate
        newItem.bloodPressure = BloodPressureType(context: viewContext)
        newItem.bloodPressure!.diastole = data.bloodPressure?.diastole ?? 0
        newItem.bloodPressure!.systole = data.bloodPressure?.systole ?? 0
        newItem.o2 = data.o2
        newItem.recovery = data.recovery
        newItem.sleepScore = data.sleepScore
        newItem.time = data.time

        print("Data ready for saev \(newItem)")
        do {
            try viewContext.save()
        } catch {
            print("Error while saving the data")
        }
        
    }
  
    
}
