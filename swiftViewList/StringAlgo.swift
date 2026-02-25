//
//  StringAlgo.swift
//  swiftViewList
//
//  Created by DEEPAK T G on 2/18/26.
//

import SwiftUI
import Combine

struct StringAlgo: View {
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text("String Reverse")
                        
            Text("Sample   " + reverseString("Deepak"))
            
            Text("Palindrome check")
                        
            Text("Sample   " + palindromeCheck("aka"))
            
            Text("Non repeating word check")
                        
            Text("Sample   " + (firstNonRepeatingWord("aab45667") ?? "none"))
            
            
            Text("Longest substring")
                        
            Text("Sample   " + (firstNonRepeatingWord("aab45667") ?? "none"))
            

        }
        
                          
    }
    
    
    
    
}

func reverseString(_ str: String) -> String {
    
    let arr = Array(str)
    var outputStr : String = ""
    
    var idx = arr.count - 1
    while idx > -1 {
        
        outputStr.append(arr[idx])
        idx = idx - 1
    }
    
    print(outputStr)
    
    return outputStr
    
}

func palindromeCheck(_ str: String) -> String{
    
    var currentIndex = 0
    var arr = Array(str.lowercased())
    while currentIndex < arr.count / 2
    {
        if(arr[currentIndex] != arr[arr.count - currentIndex - 1]){
            return "false"
        }
        currentIndex = currentIndex + 1
    }
    
    
    return "true"
    
    
}

func anagramCheck(_ str1: String, _ str2: String) -> Bool {
    
    guard str1.count == str2.count else { return false}
    return str1.lowercased().sorted() == str2.lowercased().sorted()
}


func firstNonRepeatingWord(_ str: String) -> String? {
    
    var counts : [Character : Int] = [:]
    
    for char in str {
        
        counts[char,default: 0] += 1
               
    }
    
    for char in str where counts[char] == 1{
        
        return String(char)
    }
    
    return nil
    
}

func longestSubstr(_ str: String) -> String {
    
    //input deepak
    
    var subStrLength = 0
    
    let chars = Array(str)
    
    
    
    
    return ""
}

func lengthOfLongestSubstring(_ str: String) -> Int {
    let chars = Array(str)
    var seen: [Character: Int] = [:]  // char -> last seen index
    var maxLength = 0
    var left = 0

    for right in 0..<chars.count {
        let char = chars[right]

        // If we've seen this char within the current window, shrink from left
        if let lastIndex = seen[char], lastIndex >= left {
            left = lastIndex + 1
        }

        seen[char] = right
        maxLength = max(maxLength, right - left + 1)
    }

    return maxLength
}


// MARK: - Preview
struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        StringAlgo()
    }
}
