//
//  CustomCalendarView.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 02/11/20.
//

import SwiftUI

struct CustomCalendarView: View {
    
    @State var dateForDaily = Date()
    @State var dateForWeekly = Date()
    @State var dateForMonth = Date()
    
    @State var dataForDaily : DateTypeDaily!
    @State var dataForWeekly : DateTypeWeekly!
    @State var month : String!
    
    @Binding var categoryOptions : CategoryType
    var body: some View {
       
            VStack{
                
          
                if self.dataForDaily != nil{
                    VStack{
                        
                        HStack(spacing : categoryOptions == .Weekly ? 2 : 4){
                            
                            
                            Button(action : {
                                
                                if categoryOptions == .Daily{
                                    
                                    self.dateForDaily = Calendar.current.date(byAdding: .day, value: -1, to: self.dateForDaily)!
                                    self.UpdateDailyDate()
                                }else if categoryOptions == .Weekly{
                                    
                                    self.dateForWeekly =
                                        
                                        
                                        Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: self.dateForWeekly)!
                                    self.UpdateWeeklyDate()
                                }else{
                                    self.dateForMonth = Calendar.current.date(byAdding: .month, value: -1, to: self.dateForMonth)!
                                    UpdateMonth()
                                }
                                
                                
                            }) {
                                Image(systemName: "arrowtriangle.left.fill")
                                    .foregroundColor(Color.white.opacity(0.5))
                                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                                    
                            }
                            
                            if categoryOptions == .Daily{
                            
                            Text(self.dataForDaily.Date)
                                .font(Font.custom("Nunito-Semibold", size: 14.0))
                            Text(self.dataForDaily.Month)
                                .font(Font.custom("Nunito-Semibold", size: 14.0))
                            Text(self.dataForDaily.Year)
                                .font(Font.custom("Nunito-Semibold", size: 14.0))
                                
                                
                            }else if categoryOptions == .Weekly{
                                
                                Text(self.dataForWeekly.StartDate)
                                    .font(Font.custom("Nunito-Semibold", size: 14.0))
                                Text(self.dataForWeekly.StartMonth)
                                    .font(Font.custom("Nunito-Semibold", size: 14.0))
                                Text("-")
                                Text(self.dataForWeekly.EndDate)
                                    .font(Font.custom("Nunito-Semibold", size: 14.0))
                                Text(self.dataForWeekly.EndMonth)
                                    .font(Font.custom("Nunito-Semibold", size: 14.0))
                            }else{
                                Text(self.month)
                                    .font(Font.custom("Nunito-Semibold", size: 14.0))
                            }
                            Button(action : {
                                if categoryOptions == .Daily{
                                    
                                    self.dateForDaily = Calendar.current.date(byAdding: .day, value: 1, to: self.dateForDaily)!
                                    self.UpdateDailyDate()
                                }else if categoryOptions == .Weekly{
                                    
                                    self.dateForWeekly = Calendar.current.date(byAdding: .weekOfMonth, value: 7, to: self.dateForWeekly)!
                                    self.UpdateWeeklyDate()
                                }else{
                                    self.dateForMonth = Calendar.current.date(byAdding: .month, value: 1, to: self.dateForMonth)!
                                    UpdateMonth()
                                }
                            }) {
                                Image(systemName: "arrowtriangle.right.fill").foregroundColor(Color.white.opacity(0.5))
                                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                                   
                            }
                        }
                       
                    }
                    .foregroundColor(.white)
                }
                
            }
        
        .background(Color(#colorLiteral(red: 0.05490196078, green: 0.05098039216, blue: 0.1137254902, alpha: 1)))
        .ignoresSafeArea()
        .onAppear(perform: {
            self.UpdateDailyDate()
            self.UpdateWeeklyDate()
            self.UpdateMonth()
        })
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





struct DateTypeDaily{
    var Day : String
    var Date : String
    var Year : String
    var Month : String
}

struct DateTypeWeekly{
    var StartDate : String
    var StartMonth : String
    var EndDate : String
    var EndMonth : String
}



struct CustomCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCalendarView( categoryOptions: .constant(.Daily))
    }
}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
}
