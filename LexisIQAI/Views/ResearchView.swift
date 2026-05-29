import SwiftData
import SwiftUI

struct ResearchView: View {
    var profile: LegalProfile
    @Environment(\.appServices) private var services
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = AIWorkflowViewModel()

    var body: some View {
        AIWorkspaceView(
            title: "AI Legal Research Engine",
            subtitle: "Search legal issues, case names, statutes, regulations, keywords, and principles.",
            promptTitle: "Research query",
            buttonTitle: "Research Issue",
            systemImage: "magnifyingglass",
            text: $viewModel.query,
            response: viewModel.response,
            isLoading: viewModel.isLoading,
            errorMessage: viewModel.errorMessage
        ) {
            await viewModel.run {
                let result = try await services.legalResearch.research(query: viewModel.query, jurisdiction: profile.jurisdiction, practiceArea: profile.practiceArea)
                modelContext.insert(ResearchProject(title: viewModel.query.isEmpty ? "Legal Research" : viewModel.query, topic: profile.practiceArea, summary: result.summary))
                return result
            }
        }
    }
}

struct AIWorkspaceView: View {
    var title: String
    var subtitle: String
    var promptTitle: String
    var buttonTitle: String
    var systemImage: String
    @Binding var text: String
    var response: AIResponse
    var isLoading: Bool
    var errorMessage: String?
    var action: () async -> Void

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(title)
                        .font(.system(.largeTitle, design: .serif, weight: .bold))
                        .foregroundStyle(.white)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(LexisTheme.ink)

                    if title == "AI Legal Research Engine" {
                        PremiumHumanAssetView(title: "AI research desk", assetName: "research-desk")
                    }

                    PremiumPanel {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(promptTitle).font(.headline)
                            TextEditor(text: $text)
                                .frame(minHeight: 150)
                                .scrollContentBackground(.hidden)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 8).fill(.black.opacity(0.28)))
                            Button {
                                Task { await action() }
                            } label: {
                                Label(buttonTitle, systemImage: systemImage).frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(LexisTheme.gold)
                            .foregroundStyle(.black)
                            .disabled(isLoading)
                        }
                        .foregroundStyle(.white)
                    }

                    if isLoading {
                        LoadingPanel()
                    }

                    if let errorMessage {
                        ErrorPanel(message: errorMessage)
                    }

                    if !response.summary.isEmpty {
                        AIResponsePanel(response: response)
                    } else if !isLoading {
                        EmptyState(title: "Awaiting intelligence", systemImage: systemImage, detail: "Mock AI is enabled by default for private, offline-friendly demos.")
                    }

                    DisclaimerBlock()
                }
                .padding(18)
            }
        }
    }
}

struct AIResponsePanel: View {
    var response: AIResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            PremiumPanel {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Label("Confidence", systemImage: "gauge.with.dots.needle.bottom.50percent")
                        Spacer()
                        Text("\(Int(response.confidence * 100))%").foregroundStyle(LexisTheme.gold)
                    }
                    ProgressView(value: response.confidence)
                        .tint(LexisTheme.gold)
                    Text(response.jurisdictionNote)
                        .font(.caption)
                        .foregroundStyle(LexisTheme.ink)
                }
                .foregroundStyle(.white)
            }
            ResponseSection(title: "Plain English Summary", items: [response.summary])
            ResponseSection(title: "Issue Analysis", items: response.insights)
            ResponseSection(title: "Research Roadmap", items: response.researchRoadmap)
            ResponseSection(title: "Risk and Verification", items: response.riskAnalysis)
            ResponseSection(title: "Draft Work Product", items: [response.draft])
        }
    }
}

struct ResponseSection: View {
    var title: String
    var items: [String]

    var body: some View {
        PremiumPanel {
            VStack(alignment: .leading, spacing: 10) {
                Text(title).font(.headline).foregroundStyle(.white)
                ForEach(items, id: \.self) { item in
                    Label(item, systemImage: "diamond.fill")
                        .font(.caption)
                        .foregroundStyle(LexisTheme.ink)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

struct LoadingPanel: View {
    var body: some View {
        PremiumPanel {
            HStack {
                ProgressView().tint(LexisTheme.gold)
                Text("Analyzing with LexisIQ mock intelligence...")
                    .foregroundStyle(LexisTheme.ink)
            }
        }
    }
}

struct ErrorPanel: View {
    var message: String

    var body: some View {
        PremiumPanel {
            Label(message, systemImage: "exclamationmark.triangle")
                .foregroundStyle(LexisTheme.red)
        }
    }
}
