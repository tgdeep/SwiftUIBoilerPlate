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
    private var listOfAlgo : [String] = ["Palindrome", "Bubble Sort", "Insertion Sort", "Merge Sort", "Quick Sort", "Heap Sort", "Sample Legacy","Practice View", "Practice View 2"]
    
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
                        
                        if(listOfAlgo[index] == "Practive View"){
                            NavigationLink(destination: AlgoDetailView(algo: listOfAlgo[index])) {
                                
                                VStack(alignment: .leading) {
                                    Text(listOfAlgo[index])
                                        .font(.headline)
                                }
                            }
                        }
                        
                        else{
                            NavigationLink(destination: AlgoDetailView(algo: listOfAlgo[index])) {
                                
                                VStack(alignment: .leading) {
                                    Text(listOfAlgo[index])
                                        .font(.headline)
                                }
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

@MainActor
class DownloadManager {
    func startDownload() {
        // A regular Task would inherit the @MainActor context
        Task {
            print("Download started on Main Actor")
            await LogService.saveLog("Downloaded 1 bytes")
            
            // USE CASE: Detached task for independent background logging
            // This task is completely independent. If the download manager
            // is destroyed, this task can keep running on its own context.
            Task.detached(priority: .background) {
                // Not isolated to MainActor; executes on a background thread
                print("Log saved independently of the main UI thread.")
            }
            
            updateUI(with: Data.init())
        }
    }
    
    func performHeavyDownload() -> Data{
        
        return Data.init()
    }
    
    func updateUI(with: Data){
        
    }
}

struct LogService {
    static func saveLog(_ message: String) async {
        // Simulate async log persistence
        await Task.yield()
        print("LOG:", message)
    }
}




#Preview {
    PersonListView()
        .modelContainer(for: Person.self, inMemory: true)
}
