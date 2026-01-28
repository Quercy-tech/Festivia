import SwiftUI

@main
struct Festivia: App {
    @StateObject var achievementManager = AchievementManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(achievementManager: achievementManager)
        }
    }
}
