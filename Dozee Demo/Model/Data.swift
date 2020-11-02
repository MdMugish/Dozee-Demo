//
//  File.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 02/11/20.
//

import Foundation

struct Data : Codable{
    let HeartRate : Int
    let BreathRate : Int
    let O2 : Int
    let Blood_Pressure : BloodPressureType
    let Recovery : Int
    let sleepscore : Int
    let time : Int
}

struct BloodPressureType : Codable {
    let Systole : Int
    let Diastole : Int
}
