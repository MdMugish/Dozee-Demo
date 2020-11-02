//
//  CategoryPickerView.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 01/11/20.
//

import SwiftUI

enum CategoryType : String {
    case Daily
    case Weekly
    case Monthly
}

struct CategoryPickerView: View {
    
    @Binding var categoryOptions : CategoryType
    
    var body: some View {
        HStack(spacing : categoryOptions == .Weekly ? 0 : 2){
            Button(action : {
                categoryOptions = .Daily
            }) {
                CategoryButtonView(categoryOptions: $categoryOptions, name: CategoryType.Daily.rawValue)
            }
            
            Button(action : {
                categoryOptions = .Weekly
            }) {
                CategoryButtonView(categoryOptions: $categoryOptions, name: CategoryType.Weekly.rawValue)
            }
            
            Button(action : {
                categoryOptions = .Monthly
            }) {
                CategoryButtonView(categoryOptions: $categoryOptions, name: CategoryType.Monthly.rawValue)
            }
        }
        .animation(.easeInOut)
        
        .background(Color(#colorLiteral(red: 0.05490196078, green: 0.05098039216, blue: 0.1137254902, alpha: 1)))
    }
}

struct CategoryButtonView : View {
    @Binding var categoryOptions : CategoryType
//    @Binding var selected : Bool
    @State var name : String
    var body : some View{
        
        Text(name)
            .font(Font.custom("Nunito-Semibold", size: 10.0))
            .foregroundColor(categoryOptions.rawValue == name ? .white : .blue)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical,7)
            .overlay(
                
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(categoryOptions.rawValue == name ? Color.white : Color(#colorLiteral(red: 0.05490196078, green: 0.05098039216, blue: 0.1137254902, alpha: 1)), style: StrokeStyle())
            )
            
    }
}
struct CategoryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPickerView(categoryOptions: .constant(.Daily))
    }
}
