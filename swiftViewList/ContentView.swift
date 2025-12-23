//
//  ContentView.swift
//  swiftViewList
//
//  Created by Deepak T G on 14/10/25.
//

import SwiftUI
import SwiftData

struct PersonListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Person.name) private var people: [Person]
    @State private var showingAddPerson = false
    private var listOfAlgo : [String] = ["Palindrome", "Bubble Sort", "Insertion Sort", "Merge Sort", "Quick Sort"]
    
    // 👇 Add this explicit initializer to make it accessible
       init() {}
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section(header: Text("People list")) {
                    List(people) { person in
                        
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            VStack(alignment: .leading) {
                                Text(person.name)
                                    .font(.headline)
                                Text("Age: \(person.age)")
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                }
                
                Section(header: Text("Algorithm list")) {
                    
                    
                    List(listOfAlgo.indices, id: \.self) { index in
                        
                        NavigationLink(destination: AlgoDetailView(algo: listOfAlgo[index])) {
                            
                            VStack(alignment: .leading) {
                                Text(listOfAlgo[index])
                                    .font(.headline)
                            }
                        }
                        
                    }
                    
                    
                }
            }               
            
                        
            
            .navigationTitle("People")
            .toolbar {
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingAddPerson = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPerson) {
                AddPersonView()
            }
        }
    }
}


#Preview {
    PersonListView()
        .modelContainer(for: Person.self, inMemory: true)
}
