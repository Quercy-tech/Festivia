import SwiftUI

struct LegendView: View {
    
    let typesOfHolidays = ["PUBLIC_HOLIDAY","LOCAL_HOLIDAY","ANNUAL_MONTHLY_OBSERVANCE","OBSERVANCE","CHRISTIAN","LOCAL_OBSERVANCE","WORLDWIDE_OBSERVANCE","SPORTING_EVENT","SEASON","OPTIONAL_HOLIDAY","CLOCK_CHANGE_DAYLIGHT_SAVING_TIME","ORTHODOX","JEWISH_HOLIDAY","MUSLIM","HINDU_HOLIDAY", "SPECIAL_THANKS"]
    
    var body: some View {
        List(typesOfHolidays, id: \.self) { holidayType in
            VStack(alignment: .leading) {
                HStack {
                    Image(images[holidayType] ?? "public")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipped()
                    Text(holidayType.description.replacingOccurrences(of: "_", with: " ").lowercased().capitalized)
                        .font(.headline)
                }
                Text(descriptions[holidayType] ?? "Some holiday")
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    
}
