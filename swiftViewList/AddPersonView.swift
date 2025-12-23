//
//  AddPersonView.swift
//  swiftViewList
//
//  Created by Deepak T G on 14/10/25.
//

import SwiftUI
import SwiftData

struct AddPersonView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var name = ""
    @State private var age = ""
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Details")) {
                    TextField("Name", text: $name)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Add Person")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { savePerson() }
                        .disabled(name.isEmpty || age.isEmpty)
                }
            }
        }
    }
    
    private func savePerson() {
        guard let ageInt = Int(age) else { return }
        let newPerson = Person(name: name, age: ageInt, desc: description)
        context.insert(newPerson)
        do {
            try context.save()
            dismiss()
        } catch {
            print("Error saving person: \(error)")
        }
    }
}
