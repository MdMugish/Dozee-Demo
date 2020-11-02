//
//  Dashboard.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 01/11/20.
//

import SwiftUI

struct Dashboard: View {
    

    @StateObject var dashboardVM = DashboardViewModel()
    
    var height = UIScreen.main.bounds.height
    //var localDatabase = PersistenceController.shared.container.viewContext
    
    var body: some View {
        VStack{
            
        ProfileView(image: #imageLiteral(resourceName: "profileImage"), userName: "Mohd Mugish")
            .padding(.top, height > 670 ? 48: 32)
            
            HStack(spacing : 0) {
                CategoryPickerView(categoryOptions: $dashboardVM.categoryOptions)
                Spacer()
                CustomCalendarView(categoryOptions: $dashboardVM.categoryOptions)
            }
            .padding(.horizontal,32)
            .padding(.top, 16)
            
            ScrollView(.vertical, showsIndicators: false){
            HStack{
                Text("Vitals")
                    .font(Font.custom("Nunito-Semibold", size: 18.0))
                    .foregroundColor(Color.white)
                Spacer()
                Text("Share Vital Reading")
                    .font(Font.custom("Nunito-Semibold", size: 12.0))
                    .foregroundColor(Color.white.opacity(0.5))
                
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 19, weight: .regular, design: .rounded))
                    .foregroundColor(Color.white.opacity(0.5))
            }
            .padding(.horizontal,32)
            .padding(.top, 16)
            
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 146))], content: /*@START_MENU_TOKEN@*/{
            ForEach(0..<4) { value in
                CardView(subTitle: "Respiration Rate", data: "64", dataType: "BPM", image: #imageLiteral(resourceName: "heart"), linearGradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.08235294118, green: 0.5333333333, blue: 0.2470588235, alpha: 1)), Color(#colorLiteral(red: 0.3450980392, green: 0.8039215686, blue: 0.5921568627, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
            }
        }/*@END_MENU_TOKEN@*/)
        .padding(.top, 16)
        .padding(.horizontal,32)
            
            
            HStack {
                Text("Sleep")
                    .font(Font.custom("Nunito-Semibold", size: 18.0))
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding(.top, 16)
            .padding(.horizontal,32)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 146))], content: /*@START_MENU_TOKEN@*/{
                ForEach(0..<2) { value in
                    CardView(subTitle: "Respiration Rate", data: "64", dataType: "BPM", image: #imageLiteral(resourceName: "heart"), linearGradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.08235294118, green: 0.5333333333, blue: 0.2470588235, alpha: 1)), Color(#colorLiteral(red: 0.3450980392, green: 0.8039215686, blue: 0.5921568627, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                }
            }
            
            /*@END_MENU_TOKEN@*/)
            
            .padding(.top, 16)
            .padding(.horizontal,32)
        Spacer()
            
            }
       
        }
        .background(Color(#colorLiteral(red: 0.05490196078, green: 0.05098039216, blue: 0.1137254902, alpha: 1)))
        .ignoresSafeArea()
        
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
