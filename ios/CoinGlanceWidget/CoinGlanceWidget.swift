import SwiftUI
import WidgetKit

struct CoinGlanceEntry: TimelineEntry {
    let date: Date
    let lines: String
}

struct CoinGlanceProvider: TimelineProvider {
    func placeholder(in context: Context) -> CoinGlanceEntry {
        CoinGlanceEntry(date: Date(), lines: "BTC —\nTON —")
    }

    func getSnapshot(in context: Context, completion: @escaping (CoinGlanceEntry) -> Void) {
        completion(CoinGlanceEntry(date: Date(), lines: readLines()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CoinGlanceEntry>) -> Void) {
        let entry = CoinGlanceEntry(date: Date(), lines: readLines())
        let next = Calendar.current.date(byAdding: .minute, value: 30, to: Date()) ?? Date().addingTimeInterval(1800)
        completion(Timeline(entries: [entry], policy: .after(next)))
    }

    private func readLines() -> String {
        let defaults = UserDefaults(suiteName: "group.com.coinglance.widget")
        return defaults?.string(forKey: "rates_lines") ?? "Open CoinGlance"
    }
}

struct CoinGlanceWidgetView: View {
    var entry: CoinGlanceProvider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("CoinGlance")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
            Text(entry.lines)
                .font(.system(.footnote, design: .rounded).weight(.medium))
                .foregroundStyle(.primary)
                .lineLimit(4)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .containerBackground(for: .widget) {
            Color(red: 0.04, green: 0.06, blue: 0.08)
        }
    }
}

@main
struct CoinGlanceWidgetBundle: WidgetBundle {
    var body: some Widget {
        CoinGlanceWidget()
    }
}

struct CoinGlanceWidget: Widget {
    let kind: String = "CoinGlanceWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CoinGlanceProvider()) { entry in
            CoinGlanceWidgetView(entry: entry)
        }
        .configurationDisplayName("CoinGlance")
        .description("Bitcoin and Toncoin prices")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
