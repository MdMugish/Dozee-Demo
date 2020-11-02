//
//  CardView.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 01/11/20.
//

import SwiftUI

struct CardView: View {
    
    @State var subTitle : String
    @State var data : String
    @State var dataType : String
    @State var image : UIImage
    @State var linearGradient : LinearGradient
    
    var body: some View {
        VStack{
            
      
            VStack(alignment : .trailing) {
                HStack{
                    Spacer()
                }
                Spacer()
                VStack(alignment : .trailing ,spacing : -10){
                Text(data)
                    .font(Font.custom("Nunito-Light", size: 52.0))
                    .foregroundColor(Color.white)
                Text(dataType)
                    .font(Font.custom("Nunito-Semibold", size: 18))
                    .foregroundColor(Color.white.opacity(0.5))
                }
                
            }
            .padding(.horizontal, 21)
            .padding(.top, 20)
            .padding(.bottom, 8)
            
            .frame(width: (UIScreen.main.bounds.width - 85)/2, height: 141, alignment: .center)
            .background(Color(#colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.2588235294, alpha: 1)))
           
            Spacer()
            
        }
        
        .frame(width: (UIScreen.main.bounds.width - 85)/2, height: 145, alignment: .center)
        .background(linearGradient)
        .cornerRadius(4.0)
        .overlay(
            Image(uiImage: image).padding()
            ,alignment: .bottomLeading
        )
        .overlay(
            HStack{
                Text(subTitle)
                    .font(Font.custom("Nunito-Bold", size: 14.0))
                    .foregroundColor(Color.white.opacity(0.5))
                    .frame(width: 74, height: 39, alignment: .center)
                    .multilineTextAlignment(.leading)
                    
                    Spacer()
                Image(systemName: "chevron.right.circle.fill")
                    .foregroundColor(Color.white.opacity(0.5))
            }
            .padding(.horizontal, 21)
            .padding(.top, 16)
            ,alignment: .top
        )
        .padding(.bottom, 8)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(subTitle: "Respiration Rate", data: "64", dataType: "BPM", image: #imageLiteral(resourceName: "heart"), linearGradient: LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.08235294118, green: 0.5333333333, blue: 0.2470588235, alpha: 1)), Color(#colorLiteral(red: 0.3450980392, green: 0.8039215686, blue: 0.5921568627, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
    }
}



