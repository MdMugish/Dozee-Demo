//
//  CardViewModel.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 01/11/20.
//

import Foundation
import Combine

class DashboardViewModel : ObservableObject{
    
    
    @Published var categoryOptions : CategoryType = .Daily
    
    
    init(){
        print("DashboardViewModel Init")
        
    
    }
    
}


struct data {
    let day : String
    let date : String
    let year : String
    let month : String
    
}
