//
//  DeocdeJSON.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 03/11/20.
//

import Foundation
import CoreData

class Api  {
    
    
    init(){
        print("getPosts Init()")
      
    }
    
    
    
    func getPosts(){


        guard let url = URL(string: "https://f2a8b123-adbb-4c6a-beba-f3d3d42eea86.mock.pstmn.io/api/user/data") else {
            print("Somehing wrong with this URL")
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { ( data,_,_) in
            do{
                let newData = try JSONDecoder().decode([SampleDataTwo].self, from: data!)
                self.deleteAllData()
                for data in newData{
                    self.saveToLocal(data: data)
                }
            }catch{
                print("Error \(error)")
            }
        }.resume()
    
    }
    
    
    
    
    func saveToLocal(data : SampleDataTwo){
        
        let viewContext = PersistenceController.shared.container.viewContext

        let newItem = SampleDataTwo(context: viewContext)
        newItem.heartRate = data.heartRate
        newItem.breathRate = data.breathRate
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
  
    
    func deleteAllData(){
        
        let fetchRequest : NSFetchRequest = SampleDataTwo.fetchRequest()

        
        do {
            let result = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)

            print(result.count)

            if result.count > 0 {
                
                for object in result {
                    print(object)
                    PersistenceController.shared.container.viewContext.delete(object)
                }
            }
        } catch{
            print("Delete error")
        }
       
        
    }
    
}



//MARK: Decode JSON File
//        guard let jsonFilePath = Bundle.main.path(forResource: "Alpha_5", ofType: "json") else {
//            fatalError("Unable to load JSON for ListOfForms.json")
//        }

//
//        guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFilePath)) else {
//            fatalError("Unable to load data from \(jsonFilePath)")
//        }

//        do {
//       let myData =  try JSONDecoder().decode([SampleDataTwo].self, from: data)
//            deleteAllData()
//            for data in myData{
//                saveToLocal(data: data)
//            }
//
//        }catch{
//            print("Error while decoding \(error)")
//        }
