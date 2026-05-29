import SwiftData
import SwiftUI
import UniformTypeIdentifiers

struct MoreView: View {
    var profile: LegalProfile

    var body: some View {
        ZStack {
            PremiumBackground()
            List {
                Section("Intelligence") {
                    NavigationLink("Document Upload Center") { DocumentUploadView(profile: profile) }
                    NavigationLink("Contract Analyzer") { ContractAnalyzerView(profile: profile) }
                    NavigationLink("Litigation Strategy Builder") { LitigationStrategyView(profile: profile) }
                    NavigationLink("AI Drafting Assistant") { DraftingAssistantView(profile: profile) }
                }
                Section("Workspace") {
                    NavigationLink("Chronology Builder") { ChronologyBuilderView() }
                    NavigationLink("Knowledge Graph") { KnowledgeGraphScreen() }
                    NavigationLink("Analytics Dashboard") { AnalyticsDashboardView() }
                    NavigationLink("PDF Export Center") { PDFExportView(profile: profile) }
                }
                Section("Business") {
                    NavigationLink("Paywall") { PaywallView() }
                    NavigationLink("Settings") { SettingsView(profile: profile) }
                    NavigationLink("Widgets Placeholder") { PlaceholderArchitectureView(title: "WidgetKit", bullets: ["Today's deadlines", "Active matter", "Research shortcut", "Voice note shortcut"]) }
                    NavigationLink("Apple Watch Placeholder") { PlaceholderArchitectureView(title: "Apple Watch", bullets: ["Deadline alerts", "Voice notes", "Research reminders"]) }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("LexisIQ Suite")
    }
}

struct DocumentUploadView: View {
    var profile: LegalProfile
    @Environment(\.modelContext) private var modelContext
    @State private var showImporter = false
    @State private var importedName = ""
    @State private var ocrSummary = ""

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenTitle("Document Upload Center", "PDF, DOCX, image, and scanned document architecture with OCR placeholder support.")
                    Button {
                        showImporter = true
                    } label: {
                        Label("Upload Document", systemImage: "tray.and.arrow.up").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(LexisTheme.gold)
                    .foregroundStyle(.black)

                    ShareCardPreview(title: importedName.isEmpty ? "No document selected" : importedName, bodyText: ocrSummary.isEmpty ? "Upload a document to generate summary, issue extraction, key clauses, and chronology entries." : ocrSummary)
                    DisclaimerBlock()
                }
                .padding(18)
            }
        }
        .fileImporter(isPresented: $showImporter, allowedContentTypes: [.pdf, .image, .plainText, .rtf, .docx], allowsMultipleSelection: false) { result in
            if let url = try? result.get().first {
                importedName = url.lastPathComponent
                Task {
                    let ocr = await OCRServicePlaceholder().recognizeText(from: importedName)
                    ocrSummary = "Document summary placeholder. OCR confidence \(Int(ocr.confidence * 100))%. Issues, clauses, and timeline entries queued for lawyer review."
                    modelContext.insert(LegalDocument(fileName: importedName, summary: ocrSummary))
                }
            }
        }
    }
}

private extension UTType {
    static var docx: UTType {
        UTType(filenameExtension: "docx") ?? .data
    }
}

struct ContractAnalyzerView: View {
    var profile: LegalProfile
    @Environment(\.appServices) private var services
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = AIWorkflowViewModel()

    var body: some View {
        AIWorkspaceView(
            title: "AI Contract Analyzer",
            subtitle: "Identify obligations, risks, unusual clauses, deadlines, renewal provisions, termination rights, and missing protections.",
            promptTitle: "Contract text or extracted clauses",
            buttonTitle: "Analyze Contract",
            systemImage: "doc.text.magnifyingglass",
            text: $viewModel.query,
            response: viewModel.response,
            isLoading: viewModel.isLoading,
            errorMessage: viewModel.errorMessage
        ) {
            await viewModel.run {
                let result = try await services.contracts.analyze(contractText: viewModel.query, jurisdiction: profile.jurisdiction, practiceArea: profile.practiceArea)
                modelContext.insert(ContractReview(riskScore: 64, findings: result.riskAnalysis.joined(separator: "\n")))
                return result
            }
        }
    }
}

struct LitigationStrategyView: View {
    var profile: LegalProfile
    @Environment(\.appServices) private var services
    @StateObject private var viewModel = AIWorkflowViewModel()

    var body: some View {
        AIWorkspaceView(
            title: "Litigation Strategy Builder",
            subtitle: "Input facts, parties, issues, and evidence to generate an issue map, strengths, weaknesses, argument structure, risks, and roadmap.",
            promptTitle: "Facts, parties, issues, and evidence",
            buttonTitle: "Build Strategy",
            systemImage: "point.3.connected.trianglepath.dotted",
            text: $viewModel.query,
            response: viewModel.response,
            isLoading: viewModel.isLoading,
            errorMessage: viewModel.errorMessage
        ) {
            await viewModel.run {
                try await services.litigation.build(facts: viewModel.query, jurisdiction: profile.jurisdiction, practiceArea: profile.practiceArea)
            }
        }
    }
}

struct DraftingAssistantView: View {
    var profile: LegalProfile
    @Environment(\.appServices) private var services
    @StateObject private var viewModel = AIWorkflowViewModel()
    @State private var draftType = "Legal Memo"
    private let types = ["Legal Memo", "Briefing Note", "Client Letter", "Issue Summary", "Research Summary", "Meeting Notes"]

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenTitle("AI Drafting Assistant", "Generate cautious legal work-product drafts with mandatory review language.")
                    Picker("Draft Type", selection: $draftType) {
                        ForEach(types, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                    AIWorkspaceViewContent(
                        promptTitle: "Instructions",
                        buttonTitle: "Generate Draft",
                        systemImage: "square.and.pencil",
                        text: $viewModel.query,
                        response: viewModel.response,
                        isLoading: viewModel.isLoading,
                        errorMessage: viewModel.errorMessage
                    ) {
                        await viewModel.run {
                            try await services.drafting.draft(kind: draftType, input: viewModel.query, jurisdiction: profile.jurisdiction, practiceArea: profile.practiceArea)
                        }
                    }
                    DisclaimerBlock()
                }
                .padding(18)
            }
        }
    }
}

struct AIWorkspaceViewContent: View {
    var promptTitle: String
    var buttonTitle: String
    var systemImage: String
    @Binding var text: String
    var response: AIResponse
    var isLoading: Bool
    var errorMessage: String?
    var action: () async -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            PremiumPanel {
                VStack(alignment: .leading, spacing: 12) {
                    Text(promptTitle).font(.headline)
                    TextEditor(text: $text)
                        .frame(minHeight: 150)
                        .scrollContentBackground(.hidden)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.black.opacity(0.28)))
                    Button { Task { await action() } } label: {
                        Label(buttonTitle, systemImage: systemImage).frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(LexisTheme.gold)
                    .foregroundStyle(.black)
                    .disabled(isLoading)
                }
            }
            if isLoading { LoadingPanel() }
            if let errorMessage { ErrorPanel(message: errorMessage) }
            if !response.summary.isEmpty { AIResponsePanel(response: response) }
        }
    }
}

struct ChronologyBuilderView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ChronologyEvent.eventDate) private var events: [ChronologyEvent]
    @State private var title = ""
    @State private var notes = ""
    @State private var date = Date()

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenTitle("Chronology Builder", "Create legal, event, hearing, and evidence timelines with export-ready structure.")
                    PremiumPanel {
                        VStack(alignment: .leading, spacing: 10) {
                            TextField("Event title", text: $title)
                            DatePicker("Event date", selection: $date, displayedComponents: .date)
                            TextField("Notes", text: $notes, axis: .vertical)
                            Button("Add Timeline Event") {
                                modelContext.insert(ChronologyEvent(title: title.isEmpty ? "Untitled event" : title, eventDate: date, notes: notes))
                                title = ""; notes = ""
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(LexisTheme.gold)
                            .foregroundStyle(.black)
                        }
                    }
                    if events.isEmpty {
                        EmptyState(title: "No chronology events", systemImage: "calendar.badge.clock", detail: "Add facts, hearings, disclosure events, evidence milestones, and limitation dates.")
                    } else {
                        LegalTimelineView(events: events)
                    }
                }
                .padding(18)
            }
        }
    }
}

struct KnowledgeGraphScreen: View {
    @Environment(\.appServices) private var services

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenTitle("Legal Knowledge Graph", "Interactive visualization of cases, statutes, regulations, principles, and research projects.")
                    KnowledgeGraphView(nodes: services.graph.starterNodes())
                    DisclaimerBlock()
                }
                .padding(18)
            }
        }
    }
}

struct AnalyticsDashboardView: View {
    @Query private var matters: [Matter]
    @Query private var documents: [LegalDocument]
    @Query private var research: [ResearchProject]
    @Query private var transcripts: [VoiceTranscript]

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenTitle("Analytics Dashboard", "Research activity, active matters, document volume, issue categories, and productivity metrics.")
                    AnalyticsChartCard(title: "Legal Productivity", metrics: [
                        AnalyticsMetric(label: "Matters", value: matters.count),
                        AnalyticsMetric(label: "Research", value: research.count),
                        AnalyticsMetric(label: "Docs", value: documents.count),
                        AnalyticsMetric(label: "Voice", value: transcripts.count)
                    ])
                    AnalyticsChartCard(title: "Issue Categories", metrics: [
                        AnalyticsMetric(label: "Case", value: 8),
                        AnalyticsMetric(label: "Statute", value: 5),
                        AnalyticsMetric(label: "Contract", value: 4),
                        AnalyticsMetric(label: "Evidence", value: 6)
                    ])
                }
                .padding(18)
            }
        }
    }
}

struct PDFExportView: View {
    var profile: LegalProfile
    @State private var shareURL: URL?

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenTitle("PDF Export Center", "Generate legal research reports, chronology reports, contract reviews, issue summaries, and strategy reports.")
                    ShareCardPreview(title: "Executive Legal Research Report", bodyText: "Includes jurisdiction notice, lawyer review recommendation, authority hierarchy, research roadmap, and disclaimer.")
                    Button {
                        shareURL = PDFExportService().makeReport(title: "LexisIQ AI Report", sections: [
                            "Profile: \(profile.profession), \(profile.jurisdiction), \(profile.practiceArea)",
                            "Lawyer review required. Informational tool only. Not legal advice.",
                            "Jurisdiction-specific verification recommended. AI outputs may contain errors."
                        ])
                    } label: {
                        Label("Generate PDF", systemImage: "doc.richtext").frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(LexisTheme.gold)
                    .foregroundStyle(.black)
                    DisclaimerBlock()
                }
                .padding(18)
            }
        }
        .sheet(item: Binding(get: {
            shareURL.map { ShareURL(url: $0) }
        }, set: { shareURL = $0?.url })) { item in
            ShareSheet(items: [item.url])
        }
    }
}

struct ShareURL: Identifiable {
    let id = UUID()
    var url: URL
}

struct ScreenTitle: View {
    var title: String
    var subtitle: String

    init(_ title: String, _ subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(.largeTitle, design: .serif, weight: .bold))
                .foregroundStyle(.white)
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(LexisTheme.ink)
        }
    }
}
