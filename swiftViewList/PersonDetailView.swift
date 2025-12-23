//
//  PersonDetailView.swift
//  swiftViewList
//
//  Created by Deepak T G on 14/10/25.
//

import SwiftUI

struct PersonDetailView: View {
    let person: Person
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(person.name)
                .font(.largeTitle)
                .bold()
            Text("Age: \(person.age)")
                .font(.title3)
            Text(person.desc)
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}
