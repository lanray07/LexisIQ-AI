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
    @State private var purchaseMessage: PurchaseMessage?

    private let privacyURL = URL(string: "https://github.com/lanray07/LexisIQ-AI/blob/main/PRIVACY.md")!
    private let eulaURL = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ScreenTitle("LexisIQ AI Plans", "Premium legal intelligence for professionals, chambers, and enterprise-grade workspaces.")
                    PlanCard(name: "Free", price: "GBP 0", renewal: "No subscription. Limited local productivity access.", features: ["Limited searches", "Limited uploads", "Limited voice notes"]) {
                        purchaseMessage = PurchaseMessage(title: "Free Plan Active", body: "You are currently using the Free plan.")
                    }
                    PlanCard(name: "Professional Monthly", price: "GBP 29.99", renewal: "Auto-renews monthly until cancelled.", features: ["Unlimited research", "Unlimited voice processing", "Contract analyzer", "Litigation tools", "PDF exports"]) {
                        Task { await purchase(SubscriptionStore.professionalMonthly, planName: "Professional Monthly") }
                    }
                    PlanCard(name: "Professional Yearly", price: "GBP 249.99", renewal: "Auto-renews yearly until cancelled.", features: ["Unlimited research", "Unlimited voice processing", "Contract analyzer", "Litigation tools", "PDF exports"]) {
                        Task { await purchase(SubscriptionStore.professionalYearly, planName: "Professional Yearly") }
                    }
                    PlanCard(name: "Chambers Monthly", price: "GBP 99.99", renewal: "Auto-renews monthly until cancelled.", features: ["Advanced research", "Advanced analytics", "Matter management", "Premium workspaces", "Knowledge graph"]) {
                        Task { await purchase(SubscriptionStore.chambersMonthly, planName: "Chambers Monthly") }
                    }

                    if store.isLoading {
                        LoadingPanel()
                    } else if store.products.isEmpty {
                        PremiumPanel {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("StoreKit 2 scaffolding")
                                    .font(.headline)
                                Text("Product IDs are configured. Live purchasing is available when App Store Connect returns the approved subscription products.")
                                    .font(.caption)
                                    .foregroundStyle(LexisTheme.ink)
                            }
                            .foregroundStyle(.white)
                        }
                    }

                    PremiumPanel {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Subscription Terms")
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text("Subscriptions renew automatically unless cancelled at least 24 hours before the end of the current period. Payment is charged to your Apple ID. Manage or cancel subscriptions in your App Store account settings.")
                                .font(.caption)
                                .foregroundStyle(LexisTheme.ink)
                            HStack(spacing: 14) {
                                Link("Privacy Policy", destination: privacyURL)
                                Link("Terms of Use (EULA)", destination: eulaURL)
                            }
                            .font(.caption.weight(.semibold))
                            .tint(LexisTheme.gold)
                        }
                    }
                    DisclaimerBlock()
                }
                .padding(18)
            }
        }
        .task { await store.loadProducts() }
        .alert(item: $purchaseMessage) { message in
            Alert(title: Text(message.title), message: Text(message.body), dismissButton: .default(Text("OK")))
        }
    }

    private func purchase(_ productID: String, planName: String) async {
        purchaseMessage = PurchaseMessage(title: "Preparing Purchase", body: "Loading \(planName) through StoreKit.")
        do {
            let didStartPurchase = try await store.purchase(productID: productID)
            if didStartPurchase {
                purchaseMessage = PurchaseMessage(title: "Purchase Updated", body: "\(planName) was processed by StoreKit. Apple will confirm the final subscription status.")
            } else {
                purchaseMessage = PurchaseMessage(title: "Subscription Unavailable", body: "\(planName) is configured for StoreKit but is not currently available from App Store Connect. Please try again after the subscription products are approved.")
            }
        } catch {
            purchaseMessage = PurchaseMessage(title: "Purchase Error", body: error.localizedDescription)
        }
    }
}

struct PlanCard: View {
    var name: String
    var price: String
    var renewal: String
    var features: [String]
    var action: () -> Void

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
                Text(renewal)
                    .font(.caption)
                    .foregroundStyle(LexisTheme.muted)
                ForEach(features, id: \.self) { feature in
                    Label(feature, systemImage: "checkmark")
                        .font(.caption)
                        .foregroundStyle(LexisTheme.ink)
                }
                Button {
                    action()
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

struct PurchaseMessage: Identifiable {
    let id = UUID()
    let title: String
    let body: String
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
                    Link("Privacy Policy", destination: URL(string: "https://github.com/lanray07/LexisIQ-AI/blob/main/PRIVACY.md")!)
                    Link("Terms of Use (EULA)", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
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
