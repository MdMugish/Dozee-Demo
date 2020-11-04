//
//  Dashboard.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 01/11/20.
//

import SwiftUI

struct Dashboard: View {
    

    @ObservedObject var dashboardVM : DashboardViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    var height = UIScreen.main.bounds.height
 

    var body: some View {
        GeometryReader { geometry in
        
        VStack{
            
        ProfileView(image: #imageLiteral(resourceName: "profileImage"), userName: "Mohd Mugish")
            .padding(.top, height > 670 ? 48: 32)
            
            HStack(spacing : 0) {
                CategoryPickerView(categoryOptions: $dashboardVM.categoryOptions)
                Spacer()
                CustomCalendarView(dashboardVM : dashboardVM)
            }
            .padding(.horizontal,32)
            .padding(.top, 16)
            
            ScrollView(.vertical, showsIndicators: false){
            
                   VStack {
                        HStack{
                            Text("Vitals")
                                .font(Font.custom("Nunito-Semibold", size: 18.0))
                                .foregroundColor(Color.white)
                            Spacer()
                            
                            Text("Share Vital Reading")
                                .font(Font.custom("Nunito-Semibold", size: 12.0))
                                .foregroundColor(Color.white.opacity(0.5))
                            
                            Button(action : {
                                dashboardVM.itemsForSharedSheet.removeAll()
                                
                                let image = self.takeScreenshot(origin: geometry.frame(in: .global).origin, size: geometry.size)
                                
                                print(image)
                                dashboardVM.itemsForSharedSheet.append(image)
                                dashboardVM.isShareSheetShowing.toggle()
                                
                            } ){
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 19, weight: .regular, design: .rounded))
                                    .foregroundColor(Color.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal,32)
                        .padding(.top, 16)
                    }
                   ZStack{
                        
                        VStack{
                            VitalsView(heardRate: "0", RespiratoinRate: "0", bloodOxygen: "0", bloodPressure: "0", bloodPressureTwo: "0")
                            SleepView(sleepScore: "0", recovery: "0")
                        }
                        
                        ForEach(dashboardVM.myDataThree.filter({ (data) -> Bool in
                            if converTimeStampToDateAndTimeFormat(timeStamp: Double(data.time)) == converTimeStampToDateAndTimeFormat(timeStamp: dashboardVM.dateForDaily.timeIntervalSince1970) {
                                return true
                            }else{
                                return false
                            }
                        }), id: \.self) { value in

                            VStack{
                                VitalsView(heardRate: "\(value.heartRate)", RespiratoinRate: "\(value.breathRate)", bloodOxygen: "\(value.o2)", bloodPressure: "\(value.bloodPressure?.diastole ?? 0)", bloodPressureTwo: "\(value.bloodPressure?.systole ?? 0)")
                                SleepView(sleepScore: "\(value.sleepScore)", recovery: "\(value.recovery)")
                            }
                        }
                        
                        
                    
                    }
                   Spacer()
            }
       
        }
        .sheet(isPresented: $dashboardVM.isShareSheetShowing){
            ShareSheet(items: dashboardVM.itemsForSharedSheet)
        }
        .background(Color(#colorLiteral(red: 0.05490196078, green: 0.05098039216, blue: 0.1137254902, alpha: 1)))
        .ignoresSafeArea()
        
    }
    }

}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard(dashboardVM: DashboardViewModel(viewContext: PersistenceController.shared.container.viewContext))
    }
}

struct VitalsView: View {
    
    @State var heardRate : String
    @State var RespiratoinRate : String
    @State var bloodOxygen : String
    @State var bloodPressure : String
    @State var bloodPressureTwo : String
    var body: some View {
      
        
        HStack{
            CardView(subTitle: "Heart Rate", data: "\(heardRate)", dataType: "BPM", image: #imageLiteral(resourceName: "heart"), linearGradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.08235294118, green: 0.5333333333, blue: 0.2470588235, alpha: 1)), Color(#colorLiteral(red: 0.3450980392, green: 0.8039215686, blue: 0.5921568627, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
            
            CardView(subTitle: "Respiration Rate", data: "\(RespiratoinRate)", dataType: "BPM", image: #imageLiteral(resourceName: "Respiration Rate"), linearGradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9098039216, green: 0.3137254902, blue: 0.137254902, alpha: 1)), Color(#colorLiteral(red: 0.9333333333, green: 0.5215686275, blue: 0.4274509804, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
        }
        .padding(.top, 16)
        .padding(.horizontal,32)
        
        HStack{
            CardView(subTitle: "Blood Oxygen", data: "\(bloodOxygen)", dataType: "%", image: #imageLiteral(resourceName: "Blood Oxygen"), linearGradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9254901961, green: 0.2705882353, blue: 0.3333333333, alpha: 1)), Color(#colorLiteral(red: 0.9333333333, green: 0.5215686275, blue: 0.4274509804, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
            
            CardView(subTitle: "Blood Pressure", data: "\(bloodPressure)", data2: bloodPressureTwo, dataType: "mmHq", image: #imageLiteral(resourceName: "Blood Pressure"), linearGradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.08235294118, green: 0.5333333333, blue: 0.2470588235, alpha: 1)), Color(#colorLiteral(red: 0.3450980392, green: 0.8039215686, blue: 0.5921568627, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
        }
        .padding(.top, 16)
        .padding(.horizontal,32)
        
        

            
    }
    
    
    
}

struct SleepView: View {
    
    @State var sleepScore : String
    @State var recovery : String
    
    var body: some View {
        VStack {
            HStack {
                Text("Sleep")
                    .font(Font.custom("Nunito-Semibold", size: 18.0))
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding(.top, 16)
            .padding(.horizontal,32)
            
            HStack{
                CardView(subTitle: "Sleep Score", data: "\(sleepScore)", dataType: "/ 100", image: #imageLiteral(resourceName: "Sleep Score"), linearGradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.08235294118, green: 0.5333333333, blue: 0.2470588235, alpha: 1)), Color(#colorLiteral(red: 0.3450980392, green: 0.8039215686, blue: 0.5921568627, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                
                CardView(subTitle: "Recovery", data: "\(recovery)", dataType: "%", image: #imageLiteral(resourceName: "Recovery"), linearGradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.08235294118, green: 0.5333333333, blue: 0.2470588235, alpha: 1)), Color(#colorLiteral(red: 0.3450980392, green: 0.8039215686, blue: 0.5921568627, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
            }
            .padding(.top, 16)
            .padding(.horizontal,32)

        }
    }
}
