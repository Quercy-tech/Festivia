import AVKit
import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @State private var currentIndex: Int = 0
    
    @State private var textColor = Color.blue
    @State private var scaleEffect: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Rainbowtext(text: "Festivia")
                Text("(Tap me)")
                    .padding(.top,-15)
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary)
                Image("onboarding\(currentIndex+1)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350,height: 350)
                    .transition(.slide)
                Spacer()
                HStack {
                    if currentIndex > 0 {
                        Button(action: {
                            withAnimation {
                                currentIndex = max(currentIndex - 1, 0)
                            }
                        }) {
                            Text("Back")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                    
                    if currentIndex < 3 {
                        Button(action: {
                            withAnimation {
                                currentIndex = min(currentIndex + 1, 3)
                            }
                        }) {
                            Text("Next")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    } else {
                        Button(action: {
                            hasSeenOnboarding = true
                        }) {
                            Text("Get Started")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    
                }
                .padding(.horizontal)
                
                
                
                Button(action: {
                    hasSeenOnboarding = true
                }) {
                    Text("Skip")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.vertical)
                }
                
                Spacer()
                    .transition(.slide)
            }
        }
    }
}

extension HolidaysView {
    func showOnboarding() -> some View {
        
        ZStack {
            if !hasSeenOnboarding {
                OnboardingView()
            }
        }
    }
}
