import SwiftUI

class AchievementManager: ObservableObject {
    @Published var unlockedAchievements: [String] = []
    @Published var showPopUp = false
    @Published var latestAchievement: Achievement?
    
    private let viewedCountriesKey = "viewedCountries"
    private let appUsageKey = "appUsage"
    private let descriptionButtonKey = "descriptionButton"
    private let unlockedAchievementsKey = "unlockedAchievements"
    
    init() {
       // clearData()
        print("------------------------------")
        print("AchievementManager initialized")
        print(unlockedAchievements)
        loadAchievements()
        trackAppUsage()
        checkSpecialAchievements()
    }
    
    func clearData() {
        UserDefaults.standard.removeObject(forKey: "viewedCountries")
        UserDefaults.standard.removeObject(forKey: "appUsage")
        UserDefaults.standard.removeObject(forKey: "descriptionButton")
        UserDefaults.standard.removeObject(forKey: "unlockedAchievements")
    }
    
    func loadAchievements() {
        
        print("Loading achievements...")
        if let savedIDs = UserDefaults.standard.array(forKey: "unlockedAchievements") as? [String] {
            unlockedAchievements = savedIDs.compactMap { $0 }
        }
        
        if let savedData = UserDefaults.standard.array(forKey: viewedCountriesKey) as? [String] {
            checkCountryAchievements(count: savedData.count)
        }
        if let appOpens = UserDefaults.standard.integer(forKey: appUsageKey) as Int? {
            checkAppUsageAchievements(count: appOpens)
        }
        
        if let descriptionButtonClicked = UserDefaults.standard.integer(forKey: descriptionButtonKey) as Int? {
            checkAppUsageAchievements(count: descriptionButtonClicked)
        }
    }
    
    func addViewedCountry(_ country: String) {
        print("Adding new country")
        var viewedCountries = UserDefaults.standard.array(forKey: viewedCountriesKey) as? [String] ?? []
        if !viewedCountries.contains(country) {
            viewedCountries.append(country)
            UserDefaults.standard.set(viewedCountries, forKey: viewedCountriesKey)
            checkCountryAchievements(count: viewedCountries.count)
        }
    }
    
    
    func trackAppUsage() {
        print("Track app usage")
        let currentCount = UserDefaults.standard.integer(forKey: appUsageKey)
        print("Days used the app: \(currentCount)")
        let newCount = currentCount + 1
        UserDefaults.standard.set(newCount, forKey: appUsageKey)
        checkAppUsageAchievements(count: newCount)
    }
    
    func addButtonClick() {
        print("Clicked on description button")
        let currentCount = UserDefaults.standard.integer(forKey: descriptionButtonKey)
        let newCount = currentCount + 1
        UserDefaults.standard.set(newCount, forKey: descriptionButtonKey)
        checkDescriptionAchievements(count: newCount)
    }
    
    private func checkCountryAchievements(count: Int) {
        print("Check for country count")
        print("The count: \(count)")
        let achievementMap: [Int: String] = [
            1: "First Discovery",
            3: "Explorer",
            10: "Adventurer",
            25: "Globetrotter",
            50: "World Traveler",
            100: "Ultimate Explorer"
        ]
        
        
        if let achievementName = achievementMap[count] {
            print("Achievement to unlock: \(achievementName)")
            unlockSpecificAchievement(named: achievementName)
        }
    }
    
    private func checkAppUsageAchievements(count: Int) {
        print("Check app usage amount")
        print("The count: \(count)")
        let achievementMap: [Int: String] = [
            3: "Daily User",
            7: "Consistent Traveler",
            14: "Year Cruise"
        ]
        
        if let achievementName = achievementMap[count] {
            unlockSpecificAchievement(named: achievementName)
        }
    }
    
    private func checkDescriptionAchievements(count: Int) {
        print("Check description amount")
        print("The count: \(count)")
        let achievementMap: [Int: String] = [
            1: "Holiday Explorer",
            5: "Holiday Passion",
            20: "Holiday Enthusiast"
        ]
        
        if let achievementName = achievementMap[count] {
            unlockSpecificAchievement(named: achievementName)
        }
    }
    
    private func checkSpecialAchievements() {
        print("Check time amount")
        let hour = Calendar.current.component(.hour, from: Date())
        if (hour >= 2 && hour < 4) {
            unlockSpecificAchievement(named: "Night Owl")
        }
        if (hour >= 5 && hour < 6) {
            unlockSpecificAchievement(named: "Early Bird")
        }
    }
    
    private func unlockSpecificAchievement(named name: String) {
        print("Unlocking achievement: \(name)")
        if let achievement = achievements.first(where: { $0.name == name }), !unlockedAchievements.contains(achievement.name) {
            unlockedAchievements.append(achievement.name)
            latestAchievement = achievement
            showPopUp = true
            saveAchievements()
            print(unlockedAchievements)
        }
    }

    func saveAchievements() {
        let ids = unlockedAchievements.map { $0 }
        UserDefaults.standard.set(ids, forKey: "unlockedAchievements")
    }
    
}
