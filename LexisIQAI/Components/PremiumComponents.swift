import Charts
import SwiftUI

enum LexisTheme {
    static let charcoal = Color(red: 0.025, green: 0.027, blue: 0.032)
    static let panel = Color(red: 0.055, green: 0.064, blue: 0.080)
    static let navy = Color(red: 0.025, green: 0.075, blue: 0.140)
    static let ink = Color(red: 0.72, green: 0.78, blue: 0.86)
    static let muted = Color(red: 0.48, green: 0.55, blue: 0.64)
    static let gold = Color(red: 0.86, green: 0.67, blue: 0.33)
    static let red = Color(red: 0.85, green: 0.25, blue: 0.22)
    static let green = Color(red: 0.32, green: 0.74, blue: 0.50)
}

struct PremiumBackground: View {
    var body: some View {
        LinearGradient(
            colors: [LexisTheme.charcoal, LexisTheme.navy.opacity(0.88), LexisTheme.charcoal],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

struct SectionHeader: View {
    var title: String
    var detail: String? = nil

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(title)
                .font(.system(.title3, design: .serif, weight: .semibold))
                .foregroundStyle(.white)
            Spacer()
            if let detail {
                Text(detail.uppercased())
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(LexisTheme.gold)
            }
        }
    }
}

struct PremiumPanel<Content: View>: View {
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(LexisTheme.panel.opacity(0.94))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(LexisTheme.gold.opacity(0.22), lineWidth: 1)
            )
    }
}

struct DisclaimerBlock: View {
    var body: some View {
        PremiumPanel {
            VStack(alignment: .leading, spacing: 8) {
                Label("Lawyer review required", systemImage: "checkmark.seal")
                    .foregroundStyle(LexisTheme.gold)
                    .font(.subheadline.weight(.semibold))
                Text("Informational tool only. Not legal advice, legal representation, or a guarantee of legal outcomes. Jurisdiction-specific verification is recommended. AI outputs may contain errors.")
                    .font(.caption)
                    .foregroundStyle(LexisTheme.ink)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct UpgradeBanner: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "crown.fill")
                .foregroundStyle(LexisTheme.gold)
            VStack(alignment: .leading, spacing: 2) {
                Text("Chambers intelligence available")
                    .font(.subheadline.weight(.semibold))
                Text("Unlock advanced analytics, exports, matter workspaces, and graph research.")
                    .font(.caption)
                    .foregroundStyle(LexisTheme.muted)
            }
            Spacer()
        }
        .foregroundStyle(.white)
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 8).fill(LexisTheme.navy.opacity(0.85)))
    }
}

struct PremiumHumanAssetView: View {
    var title: String
    var assetName: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(assetName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
            LinearGradient(
                colors: [.black.opacity(0.72), .black.opacity(0.18), LexisTheme.navy.opacity(0.55)],
                startPoint: .leading,
                endPoint: .trailing
            )
            Text(title.uppercased())
                .font(.caption.weight(.bold))
                .foregroundStyle(.white)
                .padding(12)
        }
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(LexisTheme.gold.opacity(0.2), lineWidth: 1))
    }
}

struct MatterCard: View {
    var title: String
    var status: String
    var notes: String

    var body: some View {
        PremiumPanel {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(title).font(.headline)
                    Spacer()
                    Text(status.uppercased())
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(LexisTheme.gold)
                }
                Text(notes.isEmpty ? "No matter note recorded." : notes)
                    .font(.caption)
                    .foregroundStyle(LexisTheme.muted)
                    .lineLimit(3)
            }
        }
    }
}

struct ResearchCard: View {
    var title: String
    var summary: String

    var body: some View {
        PremiumPanel {
            VStack(alignment: .leading, spacing: 8) {
                Label(title, systemImage: "magnifyingglass")
                    .font(.headline)
                Text(summary)
                    .font(.caption)
                    .foregroundStyle(LexisTheme.ink)
                    .lineLimit(4)
            }
            .foregroundStyle(.white)
        }
    }
}

struct ContractRiskCard: View {
    var score: Int
    var findings: String

    var body: some View {
        PremiumPanel {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Contract Risk")
                    Spacer()
                    Text("\(score)/100")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(score > 70 ? LexisTheme.red : LexisTheme.gold)
                }
                ProgressView(value: Double(score), total: 100)
                    .tint(score > 70 ? LexisTheme.red : LexisTheme.gold)
                Text(findings)
                    .font(.caption)
                    .foregroundStyle(LexisTheme.ink)
            }
        }
    }
}

struct VoiceWaveformView: View {
    var levels: [CGFloat]

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(Array(levels.enumerated()), id: \.offset) { _, level in
                Capsule()
                    .fill(LinearGradient(colors: [LexisTheme.gold, .white.opacity(0.85)], startPoint: .bottom, endPoint: .top))
                    .frame(width: 4, height: max(8, 70 * level))
                    .animation(.spring(response: 0.22, dampingFraction: 0.72), value: level)
            }
        }
        .frame(height: 88)
        .accessibilityLabel("Live voice waveform")
    }
}

struct KnowledgeGraphView: View {
    var nodes: [GraphDisplayNode]

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(nodes.indices, id: \.self) { index in
                    if index < nodes.count - 1 {
                        Path { path in
                            let a = nodes[index]
                            let b = nodes[index + 1]
                            path.move(to: CGPoint(x: proxy.size.width * a.x, y: proxy.size.height * a.y))
                            path.addLine(to: CGPoint(x: proxy.size.width * b.x, y: proxy.size.height * b.y))
                        }
                        .stroke(LexisTheme.gold.opacity(0.34), lineWidth: 1)
                    }
                }

                ForEach(nodes) { node in
                    VStack(spacing: 4) {
                        Circle()
                            .fill(node.type == "Case" ? LexisTheme.gold : LexisTheme.navy)
                            .frame(width: 42, height: 42)
                            .overlay(Image(systemName: icon(for: node.type)).foregroundStyle(.white))
                        Text(node.title)
                            .font(.caption2.weight(.semibold))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .frame(width: 90)
                    }
                    .position(x: proxy.size.width * node.x, y: proxy.size.height * node.y)
                }
            }
        }
        .frame(height: 320)
        .background(RoundedRectangle(cornerRadius: 8).fill(.black.opacity(0.22)))
    }

    private func icon(for type: String) -> String {
        switch type {
        case "Case": "building.columns"
        case "Statute": "scroll"
        case "Regulation": "shield.lefthalf.filled"
        case "Matter": "folder"
        default: "point.3.connected.trianglepath.dotted"
        }
    }
}

struct LegalTimelineView: View {
    var events: [ChronologyEvent]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(events.sorted(by: { $0.eventDate < $1.eventDate })) { event in
                HStack(alignment: .top, spacing: 12) {
                    Circle().fill(LexisTheme.gold).frame(width: 10, height: 10).padding(.top, 5)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(event.title).font(.subheadline.weight(.semibold))
                        Text(event.eventDate.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption)
                            .foregroundStyle(LexisTheme.gold)
                        Text(event.notes)
                            .font(.caption)
                            .foregroundStyle(LexisTheme.muted)
                    }
                    Spacer()
                    Image(systemName: "line.3.horizontal")
                        .foregroundStyle(LexisTheme.muted)
                }
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).fill(.white.opacity(0.04)))
            }
        }
    }
}

struct AnalyticsChartCard: View {
    var title: String
    var metrics: [AnalyticsMetric]

    var body: some View {
        PremiumPanel {
            VStack(alignment: .leading, spacing: 12) {
                Text(title).font(.headline)
                Chart(metrics) { metric in
                    BarMark(x: .value("Metric", metric.label), y: .value("Value", metric.value))
                        .foregroundStyle(LexisTheme.gold)
                }
                .frame(height: 180)
            }
        }
    }
}

struct ShareCardPreview: View {
    var title: String
    var bodyText: String

    var body: some View {
        PremiumPanel {
            VStack(alignment: .leading, spacing: 10) {
                Label("PDF Export", systemImage: "square.and.arrow.up")
                    .foregroundStyle(LexisTheme.gold)
                Text(title).font(.headline)
                Text(bodyText).font(.caption).foregroundStyle(LexisTheme.ink).lineLimit(5)
            }
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
