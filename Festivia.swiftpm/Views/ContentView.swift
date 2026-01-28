import SwiftUI

struct ContentView: View {
    @State private var selectedCountry = Locale.current.region?.identifier ?? "United States"
    @ObservedObject var achievementManager: AchievementManager

    var body: some View {
        TabView { 
            
            Tab { 
                HolidaysView(countryCode: $selectedCountry, achievementManager: achievementManager)
            } label: {
                Label("Holidays", systemImage: "rainbow")
                    .symbolRenderingMode(.palette)
            }
            
            Tab {
                ExploreView(countryName: $selectedCountry, achievementManager: achievementManager)
            } label: {
                Label("Explore", systemImage: "globe")
                    .symbolRenderingMode(.palette)
            } 
            
            Tab {
                AchievementView(achievementManager: achievementManager)
            } label: {
                Label("Achievements", systemImage:  "circle.hexagongrid.fill")
                    .symbolRenderingMode(.palette)
            } 

            Tab {
                LegendView()
            } label: {
                Label("Legend", systemImage: "book")
                    .symbolRenderingMode(.multicolor)
            }
        }
    }
}
