//
//  CustomCalendarView.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 02/11/20.
//

import SwiftUI

struct CustomCalendarView: View {
    
    @ObservedObject var dashboardVM : DashboardViewModel
    var body: some View {
       
            VStack{
                
          
                if self.dashboardVM.dataForDaily != nil{
                    VStack{
                        
                        HStack(spacing : dashboardVM.categoryOptions == .Weekly ? 2 : 4){
                            
                            
                            Button(action : {
                                
                                if dashboardVM.categoryOptions == .Daily{
                                    
                                    self.dashboardVM.dateForDaily = Calendar.current.date(byAdding: .day, value: -1, to: self.dashboardVM.dateForDaily)!
                                    self.dashboardVM.UpdateDailyDate()
                                }else if dashboardVM.categoryOptions == .Weekly{
                                    
                                    self.dashboardVM.dateForWeekly =
                                        
                                        
                                        Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: self.dashboardVM.dateForWeekly)!
                                    self.dashboardVM.UpdateWeeklyDate()
                                }else{
                                    self.dashboardVM.dateForMonth = Calendar.current.date(byAdding: .month, value: -1, to: self.dashboardVM.dateForMonth)!
                                    dashboardVM.UpdateMonth()
                                }
                                
                                
                            }) {
                                Image(systemName: "arrowtriangle.left.fill")
                                    .foregroundColor(Color.white.opacity(0.5))
                                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                                    
                            }
                            
                            if dashboardVM.categoryOptions == .Daily{
                            
                                Text(self.dashboardVM.dataForDaily.Date)
                                .font(Font.custom("Nunito-Semibold", size: 14.0))
                                Text(self.dashboardVM.dataForDaily.Month)
                                .font(Font.custom("Nunito-Semibold", size: 14.0))
                                Text(self.dashboardVM.dataForDaily.Year)
                                .font(Font.custom("Nunito-Semibold", size: 14.0))
                                
                                
                            }else if dashboardVM.categoryOptions == .Weekly{
                                
                                Text(self.dashboardVM.dataForWeekly.StartDate)
                                    .font(Font.custom("Nunito-Semibold", size: 14.0))
                                Text(self.dashboardVM.dataForWeekly.StartMonth)
                                    .font(Font.custom("Nunito-Semibold", size: 14.0))
                                Text("-")
                                Text(self.dashboardVM.dataForWeekly.EndDate)
                                    .font(Font.custom("Nunito-Semibold", size: 14.0))
                                Text(self.dashboardVM.dataForWeekly.EndMonth)
                                    .font(Font.custom("Nunito-Semibold", size: 14.0))
                            }else{
                                Text(self.dashboardVM.month)
                                    .font(Font.custom("Nunito-Semibold", size: 14.0))
                            }
                            Button(action : {
                                if dashboardVM.categoryOptions == .Daily{
                                    
                                    self.dashboardVM.dateForDaily = Calendar.current.date(byAdding: .day, value: 1, to: self.dashboardVM.dateForDaily)!
                                    self.dashboardVM.UpdateDailyDate()
                                }else if dashboardVM.categoryOptions == .Weekly{
                                    
                                    self.dashboardVM.dateForWeekly = Calendar.current.date(byAdding: .weekOfMonth, value: 7, to: self.dashboardVM.dateForWeekly)!
                                    self.dashboardVM.UpdateWeeklyDate()
                                }else{
                                    self.dashboardVM.dateForMonth = Calendar.current.date(byAdding: .month, value: 1, to: self.dashboardVM.dateForMonth)!
                                    dashboardVM.UpdateMonth()
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
        CustomCalendarView(dashboardVM: DashboardViewModel(viewContext: PersistenceController.shared.container.viewContext))
    }
}


