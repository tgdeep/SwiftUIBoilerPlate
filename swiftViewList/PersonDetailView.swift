//
//  PersonDetailView.swift
//  swiftViewList
//
//  Created by Deepak T G on 14/10/25.
//

import SwiftUI
import ActivityKit

@available(iOS 16.1, *)
struct TimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var startDate: Date
        var endDate: Date
    }

    // Static (immutable) attributes for the activity
    var title: String
}

struct PersonDetailView: View {
    let person: Person
    @available(iOS 16.1, *)
    @State private var activity: Activity<TimerAttributes>? = nil
    
    var body: some View {
    
        
        VStack(alignment: .leading, spacing: 20) {
            Text(person.name)
                .font(.largeTitle)
                .bold()
            Text("Age: \(person.age)")
                .font(.title3)
            Text(person.desc)
                .font(.body)
            
            if #available(iOS 16.1, *) {
                Divider()
                Text("Live Activity (Dynamic Island)")
                    .font(.headline)
                HStack {
                    Button("Start 10s Timer Activity") {
                        startActivity(duration: 10)
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Update +5s") {
                        updateActivity(byAdding: 5)
                    }
                    .buttonStyle(.bordered)

                    Button("End") {
                        endActivity()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.top, 8)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
    
    @available(iOS 16.1, *)
    private func startActivity(duration: Int) {
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(TimeInterval(duration))
        let contentState = TimerAttributes.ContentState(startDate: startDate, endDate: endDate)
        let attributes = TimerAttributes(title: person.name)
        do {
            let activity = try Activity<TimerAttributes>.request(attributes: attributes, contentState: contentState)
            self.activity = activity
        } catch {
            print("Failed to start activity: \(error)")
        }
    }

    @available(iOS 16.1, *)
    private func updateActivity(byAdding seconds: Int) {
        guard let activity else { return }
        let newEnd = (activity.contentState.endDate).addingTimeInterval(TimeInterval(seconds))
        let updated = TimerAttributes.ContentState(startDate: activity.contentState.startDate, endDate: newEnd)
        Task { await activity.update(using: updated) }
    }

    @available(iOS 16.1, *)
    private func endActivity() {
        guard let activity else { return }
        Task { await activity.end(dismissalPolicy: .immediate) }
        self.activity = nil
    }
}

