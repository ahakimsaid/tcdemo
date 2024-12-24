//
//  UIViewControllerRepresentable.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 02/06/2022.
//

import Foundation
import SwiftUI
import TCConsent

struct PrivacyCenterWrapper : UIViewControllerRepresentable
{
    func makeUIViewController(context: Context) -> TCPrivacyCenterViewController {
        
        let picker = TCPrivacyCenterViewController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: TCPrivacyCenterViewController, context: Context) {
    }
    
    
    typealias UIViewControllerType = TCPrivacyCenterViewController

}
