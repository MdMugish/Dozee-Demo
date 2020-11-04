//
//  ShareDataSheet.swift
//  Dozee Demo
//
//  Created by mohammad mugish on 04/11/20.
//

import Foundation
import SwiftUI

struct ShareSheet : UIViewControllerRepresentable {
    
    var items : [Any]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
