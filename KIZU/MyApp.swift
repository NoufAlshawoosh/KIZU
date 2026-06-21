import SwiftUI

@main
struct MyApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                if hasSeenOnboarding {
                    ContentView()
                        .transition(.move(edge: .trailing))
                } else {
                    OnboardingPageView()
                        .transition(.move(edge: .leading))
                }
            }
            .animation(.easeInOut(duration: 0.4), value: hasSeenOnboarding)
        }
    }
}
