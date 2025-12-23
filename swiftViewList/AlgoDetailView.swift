//
//  AlgoDetailView.swift
//  swiftViewList
//
//  Created by Deepak T G on 12/11/25.
//
import SwiftUI


struct AlgoDetailView: View {
    
    var algo : String
    
    
    var body: some View {
        
        
        if(algo == "Palindrome"){
            
            TextField("Enter input number Name", text: .constant(""))
            
            Button("Go") {
                ///when en	tering the text in textfield, I want to do a check here
                ///
            }
        }
       
            
        
    }
    

    
}
