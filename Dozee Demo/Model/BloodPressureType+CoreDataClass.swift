//
//  BloodPressureType+CoreDataClass.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 03/11/20.
//
//

import Foundation
import CoreData

@objc(BloodPressureType)
public class BloodPressureType: NSManagedObject, Codable {

    
    
    enum CodingKeys : String, CodingKey {
        case systole = "Systole" , diastole = "Diastole"
    }
    
    public func encode(to encoder : Encoder) throws {
        var container = encoder.container(keyedBy : CodingKeys.self)
        
        
        
        try container.encode(systole, forKey : .systole)
        try container.encode(diastole, forKey : .diastole)
    }
    
    
    public required convenience init(from decoder: Decoder) throws {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "BloodPressureType", in: PersistenceController.shared.container.viewContext) else {
            fatalError("Error white decoding recentChats \(Error.self)")
        }
    
        self.init(entity : entity, insertInto : nil)
        let values = try decoder.container(keyedBy: CodingKeys.self)

        systole = Int32(try values.decode(Int.self, forKey : .systole))
        diastole = Int32(try values.decode(Int.self, forKey : .diastole))
        
    }
    
}
