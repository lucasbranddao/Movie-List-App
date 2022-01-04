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
        MoviesTimelineEntry(date: Date(), genres: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (MoviesTimelineEntry) -> ()) {
        let entry = MoviesTimelineEntry(date: Date(), genres: [])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MoviesTimelineEntry] = []
        let entry = MoviesTimelineEntry(date: Date(), genres: ["teste"])
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MoviesTimelineEntry: TimelineEntry {
    let date: Date
    let genres: [String]
}

struct MoviesWidgetEntryView : View {
    var entry: MovieProvider.Entry

    var body: some View {
        VStack {
            
            
        }
//        .color
//        Text(entry.genres.first ?? "")
    }
}

@main
struct MoviesWidget: Widget {
    let kind: String = "MoviesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MovieProvider()) { entry in
            MoviesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct MoviesWidget_Previews: PreviewProvider {
    static var previews: some View {
        MoviesWidgetEntryView(entry: MoviesTimelineEntry(date: Date(), genres: []))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
