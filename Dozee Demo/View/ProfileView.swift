//
//  ProfileView.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 01/11/20.
//

import SwiftUI

struct ProfileView: View {
    @State var image : UIImage
    @State var userName : String
    
    var body: some View {
        HStack {
            
            Image(uiImage: image)
                .padding(.leading, 28)
            
            Text(userName)
                .font(.system(size: 13, weight: .regular, design: .default))
                .foregroundColor(.white)
            
            Image(systemName: "chevron.down")
                .font(.system(size: 19, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
            
            Spacer()
        }
        .frame(width: nil, height: 54, alignment: .center)
        .background(Color(#colorLiteral(red: 0.08235294118, green: 0.07450980392, blue: 0.1921568627, alpha: 1)))
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(image: #imageLiteral(resourceName: "profileImage"), userName: "Mohd Mugish")
    }
}
