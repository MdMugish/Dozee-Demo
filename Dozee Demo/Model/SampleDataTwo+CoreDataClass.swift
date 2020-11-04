//
//  SampleDataTwo+CoreDataClass.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 03/11/20.
//
//

import Foundation
import CoreData

@objc(SampleDataTwo)
public class SampleDataTwo: NSManagedObject, Codable {

    
    enum CodingKeys : String, CodingKey {
        case bloodPressure = "Blood Pressure", breathRate = "BreathRate", heartRate = "HeartRate", o2 = "O2", recovery = "Recovery", sleepScore = "sleepscore", time = "time", bp = "BP"
    }
    
    public func encode(to encoder : Encoder) throws {
        var container = encoder.container(keyedBy : CodingKeys.self)
        
        try container.encode(bloodPressure, forKey : .bloodPressure)
        try container.encode(breathRate, forKey: .breathRate)
        do{
            try container.encode(heartRate, forKey : .heartRate)
        }catch{
            print("HeartRate not found")
        }
        try container.encode(o2, forKey : .o2)
        try container.encode(recovery, forKey : .recovery)
        try container.encode(sleepScore, forKey: .sleepScore)
        try container.encode(time, forKey : .time)
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SampleDataTwo", in: PersistenceController.shared.container.viewContext) else {
            fatalError("Error white decoding recentChats \(Error.self)")
        }
    
        self.init(entity : entity, insertInto : nil)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)

        do{
            bloodPressure = try values.decode(BloodPressureType.self, forKey : .bloodPressure)
        }catch{
            print("bloodPressure not found")
            bloodPressure = try values.decodeIfPresent(BloodPressureType.self, forKey: .bp)
        }
        
        do{
            breathRate = Int32(try values.decode(Int.self, forKey : .breathRate))
        }catch{
            
           
            print("breathRate not found")
        }
        
        
        do{
            heartRate = try Int32(values.decode(Int.self, forKey : .heartRate))
        }catch{
            print("HeartRate Not Found 2")
        }
        
        do{
            o2 = try Int32(values.decode(Int.self, forKey : .o2))
        }catch{
            print("O2 not found")
        }
        
        do{
            sleepScore = try Int32(values.decode(Int.self, forKey : .sleepScore))
        }catch{
            print("SleepScore not found")
        }
        
        do{
            time = try Int64(values.decode(Int.self, forKey : .time))
        }catch{
            print("Time not found")
        }
        
        
        
        do{
            recovery = try Int32(values.decode(Int.self, forKey : .recovery))
        }catch{
            print("recovery not found")
           
        }
    }
    
    
}
