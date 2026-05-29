import SwiftData
import SwiftUI

@main
struct LexisIQAIApp: App {
    @StateObject private var subscriptionStore = SubscriptionStore()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            LegalProfile.self,
            Matter.self,
            ResearchProject.self,
            LegalDocument.self,
            VoiceTranscript.self,
            ContractReview.self,
            ChronologyEvent.self,
            KnowledgeGraphNode.self,
            SubscriptionState.self
        ])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Could not create SwiftData container: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.appServices, AppServices())
                .environmentObject(subscriptionStore)
                .preferredColorScheme(.dark)
        }
        .modelContainer(sharedModelContainer)
    }
}

private struct AppServicesKey: EnvironmentKey {
    static let defaultValue = AppServices()
}

extension EnvironmentValues {
    var appServices: AppServices {
        get { self[AppServicesKey.self] }
        set { self[AppServicesKey.self] = newValue }
    }
}

