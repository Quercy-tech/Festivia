import SwiftUI

struct AchievementCard: View {
    var achievement: Achievement
    @ObservedObject var achievementManager: AchievementManager
    
    @State private var isTapped = false
    
    var body: some View {
        VStack {
            if (achievementManager.unlockedAchievements.contains(achievement.name)) {
                Image(achievement.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(15)
                    .overlay(Circle().stroke( Color.green, lineWidth: 5))
            } else {
                Image(systemName: "lock.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(15)
                    .overlay(Circle().stroke( Color.green, lineWidth: 5))
            }
            Text(achievement.name)
                .font(.headline)
                .padding(10)
            Text(achievement.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(width: 150, height: 230)
        .padding()
        .cornerRadius(10)
        .shadow(radius: 5)
        .scaleEffect(isTapped ? 1.1 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isTapped)
        .onTapGesture {
            isTapped = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isTapped = false
            }
        }
    }
}
