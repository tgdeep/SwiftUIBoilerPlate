//
//  PractiveViewPassThru.swift
//  swiftViewList
//
//  Created by DEEPAK T G on 2/11/26.
//

import SwiftUI
import Combine

struct PracticeViewPassThru: View {
    // MARK: - Properties
    @State private var textField1Value: String = ""
    @State private var textField2Value: String = ""
    
    // PassthroughSubject
    private let subject = PassthroughSubject<String, Never>()
    @State private var showingTextField = false
    @State private var enteredText = ""
    @State private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            // TextField 1
            TextField("Enter a value", text: $textField1Value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            // Button 1 - Send value to subject
            Button(action: {
                sendValueToSubject()
            }) {
                Text("Button 1 - Send Value")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical)
            
            // TextField 2
            TextField("Received value", text: $textField2Value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .disabled(true) // Make it read-only since it receives values
            
            // Button 2 - Subscribe to subject
            Button(action: {
                subscribeToSubject()
            }) {
                Text("Button 2 - Subscribe")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            
            if showingTextField {
                            TextField("Enter text here", text: $enteredText)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .transition(.opacity) // Optional: Add a transition
                        }
            // 3. Add a button to toggle the state
            Button(action: {
                withAnimation { // Optional: Animate the appearance/disappearance
                    showingTextField.toggle()
                }
            }) {
                Text(showingTextField ? "Hide TextField" : "Show TextField")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }

                     
            
            Spacer()
        }
        .padding(.top, 40)
    }
    
    // MARK: - Methods
    private func sendValueToSubject() {
        print("📤 Sending value to subject: \(textField1Value)")
        subject.send(textField1Value)
    }
    
    private func subscribeToSubject() {
        print("📥 TextField2 subscribing to subject...")
        cancellables.removeAll()
        
        subject
            .sink { receivedValue in
                print("✅ TextField2 received value: \(receivedValue)")
                textField2Value = receivedValue
            }
            .store(in: &cancellables)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeViewPassThru()
    }
}
