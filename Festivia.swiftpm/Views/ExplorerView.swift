import SwiftUI
import MapKit

struct ExploreView: View {
    @Binding var countryName: String
    @State private var region = MKCoordinateRegion( 
        center: CLLocationCoordinate2D(latitude: 37.0902, longitude: -95.7129),
        span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)) // Default place: United States
    
    
    @State private var textColor = Color.blue
    @State private var scaleEffect: CGFloat = 1.0
    @ObservedObject var achievementManager: AchievementManager
    
    private let animationDuration = 0.3
    
    var body: some View {
        VStack {
            Map(initialPosition: .region(region)) {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) { 
                        Button(action: {
                            onAnnotationTapped(location: location)
                        }, label: {
                            AnnotationView(location: location, countryName: $countryName)
                        })
                    }
                }
            }
            
            Text("Selected Country: \(countryName)")
                .font(.headline)
                .padding()
                .font(.largeTitle)
                .foregroundColor(textColor)
                .scaleEffect(scaleEffect)
                .transition(.opacity.combined(with: .scale))
                .animation(.easeInOut(duration: animationDuration), value: scaleEffect)
        }
        .overlay(AchievementPopUp(achievementManager: achievementManager))
    }
    
    private func onAnnotationTapped(location: CountryLocation) {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
            countryName = location.name
            achievementManager.addViewedCountry(countryName)
            scaleEffect = 1.2
            cycleTextColor(&textColor)
        }
        
            withAnimation {
                scaleEffect = 1.0
            }
    }
}

struct AnnotationView: View {
    var location: CountryLocation
    @Binding var countryName: String
    @State private var scaleEffect: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Image(systemName: "mappin.circle.fill")
                .foregroundStyle(.red)
                .font(.largeTitle)
                .scaleEffect(countryName == location.name ? 1.3 : 1.0)
                .animation(.spring, value: countryName)
            Text(location.name)
                .font(.caption)
                .padding(4)
                .background(Color.white.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

func cycleTextColor(_ textColor: inout Color) {
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    textColor = colors.randomElement() ?? .blue
}
