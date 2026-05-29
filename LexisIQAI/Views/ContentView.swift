import SwiftData
import SwiftUI

struct ContentView: View {
    @Query private var profiles: [LegalProfile]

    var body: some View {
        if profiles.isEmpty {
            OnboardingView()
        } else {
            MainTabView(profile: profiles[0])
        }
    }
}

struct MainTabView: View {
    var profile: LegalProfile

    var body: some View {
        TabView {
            NavigationStack { DashboardView(profile: profile) }
                .tabItem { Label("Desk", systemImage: "rectangle.grid.2x2") }
            NavigationStack { ResearchView(profile: profile) }
                .tabItem { Label("Research", systemImage: "magnifyingglass") }
            NavigationStack { VoiceNotesView(profile: profile) }
                .tabItem { Label("Voice", systemImage: "waveform") }
            NavigationStack { MattersView() }
                .tabItem { Label("Matters", systemImage: "folder") }
            NavigationStack { MoreView(profile: profile) }
                .tabItem { Label("More", systemImage: "ellipsis.circle") }
        }
        .tint(LexisTheme.gold)
    }
}

