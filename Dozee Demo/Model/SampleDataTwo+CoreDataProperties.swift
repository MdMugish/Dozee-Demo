//
//  SampleDataTwo+CoreDataProperties.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 03/11/20.
//
//

import Foundation
import CoreData


extension SampleDataTwo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SampleDataTwo> {
        return NSFetchRequest<SampleDataTwo>(entityName: "SampleDataTwo")
    }

    @NSManaged public var breathRate: Int32
    @NSManaged public var sleepScore: Int32
    @NSManaged public var recovery: Int32
    @NSManaged public var o2: Int32
    @NSManaged public var heartRate: Int32
    @NSManaged public var time: Int64
    @NSManaged public var bloodPressure: BloodPressureType?

}

extension SampleDataTwo : Identifiable {

}
