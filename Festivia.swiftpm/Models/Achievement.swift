import SwiftUI

struct Achievement: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let image: String
    var isUnlocked: Bool = false
}

var achievements: [Achievement] = [
    Achievement(name: "First Discovery", description: "View a country for the first time", image: "discovery"),
    Achievement(name: "Explorer", description: "View 3 different countries", image: "explorer"),
    Achievement(name: "Adventurer", description: "View 10 different countries", image: "adventurer"),
    Achievement(name: "Globetrotter", description: "View 25 different countries", image: "globetrotter"),
    Achievement(name: "World Traveler", description: "View 50 different countries", image: "world_explorer"),
    Achievement(name: "Ultimate Explorer", description: "View 100 different countries", image: "ultimate"),
    Achievement(name: "Daily User", description: "Open the app for 3 days", image: "daily"),
    Achievement(name: "Consistent Traveler", description: "Open the app for 7 days", image: "consistent"),
    Achievement(name: "Year Cruise", description: "Open the app for 14 days", image: "dedicated"),
    Achievement(name: "Night Owl", description: "Open the app between 2 AM - 4 AM", image: "nightowl"),
    Achievement(name: "Early Bird", description: "Open the app between 5 AM - 6 AM", image: "earlybird"),
    Achievement(name: "Holiday Explorer", description: "Check 1 different holiday description", image: "book"),
    Achievement(name: "Holiday Passion", description: "Check 5 different holiday descriptions", image: "reader"),
    Achievement(name: "Holiday Enthusiast", description: "Check 20 different holiday descriptions", image: "bookSparkle")
]


