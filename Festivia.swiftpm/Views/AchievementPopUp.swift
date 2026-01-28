import SwiftUI

struct AchievementPopUp: View {
    @ObservedObject var achievementManager: AchievementManager
    
    var body: some View {
        if achievementManager.showPopUp, let achievement = achievementManager.latestAchievement {
            ZStack {
                Color.black.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    
                    Text(" Achievement Unlocked! ")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 5)
                        .shadow(radius: 5)
                    
                    Text(achievement.name)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .multilineTextAlignment(.center)
                    
                    Text(achievement.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 15)
                        .multilineTextAlignment(.center)
                    
                    Image(achievement.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                    
                    Button(action: {
                        achievementManager.showPopUp = false
                    }) {
                        Text("Got it!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .padding(.horizontal, 30)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal, 30)
                
            }
        }
    }
}
