//
//  SampleSwiftView.swift
//  swiftViewList
//
//  Created by DEEPAK T G on 1/25/26.
//

import UIKit
import SwiftUI

struct SampleSwiftView : UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
            let vc = UIViewController()
            vc.view.backgroundColor = .systemBlue
            return vc
        }
    
    
    func updateUIViewController(
            _ uiViewController: UIViewController,
            context: Context
        ) {
            // Update UIKit view when SwiftUI state changes
        }
    
    
    
    func palindromeCheck(inputStr : String)
    {
        //Add a palindrome check here with inputStr
        
    }
    
    
    
    
}
