import SwiftData
import SwiftUI

struct DashboardView: View {
    var profile: LegalProfile
    @Query(sort: \Matter.createdAt, order: .reverse) private var matters: [Matter]
    @Query(sort: \ResearchProject.createdAt, order: .reverse) private var research: [ResearchProject]
    @Query(sort: \ContractReview.createdAt, order: .reverse) private var contracts: [ContractReview]
    @Query(sort: \VoiceTranscript.createdAt, order: .reverse) private var voiceNotes: [VoiceTranscript]

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("LexisIQ Command Desk")
                            .font(.system(.largeTitle, design: .serif, weight: .bold))
                            .foregroundStyle(.white)
                        Text("\(profile.profession) | \(profile.jurisdiction) | \(profile.practiceArea)")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(LexisTheme.gold)
                    }

                    UpgradeBanner()
                    HumanAssetPlaceholderView(title: "Courtroom strategy workspace placeholder", systemImage: "briefcase")
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 12)], spacing: 12) {
                        StatTile(title: "Active Matters", value: matters.count, icon: "folder")
                        StatTile(title: "Research", value: research.count, icon: "magnifyingglass")
                        StatTile(title: "Contracts", value: contracts.count, icon: "doc.text.magnifyingglass")
                        StatTile(title: "Voice Notes", value: voiceNotes.count, icon: "waveform")
                    }

                    SectionHeader(title: "Quick Actions", detail: "Mock AI Active")
                    QuickActionGrid()

                    SectionHeader(title: "Recent Research")
                    if research.isEmpty {
                        EmptyState(title: "No research yet", systemImage: "magnifyingglass", detail: "Start with a legal issue, statute, case name, regulation, or principle.")
                    } else {
                        ForEach(research.prefix(3)) { item in
                            ResearchCard(title: item.title, summary: item.summary)
                        }
                    }

                    SectionHeader(title: "Active Matters")
                    ForEach(matters.prefix(3)) { matter in
                        MatterCard(title: matter.title, status: matter.status, notes: matter.notes)
                    }

                    if let latestContract = contracts.first {
                        SectionHeader(title: "Latest Contract Review")
                        ContractRiskCard(score: latestContract.riskScore, findings: latestContract.findings)
                    }

                    DisclaimerBlock()
                }
                .padding(18)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StatTile: View {
    var title: String
    var value: Int
    var icon: String

    var body: some View {
        PremiumPanel {
            VStack(alignment: .leading, spacing: 14) {
                Image(systemName: icon).foregroundStyle(LexisTheme.gold)
                Text("\(value)").font(.system(size: 32, weight: .bold, design: .serif))
                Text(title.uppercased()).font(.caption2.weight(.bold)).foregroundStyle(LexisTheme.muted)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct QuickActionGrid: View {
    private let actions = [
        ("Research Issue", "magnifyingglass"),
        ("Analyze Contract", "doc.text.magnifyingglass"),
        ("Voice Notes", "waveform"),
        ("Build Timeline", "calendar.badge.clock"),
        ("Draft Memo", "square.and.pencil"),
        ("Upload Document", "tray.and.arrow.up")
    ]

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 155), spacing: 10)], spacing: 10) {
            ForEach(actions, id: \.0) { action in
                Button {} label: {
                    Label(action.0, systemImage: action.1)
                        .font(.subheadline.weight(.semibold))
                        .frame(maxWidth: .infinity, minHeight: 46)
                }
                .buttonStyle(.bordered)
                .tint(LexisTheme.gold)
            }
        }
    }
}

struct EmptyState: View {
    var title: String
    var systemImage: String
    var detail: String

    var body: some View {
        PremiumPanel {
            VStack(spacing: 10) {
                Image(systemName: systemImage).font(.title2).foregroundStyle(LexisTheme.gold)
                Text(title).font(.headline)
                Text(detail).font(.caption).foregroundStyle(LexisTheme.muted).multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
        }
    }
}
