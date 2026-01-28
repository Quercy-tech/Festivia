import SwiftUI

struct AchievementView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var columns: [GridItem] {
        if horizontalSizeClass == .regular {
            return [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]
        } else {
            return [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]
        } 
    }
    
    @ObservedObject var achievementManager: AchievementManager
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(achievements) { achievement in
                        AchievementCard(achievement: achievement, achievementManager: achievementManager)
                            .padding()
                    }
                }
            }
        }
    }
}
