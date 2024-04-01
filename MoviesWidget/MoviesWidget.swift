//
//  MoviesWidget.swift
//  MoviesWidget
//
//  Created by Lucas Brandão on 05/05/21.
//

import WidgetKit
import SwiftUI
import Intents

struct MovieProvider: TimelineProvider {
    func placeholder(in context: Context) -> MoviesTimelineEntry {
        MoviesTimelineEntry(date: Date(), lastGenre: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (MoviesTimelineEntry) -> ()) {
        let entry = MoviesTimelineEntry(date: Date(), lastGenre: "")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let text: String? = UserDefaults.group.object(forKey: "genre") as? String
        
        var entries: [MoviesTimelineEntry] = []
        let entry = MoviesTimelineEntry(date: Date(), lastGenre: text ?? "teste")
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MoviesTimelineEntry: TimelineEntry {
    let date: Date
    let lastGenre: String
}

struct MoviesWidgetEntryView : View {
    var entry: MovieProvider.Entry

    var body: some View {
        VStack {
            Text(entry.lastGenre)
                .foregroundColor(Color(red: 230/255, green: 116/255, blue: 47/255))
                .background(Color.clear)
                .cornerRadius(12)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(red: 230/255, green: 116/255, blue: 47/255), lineWidth: 2))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

@main
struct MoviesWidget: Widget {
    let kind: String = "MoviesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MovieProvider()) { entry in
            MoviesWidgetEntryView(entry: entry)
                .background(Color("WidgetBackground"))
        }
        .configurationDisplayName("Movies")
        .description("This is the last selected genre")
        .contentMarginsDisabled()
    }
}

struct MoviesWidget_Previews: PreviewProvider {
    static var previews: some View {
        MoviesWidgetEntryView(entry: MoviesTimelineEntry(date: Date(), lastGenre: ""))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
