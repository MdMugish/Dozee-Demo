//
//  Utils.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 04/11/20.
//

import Foundation

func converTimeStampToDateAndTimeFormat(timeStamp  : Double) -> String{
    
    var day = ""
    var month = ""
    var year = ""
    var hour = ""
    var min = ""
    var amAndPm = ""
    let date =  Date(timeIntervalSince1970: timeStamp)
    
    
    
    let currentDate = Date()
   

       day = date.get(.day)
        month = date.get(.month)
        year = String(date.get(.year).suffix(2))
      
        return "\(day)/\(month)/\(year)"
    
    
    
    
    
}

extension Date {
    
    func get(_ type: Calendar.Component)-> String {
        let calendar = Calendar.current
        let t = calendar.component(type, from: self)
        return (t < 10 ? "0\(t)" : t.description)
    }
}



/*
 
 if timeStamp == 0.0 {
     hour = Date().get(.hour)
     min = Date().get(.minute)
     if Int(hour)! > 12 {
         amAndPm = "PM"
     }else{
         amAndPm = "AM"
     }
     return "\(hour):\(min) \(amAndPm)"
     
 }else if currentDate.get(.day) == date.get(.day) {
     hour = date.get(.hour)
     min = date.get(.minute)
     if Int(hour)! > 12 {
         amAndPm = "PM"
     }else{
         amAndPm = "AM"
     }
     
     return "\(hour):\(min) \(amAndPm)"
 }else{
     */
