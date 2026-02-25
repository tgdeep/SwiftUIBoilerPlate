//
//  AlgoDetailView.swift
//  swiftViewList
//
//  Created by Deepak T G on 12/11/25.
//
import SwiftUI


enum AlgoResult {
    case yes
    case no
}

struct AlgoDetailView: View {

    let algo: String

    @State private var inputText: String = ""
    @State private var result: AlgoResult? = nil
    
    @State private var sortedResult: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            if algo == "Palindrome" {
                palindromeView
            }
            
            if algo == "Bubble Sort" {
                bubbleSortView
            }
            
            if algo == "Insertion Sort" {
                insertionSortView
            }
            if algo == "Merge Sort" {
                mergeSortView
            }
            if algo == "Quick Sort" {
                quickSortView
            }
            if algo == "Heap Sort" {
                quickSortView
            }
            if algo == "Sample Legacy" {
                legacy
            }
            if algo == "Practice View" {
                PracticeView()
            }
            if algo == "Practice View 2" {
                PracticeViewPassThru()
            }
            if algo == "StringAlgo" {
                StringAlgo()
            }

            Spacer()
        }
        .padding()
        .navigationTitle(algo)
    }
}

private extension AlgoDetailView {
    
    var legacy : some View {
        
        SampleSwiftView()
    }
}

private extension AlgoDetailView {

    var palindromeView: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("Palindrome Check")
                .font(.title2)
                .fontWeight(.semibold)

            TextField("Enter input", text: $inputText)
                .textFieldStyle(.roundedBorder)

            Button("Go") {
                // 👉 You write your palindrome logic here
                // Example:
                // result = isPalindrome(inputText) ? .yes : .no
                var characters = Array(inputText)
                result = .yes
                var currIndex = 0
                while currIndex < characters.count/2 {
                    if(characters[currIndex].lowercased() != characters[characters.count - currIndex - 1].lowercased())
                    {
                       result = .no
                    }
                    currIndex += 1
                    
                }
            }
            .buttonStyle(.borderedProminent)

            if let result = result{
                Text(resultText)
                    .font(.headline)
                    .foregroundColor(resultColor)
            }
        }
    }
    
    
    var bubbleSortView: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("Bubble sort Check")
                .font(.title2)
                .fontWeight(.semibold)

            TextField("Enter comma seperated numbers", text: $inputText)
                .textFieldStyle(.roundedBorder)

            Button("Go") {

                        // 1️⃣ Convert input to Int array
                        var numbers = inputText
                            .components(separatedBy: ",")
                            .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

                        // 2️⃣ Bubble Sort logic (classic)
                        guard numbers.count > 1 else {
                            sortedResult = numbers.map(String.init).joined(separator: ", ")
                            return
                        }

                        for i in 0..<numbers.count {
                            for j in 0..<(numbers.count - i - 1) {
                                if numbers[j] > numbers[j + 1] {
                                    numbers.swapAt(j, j + 1)
                                }
                            }
                        }

                        // 3️⃣ Bind output back to UI
                        sortedResult = numbers.map(String.init).joined(separator: ", ")
                    }
                    .buttonStyle(.borderedProminent)
            
            if !sortedResult.isEmpty {
                        Text("Sorted Result:")
                            .font(.headline)

                        Text(sortedResult)
                            .foregroundColor(.green)
                    }

           
        }
    }
    
    var insertionSortView: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("Insertion Sort")
                .font(.title2)
                .fontWeight(.semibold)

            TextField("Enter comma separated numbers", text: $inputText)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numbersAndPunctuation)

            Button("Go") {

                // 1️⃣ Parse input
                var numbers = inputText
                    .components(separatedBy: ",")
                    .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

                guard numbers.count > 1 else {
                    sortedResult = numbers.map(String.init).joined(separator: ", ")
                    return
                }

                // 2️⃣ Insertion Sort
                for i in 1..<numbers.count {
                    let key = numbers[i]
                    var j = i - 1

                    while j >= 0 && numbers[j] > key {
                        numbers[j + 1] = numbers[j]
                        j -= 1
                    }

                    numbers[j + 1] = key
                }

                // 3️⃣ Bind output
                sortedResult = numbers.map(String.init).joined(separator: ", ")
            }
            .buttonStyle(.borderedProminent)

            if !sortedResult.isEmpty {
                Text("Sorted Result:")
                    .font(.headline)

                Text(sortedResult)
                    .foregroundColor(.green)
            }
        }
    }
    
    
    var mergeSortView: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("Merge Sort")
                .font(.title2)
                .fontWeight(.semibold)

            TextField("Enter comma separated numbers", text: $inputText)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numbersAndPunctuation)

            Button("Go") {

                // 1️⃣ Parse input
                let numbers = inputText
                    .components(separatedBy: ",")
                    .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

                guard numbers.count > 1 else {
                    sortedResult = numbers.map(String.init).joined(separator: ", ")
                    return
                }

                // 2️⃣ Merge Sort
                let sortedNumbers = mergeSort(numbers)

                // 3️⃣ Bind output
                sortedResult = sortedNumbers.map(String.init).joined(separator: ", ")
            }
            .buttonStyle(.borderedProminent)

            if !sortedResult.isEmpty {
                Text("Sorted Result:")
                    .font(.headline)

                Text(sortedResult)
                    .foregroundColor(.green)
            }
        }
    }

    func mergeSort(_ array: [Int]) -> [Int] {
        guard array.count > 1 else { return array }

        let middle = array.count / 2
        let left = mergeSort(Array(array[..<middle]))
        let right = mergeSort(Array(array[middle...]))

        return merge(left, right)
    }

    func merge(_ left: [Int], _ right: [Int]) -> [Int] {
        var merged: [Int] = []
        var i = 0
        var j = 0

        while i < left.count && j < right.count {
            if left[i] <= right[j] {
                merged.append(left[i])
                i += 1
            } else {
                merged.append(right[j])
                j += 1
            }
        }

        // Append remaining elements
        merged.append(contentsOf: left[i...])
        merged.append(contentsOf: right[j...])

        return merged
    }
    
    var quickSortView: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("Quick Sort")
                .font(.title2)
                .fontWeight(.semibold)

            TextField("Enter comma separated numbers", text: $inputText)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numbersAndPunctuation)

            Button("Go") {

                // 1️⃣ Parse input
                let numbers = inputText
                    .components(separatedBy: ",")
                    .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

                guard numbers.count > 1 else {
                    sortedResult = numbers.map(String.init).joined(separator: ", ")
                    return
                }

                // 2️⃣ Quick Sort
                let sortedNumbers = quickSort(numbers)

                // 3️⃣ Bind output
                sortedResult = sortedNumbers.map(String.init).joined(separator: ", ")
            }
            .buttonStyle(.borderedProminent)

            if !sortedResult.isEmpty {
                Text("Sorted Result:")
                    .font(.headline)

                Text(sortedResult)
                    .foregroundColor(.green)
            }
        }
    }
    
    func quickSort(_ array: [Int]) -> [Int] {
        guard array.count > 1 else { return array }

        let pivot = array[array.count / 2]

        let less = array.filter { $0 < pivot }
        let equal = array.filter { $0 == pivot }
        let greater = array.filter { $0 > pivot }

        return quickSort(less) + equal + quickSort(greater)
    }


    var heapSortView: some View {
        VStack(alignment: .leading, spacing: 16) {

            Text("Heap Sort")
                .font(.title2)
                .fontWeight(.semibold)

            TextField("Enter comma separated numbers", text: $inputText)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numbersAndPunctuation)

            Button("Go") {

                // 1️⃣ Parse input
                var numbers = inputText
                    .components(separatedBy: ",")
                    .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

                guard numbers.count > 1 else {
                    sortedResult = numbers.map(String.init).joined(separator: ", ")
                    return
                }

                // 2️⃣ Heap Sort
                heapSort(&numbers)

                // 3️⃣ Bind output
                sortedResult = numbers.map(String.init).joined(separator: ", ")
            }
            .buttonStyle(.borderedProminent)

            if !sortedResult.isEmpty {
                Text("Sorted Result:")
                    .font(.headline)

                Text(sortedResult)
                    .foregroundColor(.green)
            }
        }
    }
    
    func heapSort(_ array: inout [Int]) {
        let n = array.count

        // Build max heap
        for i in stride(from: n / 2 - 1, through: 0, by: -1) {
            heapify(&array, n, i)
        }

        // Extract elements from heap
        for i in stride(from: n - 1, through: 1, by: -1) {
            array.swapAt(0, i)
            heapify(&array, i, 0)
        }
    }

    func heapify(_ array: inout [Int], _ n: Int, _ i: Int) {
        var largest = i
        let left = 2 * i + 1
        let right = 2 * i + 2

        if left < n && array[left] > array[largest] {
            largest = left
        }

        if right < n && array[right] > array[largest] {
            largest = right
        }

        if largest != i {
            array.swapAt(i, largest)
            heapify(&array, n, largest)
        }
    }



    


    var resultText: String {
        switch result {
        case .yes:
            return "Yes"
        case .no:
            return "No"
        case nil:
            return ""
        }
    }

    var resultColor: Color {
        switch result {
        case .yes:
            return .green
        case .no:
            return .red
        case nil:
            return .clear
        }
    }
}





