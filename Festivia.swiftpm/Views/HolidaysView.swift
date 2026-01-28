import SwiftUI

struct HolidaysView: View {
    @StateObject var viewModel = HolidayViewModel()
    @State private var expandedHolidayUUID: UUID?
    @Binding var countryCode: String
    
    @State private var inputText = ""
    @State private var todayHolidayID: UUID?
    @State private var rainbowColor = Color.red
    @State private var isToday = false
    
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    
    @ObservedObject var achievementManager: AchievementManager
    
    var filteredHolidays: [Holiday] {
        if inputText.isEmpty {
            return viewModel.holidays
        } else {
            return viewModel.holidays.filter { holiday in
                holiday.name.lowercased().contains(inputText.lowercased())
            }
        }
    }
    
    var holidayText: String {
        return isToday ? "🥳 Today 🥳" : "🎉 Upcoming Holiday 🎉"
    }
    
    var body: some View {
        VStack {
            Rainbowtext(text: "Holidays in \(countryCode)🥳🌈")
                .padding(.bottom, -20)
                
            TextField("Enter a holiday name:", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.leading, .trailing, .top])
            
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(filteredHolidays) { holiday in
                            let isUpcoming = holiday.id == todayHolidayID
                            
                            VStack {
                                if isUpcoming {
                                    Text(holidayText)
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                        .transition(.scale)
                                        .animation(.easeInOut(duration: 0.5), value: todayHolidayID)
                                }
                                
                                HStack {
                                    Image(images[holiday.type] ?? "observanceMax")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 45, height: 45)
                                        .clipped()
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(holiday.name)
                                            .font(.headline)
                                        Text("\(holiday.date.suffix(2))th of \(months[getMonth(date: holiday.date)]!), \(holiday.day)") 
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                        
                                        if expandedHolidayUUID == holiday.id {
                                            VStack(alignment: .leading) {
                                                Text(daysUntilHoliday(holiday))
                                                    .font(.subheadline)
                                                    .foregroundColor(holiday.adjustedDate ?? Date() < Date() ? .gray : .orange)
                                                
                                                Button("Learn more", systemImage: "newspaper.fill") {
                                                    openHolidayPage(holiday.name)
                                                    achievementManager.addButtonClick()
                                                }
                                                .transition(.opacity)
                                                .buttonStyle(BorderlessButtonStyle())
                                            }
                                        }
                                    }
                                    .padding(.leading, 8)
                                    
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            expandedHolidayUUID = (expandedHolidayUUID == holiday.id) ? nil : holiday.id
                                        }
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .font(.system(size: 22))
                                            .rotationEffect(.degrees(expandedHolidayUUID == holiday.id ? 45 : 0))
                                    }
                                }
                                .frame(height: expandedHolidayUUID == holiday.id ? 120 : 60)
                                .padding(.horizontal)
                                .id(holiday.id)
                                .background(
                                    isUpcoming ? RoundedRectangle(cornerRadius: 15)
                                        .stroke(rainbowColor, lineWidth: 5)
                                        .shadow(color: rainbowColor.opacity(0.7), radius: 10)
                                        .animation(.linear(duration: 2).repeatForever(autoreverses: true), value: rainbowColor)
                                    : nil
                                )
                            }
                        }
                    }
                }
                .onReceive(viewModel.$holidays) { _ in
                    let today = Calendar.current.startOfDay(for: Date())
                    
                    if let upcomingHoliday = filteredHolidays.first(where: { holiday in
                        guard let holidayDate = holiday.adjustedDate else { return false }
                        
                        if holidayDate == today { isToday = true }
                        else { isToday = false }
                        
                        return holidayDate >= today
                    }) {
                        todayHolidayID = upcomingHoliday.id
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let todayHolidayID = todayHolidayID {
                            withAnimation {
                                proxy.scrollTo(todayHolidayID, anchor: .center)
                            }
                        }
                    }
                }
            }
            
            .onAppear {
                //hasSeenOnboarding = false
                viewModel.fetchHoliday(country: countryCode)
                startRainbowAnimation()
            }
        }
        .padding(.bottom, 1)
        .overlay(AchievementPopUp(achievementManager: achievementManager))
        .overlay(showOnboarding())
        .animation(.easeInOut(duration: 0.5), value: hasSeenOnboarding)
    }
    
    private func startRainbowAnimation() {
        Task {
            while true {
                await MainActor.run {
                    withAnimation(.linear(duration: 2)) {
                        rainbowColor = Color.green
                    }
                }
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                
                await MainActor.run {
                    withAnimation(.linear(duration: 2)) {
                        rainbowColor = Color.red
                    }
                }
                try? await Task.sleep(nanoseconds: 2_000_000_000)
            }
        }
    }
}
