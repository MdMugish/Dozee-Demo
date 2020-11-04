//
//  CardViewModel.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 01/11/20.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class DashboardViewModel : NSObject, ObservableObject{
    
    
    @Published var categoryOptions : CategoryType = .Daily
    @Published var itemsForSharedSheet : [Any] = []
    @Published var dateForDaily = Date()
    @Published var dateForWeekly = Date()
    @Published var dateForMonth = Date()
    @Published var dataForDaily : DateTypeDaily!
    @Published var dataForWeekly : DateTypeWeekly!
    @Published var month : String!
    @Published var isShareSheetShowing = false

   
    @Published var myDataThree: [SampleDataTwo] = []
    private let myDataControllerThree: NSFetchedResultsController<SampleDataTwo>

    init(viewContext : NSManagedObjectContext){
        
        print("DashboardViewModel Init")
 
        
        let fetchRequest : NSFetchRequest = SampleDataTwo.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "time", ascending: true)]
        
        myDataControllerThree = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()

        myDataControllerThree.delegate = self

            do {
              try myDataControllerThree.performFetch()
                myDataThree = myDataControllerThree.fetchedObjects ?? []
            } catch {
              print("failed to fetch items!")
            }

        self.UpdateDailyDate()
        self.UpdateWeeklyDate()
        self.UpdateMonth()
        
    }
    
    
    
    func UpdateWeeklyDate(){
        let current = Calendar.current
        
        let firstDay = current.component(.day, from: self.dateForWeekly.startOfWeek!)
        let firstMonthNo = current.component(.month, from: self.dateForWeekly.startOfWeek!)
        let firstMonth = current.shortMonthSymbols[firstMonthNo - 1]
        let lastDay = current.component(.day, from: self.dateForWeekly.endOfWeek!)
        let lastMonthNo = current.component(.month, from: self.dateForWeekly.endOfWeek!)
        let lastMonth =  current.shortMonthSymbols[lastMonthNo - 1]
        
        self.dataForWeekly = DateTypeWeekly(StartDate: "\(firstDay)", StartMonth: "\(firstMonth)", EndDate: "\(lastDay)", EndMonth: "\(lastMonth)")
        
  
    }
 
 
    func UpdateDailyDate(){
        let current = Calendar.current
        
        let date = current.component(.day, from: self.dateForDaily)
        let monthNO = current.component(.month, from: self.dateForDaily)
        let month = current.shortMonthSymbols[monthNO - 1]
        let year = current.component(.year, from: self.dateForDaily)
        let weekNo = current.component(.weekday, from: self.dateForDaily)
        let day = current.weekdaySymbols[weekNo - 1]
        
        self.dataForDaily = DateTypeDaily(Day: "\(day)", Date: "\(date)", Year: "\(year)", Month: "\(month)")
        
    }
    
    func UpdateMonth(){
        let current = Calendar.current
        
        let monthNo = current.component(.month, from: self.dateForMonth)
        let month = current.monthSymbols[monthNo - 1]
        
        self.month = month
    }
    
    
}



extension DashboardViewModel: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    guard let todoItems = controller.fetchedObjects as? [SampleDataTwo]
      else { return }

    myDataThree = todoItems
  }
}



    


