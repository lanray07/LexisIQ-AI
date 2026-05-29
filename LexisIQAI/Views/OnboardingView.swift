import SwiftData
import SwiftUI

struct OnboardingView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var profession = "Solicitor"
    @State private var jurisdiction = "England & Wales"
    @State private var practiceArea = "Litigation"

    private let professions = ["Solicitor", "Barrister", "Legal Researcher", "Law Student", "In-House Counsel", "Compliance Officer", "Consultant"]
    private let jurisdictions = ["England & Wales", "Scotland", "Northern Ireland", "United States", "Canada", "Australia", "Other"]
    private let practiceAreas = ["Litigation", "Corporate", "Employment", "Family", "Property", "Criminal", "Immigration", "Commercial", "Compliance", "Tax", "Custom"]

    var body: some View {
        ZStack {
            PremiumBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("LexisIQ AI")
                            .font(.system(size: 44, weight: .bold, design: .serif))
                            .foregroundStyle(.white)
                        Text("The Bloomberg Terminal for Legal Professionals")
                            .font(.headline)
                            .foregroundStyle(LexisTheme.gold)
                        Text("Enterprise legal research, case intelligence, document analysis, litigation preparation, and productivity workflows.")
                            .font(.subheadline)
                            .foregroundStyle(LexisTheme.ink)
                    }
                    .padding(.top, 24)

                    HumanAssetPlaceholderView(title: "Executive legal intelligence imagery placeholder", systemImage: "building.columns")

                    PremiumPanel {
                        VStack(spacing: 16) {
                            Picker("Profession", selection: $profession) {
                                ForEach(professions, id: \.self) { Text($0) }
                            }
                            Picker("Jurisdiction", selection: $jurisdiction) {
                                ForEach(jurisdictions, id: \.self) { Text($0) }
                            }
                            Picker("Practice Area", selection: $practiceArea) {
                                ForEach(practiceAreas, id: \.self) { Text($0) }
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(LexisTheme.gold)
                    }

                    Button {
                        createWorkspace()
                    } label: {
                        Label("Generate Legal Workspace", systemImage: "sparkles")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(LexisTheme.gold)
                    .foregroundStyle(.black)

                    DisclaimerBlock()
                }
                .padding(20)
            }
        }
    }

    private func createWorkspace() {
        modelContext.insert(LegalProfile(profession: profession, jurisdiction: jurisdiction, practiceArea: practiceArea))
        modelContext.insert(Matter(title: "Executive Research Desk", notes: "Personalized workspace for \(practiceArea.lowercased()) in \(jurisdiction)."))
        modelContext.insert(ResearchProject(title: "Initial Research Dashboard", topic: practiceArea, summary: "Ready for issue searches, authority mapping, and lawyer-reviewed reports."))
        modelContext.insert(SubscriptionState())
        modelContext.insert(KnowledgeGraphNode(nodeType: "Matter", title: "Executive Research Desk"))
    }
}
