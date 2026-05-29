import SwiftData
import SwiftUI

struct MattersView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Matter.createdAt, order: .reverse) private var matters: [Matter]
    @State private var title = ""
    @State private var notes = ""
    @State private var status = "Active"

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenTitle("Matter Management", "Track client placeholders, matters, deadlines, research projects, document collections, and notes.")
                    PremiumPanel {
                        VStack(alignment: .leading, spacing: 10) {
                            TextField("Matter title", text: $title)
                            Picker("Status", selection: $status) {
                                Text("Active").tag("Active")
                                Text("Review").tag("Review")
                                Text("Closed").tag("Closed")
                            }
                            .pickerStyle(.segmented)
                            TextField("Matter notes", text: $notes, axis: .vertical)
                            Button {
                                modelContext.insert(Matter(title: title.isEmpty ? "Untitled Matter" : title, status: status, notes: notes))
                                title = ""; notes = ""; status = "Active"
                            } label: {
                                Label("Add Matter", systemImage: "plus").frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(LexisTheme.gold)
                            .foregroundStyle(.black)
                        }
                    }
                    if matters.isEmpty {
                        EmptyState(title: "No matters", systemImage: "folder", detail: "Create a matter workspace for research, documents, deadlines, chronology, and notes.")
                    } else {
                        ForEach(matters) { matter in
                            MatterCard(title: matter.title, status: matter.status, notes: matter.notes)
                        }
                    }
                }
                .padding(18)
            }
        }
    }
}

struct PaywallView: View {
    @EnvironmentObject private var store: SubscriptionStore

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenTitle("LexisIQ AI Plans", "Premium legal intelligence for professionals, chambers, and enterprise-grade workspaces.")
                    PlanCard(name: "Free", price: "£0", features: ["Limited searches", "Limited uploads", "Limited voice notes"])
                    PlanCard(name: "Professional", price: "£29.99/mo or £249.99/yr", features: ["Unlimited research", "Unlimited voice processing", "Contract analyzer", "Litigation tools", "PDF exports"])
                    PlanCard(name: "Chambers", price: "£99.99/mo", features: ["Advanced research", "Advanced analytics", "Matter management", "Premium workspaces", "Knowledge graph"])

                    if store.isLoading {
                        LoadingPanel()
                    } else if store.products.isEmpty {
                        PremiumPanel {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("StoreKit 2 scaffolding")
                                    .font(.headline)
                                Text("Product IDs are ready. Configure App Store Connect products to enable live purchases.")
                                    .font(.caption)
                                    .foregroundStyle(LexisTheme.ink)
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    DisclaimerBlock()
                }
                .padding(18)
            }
        }
        .task { await store.loadProducts() }
    }
}

struct PlanCard: View {
    var name: String
    var price: String
    var features: [String]

    var body: some View {
        PremiumPanel {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(name)
                        .font(.system(.title2, design: .serif, weight: .bold))
                    Spacer()
                    Text(price)
                        .font(.headline)
                        .foregroundStyle(LexisTheme.gold)
                }
                ForEach(features, id: \.self) { feature in
                    Label(feature, systemImage: "checkmark")
                        .font(.caption)
                        .foregroundStyle(LexisTheme.ink)
                }
                Button {
                } label: {
                    Label(name == "Free" ? "Current Plan" : "Upgrade", systemImage: name == "Free" ? "checkmark.circle" : "crown")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint(LexisTheme.gold)
            }
            .foregroundStyle(.white)
        }
    }
}

struct SettingsView: View {
    var profile: LegalProfile
    @Environment(\.modelContext) private var modelContext
    @State private var voiceProcessing = true
    @State private var includeDisclaimers = true
    @State private var exportCitations = true

    var body: some View {
        ZStack {
            PremiumBackground()
            Form {
                Section("Subscription") {
                    Text("Plan: Free placeholder")
                    NavigationLink("Manage Plans") { PaywallView() }
                }
                Section("Jurisdiction") {
                    Text(profile.jurisdiction)
                    Text(profile.practiceArea)
                }
                Section("Voice Settings") {
                    Toggle("AI voice note processing", isOn: $voiceProcessing)
                }
                Section("Export Settings") {
                    Toggle("Include legal disclaimer", isOn: $includeDisclaimers)
                    Toggle("Include citation placeholders", isOn: $exportCitations)
                }
                Section("Legal") {
                    NavigationLink("Privacy Policy") { LegalTextView(title: "Privacy Policy", text: "Privacy policy placeholder. Store local SwiftData securely and connect enterprise retention, encryption, and account controls before production release.") }
                    NavigationLink("Terms") { LegalTextView(title: "Terms", text: "Terms placeholder. This app is an informational productivity platform and does not provide legal representation.") }
                    NavigationLink("Legal Disclaimer") { LegalTextView(title: "Legal Disclaimer", text: "Informational tool only. Not legal advice. Lawyer review required. Jurisdiction-specific verification recommended. AI outputs may contain errors.") }
                }
                Section("Data") {
                    Button(role: .destructive) {
                        try? modelContext.delete(model: LegalProfile.self)
                        try? modelContext.delete(model: Matter.self)
                        try? modelContext.delete(model: ResearchProject.self)
                        try? modelContext.delete(model: LegalDocument.self)
                        try? modelContext.delete(model: VoiceTranscript.self)
                        try? modelContext.delete(model: ContractReview.self)
                        try? modelContext.delete(model: ChronologyEvent.self)
                        try? modelContext.delete(model: KnowledgeGraphNode.self)
                    } label: {
                        Label("Delete All Data", systemImage: "trash")
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Settings")
    }
}

struct LegalTextView: View {
    var title: String
    var text: String

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenTitle(title, "LexisIQ AI policy and disclaimer surface.")
                    PremiumPanel {
                        Text(text)
                            .font(.body)
                            .foregroundStyle(LexisTheme.ink)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(18)
            }
        }
    }
}

struct PlaceholderArchitectureView: View {
    var title: String
    var bullets: [String]

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenTitle("\(title) Placeholder", "Architecture placeholder for a future companion target.")
                    PremiumPanel {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(bullets, id: \.self) { bullet in
                                Label(bullet, systemImage: "checkmark.seal")
                                    .foregroundStyle(LexisTheme.ink)
                            }
                        }
                    }
                }
                .padding(18)
            }
        }
    }
}

