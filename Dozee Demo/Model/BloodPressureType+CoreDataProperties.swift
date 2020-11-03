//
//  BloodPressureType+CoreDataProperties.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 03/11/20.
//
//

import Foundation
import CoreData


extension BloodPressureType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BloodPressureType> {
        return NSFetchRequest<BloodPressureType>(entityName: "BloodPressureType")
    }

    @NSManaged public var systole: Int32
    @NSManaged public var diastole: Int32

}

extension BloodPressureType : Identifiable {

}
