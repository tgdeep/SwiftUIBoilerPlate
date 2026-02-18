//
//  PracticeView.swift
//  swiftViewList
//
//  Created by DEEPAK T G on 2/11/26.
//

import SwiftUI
import Combine

struct PracticeView: View {
    // CurrentValueSubject with an initial value
    private let subject = CurrentValueSubject<String, Never>("Initial value")
    

    // Source text (top TextField) the user edits to push into the subject
    @State private var sourceText: String = "Initial value"

    // Three subscribers' displayed text values
    @State private var subscriber1Text: String = ""
    @State private var subscriber2Text: String = ""
    @State private var subscriber3Text: String = ""

    // Cancellables for Combine subscriptions
    @State private var cancellables: Set<AnyCancellable> = []

    var body: some View {
        VStack(spacing: 16) {
            Text("CurrentValueSubject Demo")
                .font(.headline)

            // Top TextField: edits here will update the subject
            TextField("Enter text to publish", text: $sourceText)
                .textFieldStyle(.roundedBorder)
                .onChange(of: sourceText) { _, newValue in
                    // Push new value to the subject
                    subject.send(newValue)
                }

            Divider()

            // Three TextFields that subscribe to the subject's latest value
            // They also send edits back into the subject to demonstrate two-way flow
            Group {
                TextField("Subscriber 1", text: Binding(
                    get: { subscriber1Text },
                    set: { newValue in
                        subscriber1Text = newValue
                        subject.send(newValue)
                    }
                ))
                .textFieldStyle(.roundedBorder)

                TextField("Subscriber 2", text: Binding(
                    get: { subscriber2Text },
                    set: { newValue in
                        subscriber2Text = newValue
                        subject.send(newValue)
                    }
                ))
                .textFieldStyle(.roundedBorder)

                TextField("Subscriber 3", text: Binding(
                    get: { subscriber3Text },
                    set: { newValue in
                        subscriber3Text = newValue
                        subject.send(newValue)
                    }
                ))
                .textFieldStyle(.roundedBorder)
            }

            // Show the current value for clarity
            Text("Current subject value: \(subject.value)")
                .font(.footnote)
                .foregroundStyle(.secondary)

            Spacer()

            // Keep original controls for reference
            Text("Hello, World!")

            Button("Deepak", action: {
                print("button tapped")
            }).onTapGesture {
                print("tap gesture")
            }
        }
        .padding()
        .onAppear(perform: setupSubscriptions)
    }

    private func setupSubscriptions() {
        // Ensure we start clean when view reappears
        cancellables.removeAll()

        // Subscribe each text state to the subject, removing duplicates to avoid feedback loops
        subject
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { value in
                // Update all subscriber text fields when subject changes
                subscriber1Text = value
                subscriber2Text = value
                subscriber3Text = value
            }
            .store(in: &cancellables)

        // Initialize state from the subject's initial value
        let initial = subject.value
        sourceText = initial
        subscriber1Text = initial
        subscriber2Text = initial
        subscriber3Text = initial
    }
}

#Preview {
    PracticeView()
}
