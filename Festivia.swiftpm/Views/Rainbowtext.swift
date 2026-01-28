import SwiftUI

struct Rainbowtext: View {
    let text:String
    @State private var textColor = Color.blue
    @State private var scaleEffect: CGFloat = 1.0
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .foregroundStyle(textColor)
            .bold()
            .padding()

            .scaleEffect(scaleEffect)
            .onTapGesture {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0)) {
                    scaleEffect = 1.2
                    cycleTextColor(&textColor)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeOut(duration: 0.2)) {
                        scaleEffect = 1.0
                    }
                }
            }
    }
}
