//
//  sampleWidgetLiveActivity.swift
//  sampleWidget
//
//  Created by DEEPAK T G on 2/27/26.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct sampleWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct sampleWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
           ActivityConfiguration(for: sampleWidgetAttributes.self) { context in
               // Lock Screen/Banner UI
               VStack {
                   Text("Status: \(context.attributes.name)")
                   Text("\(context.state.emoji)")
               }
           } dynamicIsland: { context in
               DynamicIsland {
                   DynamicIslandExpandedRegion(.leading) {
                       Text(context.attributes.name)
                   }
                   DynamicIslandExpandedRegion(.trailing) {
                       Text(context.state.emoji)
                   }
                   DynamicIslandExpandedRegion(.center) {
                       Image(systemName: "timer")
                   }
               } compactLeading: {
                   Image(systemName: "timer")
               } compactTrailing: {
                   Text(context.state.emoji)
               } minimal: {
                   Image(systemName: "timer")
               }
           }
       }
}

extension sampleWidgetAttributes {
    fileprivate static var preview: sampleWidgetAttributes {
        sampleWidgetAttributes(name: "World")
    }
}

extension sampleWidgetAttributes.ContentState {
    fileprivate static var smiley: sampleWidgetAttributes.ContentState {
        sampleWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: sampleWidgetAttributes.ContentState {
         sampleWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: sampleWidgetAttributes.preview) {
   sampleWidgetLiveActivity()
} contentStates: {
    sampleWidgetAttributes.ContentState.smiley
    sampleWidgetAttributes.ContentState.starEyes
}
