import SwiftUI

class Holiday: Codable, Identifiable {
    let id = UUID()
    let country: String
    let iso: String
    let year: Int
    let date: String
    let day: String
    let name: String
    let type: String
    
    var dateObject: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date)
    }
    
    var adjustedDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let holidayDate = formatter.date(from: date) else { return nil }
        
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date()) 
        
        var dateComponents = calendar.dateComponents([.month, .day], from: holidayDate)
        dateComponents.year = currentYear        
        return calendar.date(from: dateComponents)
    }
}

let months: [Int: String] = [
    01: "January", 02: "February", 03: "March", 04: "April",
    05: "May", 06: "June", 07: "July", 08: "August",
    09: "September", 10: "October", 11: "November", 12: "December"
]

func getMonth(date: String) -> Int {
    return Int(date.dropFirst(5).prefix(2)) ?? 01
}

func daysUntilHoliday(_ holiday: Holiday) -> String {
    guard let holidayDate = holiday.adjustedDate else { return "Unknown date" }
    
    let today = Calendar.current.startOfDay(for: Date())
    let components = Calendar.current.dateComponents([.day], from: today, to: holidayDate)
    
    if let days = components.day {
        if days > 0 {
            if (days == 1) {return "\(days) day left"}
            else {return "\(days) days left"}
        } else if days == 0 {
            return "Today!"
        } else {
            if (days == -1) {return "\(-days) day ago"}
            else {return "\(-days) days ago"}
        }
    }
    
    return "Unknown date"
}

let images: [String: String] = [
        "PUBLIC_HOLIDAY": "public",
        "OFFICIAL_HOLIDAY": "public",
        "NATIONAL_HOLIDAY": "public",
        "FEDERAL_HOLIDAY": "public",
        "GAZETTED_HOLIDAY": "public",
        "NATIONAL_LEGAL_HOLIDAY": "public",
        
        "STATE_HOLIDAY": "localMax",
        "LOCAL_HOLIDAY": "localMax",
        "COMMON_LOCAL_HOLIDAY": "christMax",
        "GOVERNMENT_HOLIDAY": "localMax",
        
        "ANNUAL_MONTHLY_OBSERVANCE": "observanceMax",
        "STATE_OBSERVATION": "observanceMax",
        
        "OBSERVANCE": "observanceMax2",
        
        "LOCAL_OBSERVANCE": "localObserve",
        "PRIVATE_SECTOR_HOLIDAY": "localObserve",
        
        "UNITED_NATIONS_OBSERVANCE": "global",
        "WORLDWIDE_OBSERVANCE": "global",
        
        "SPORTING_EVENT": "sport",
        
        
        "SEASON": "season",
        
        "OPTIONAL_HOLIDAY": "optional",
        "BANK_HOLIDAY": "optional",
        "LOCAL_BANK_HOLIDAY": "optional",
        "RESTRICTED_HOLIDAY": "optional",
        
        "CLOCK_CHANGE_DAYLIGHT_SAVING_TIME": "time",
        
        "NATIONAL_HOLIDAY_CHRISTIAN": "christMax",
        "NATIONAL_HOLIDAY_ORTHODOX": "christMax",
        "CHRISTIAN": "christMax",
        
        "OBSERVANCE_CHRISTIAN": "Christ",
        "ORTHODOX": "Christ",
        "DE_FACTO_HOLIDAY": "Christ",
        
        "JEWISH_COMMEMORATION": "jewishMax",
        "JEWISH_HOLIDAY": "jewishMax",
        "OBSERVANCE_HEBREW": "jewishMax",
        
        "MUSLIM": "muslim",
        
        "HINDU_HOLIDAY": "hindu",
        "OBSERVANCE_HINDUISM": "hindu",
        
        "SPECIAL_THANKS": "thanks"
]

let descriptions: [String: String] = [
    "PUBLIC_HOLIDAY" : "A day when life slows down, businesses close, and people gather to celebrate, reflect, or simply relax. Public holidays are often tied to national pride, historical events, or cultural traditions that shape a country’s identity."
    ,
    "LOCAL_HOLIDAY":"A local holiday is a special day celebrated within a specific region or community. These holidays reflect the unique traditions, heritage, or history of the area. Whether it’s a town’s founding day, a local harvest festival, or a cultural event, local holidays allow residents to honor their roots. They may be marked with festivals, parades, or family gatherings that showcase what makes the region special and bring the community closer together.",
    "ANNUAL_MONTHLY_OBSERVANCE": "An annual monthly observance is a recurring event that happens at the same time each month, often with a specific theme or cause. These observances help raise awareness or celebrate particular aspects of life. Examples include Breast Cancer Awareness Month or Mental Health Month, where people across the globe come together to focus on education, support, and reflection. It’s about bringing attention to important topics, often with a special activity or campaign each month.",
    "OBSERVANCE": "An observance marks a day or period of time dedicated to honoring a significant event, tradition, or religious belief. While not always a public holiday, these are special days when people come together to reflect, commemorate, or engage in rituals. Whether it’s an observance of a historic event, a cultural practice, or a time for personal reflection, these days allow for collective meaning-making, spiritual growth, and personal connection to traditions.",
    "LOCAL_OBSERVANCE": "Local observances are specific to a region, culture, or community. Unlike public holidays that are recognized nationwide, these observances celebrate unique local customs, historical events, or regional cultural milestones. Think of a harvest festival, a community remembrance day, or the anniversary of a local landmark’s creation. Local observances offer an opportunity for residents to connect with their immediate history and culture in meaningful ways.",
    "WORLDWIDE_OBSERVANCE": "Worldwide observances are global moments of reflection, education, or activism. These days are recognized across the world, often to address universal concerns or causes like World Earth Day or International Women’s Day. They bring attention to issues that transcend borders and encourage collective action or solidarity. These observances create a sense of shared responsibility and global unity, motivating people to come together for a greater cause.",
    "SPORTING_EVENT": "Sporting events are action-packed holidays that celebrate athletic achievements and global competition. Whether it’s the Olympic Games, the FIFA World Cup, or the Super Bowl, these events bring nations together to celebrate sportsmanship, competition, and national pride. They often come with fanfare, celebrations, and media coverage, turning even non-sport enthusiasts into passionate spectators. Sporting events create unforgettable moments that bond people across the globe.",
    "SEASON":"Seasonal holidays mark the changing of the seasons—whether it’s the warmth of summer, the chill of winter, or the blossoming of spring. These holidays are closely linked to the natural world, often coinciding with the solstices or equinoxes. People celebrate with seasonal activities like harvesting, enjoying festivals, or observing the beauty of nature. Seasonal holidays remind us to celebrate the rhythm of nature, connecting us to the earth’s cycles.",
    "OPTIONAL_HOLIDAY": "An optional holiday is one where participation isn’t mandatory—it’s up to individuals or employers whether they want to observe it. These holidays are often related to religious or cultural events that don’t require a national pause but are still celebrated by those who choose to participate. It’s a great opportunity for people to take personal time for reflection, spiritual practice, or community engagement when they feel the need.",
    "CLOCK_CHANGE_DAYLIGHT_SAVING_TIME": "Ah, the magic of time! Twice a year, daylight saving time arrives with its puzzling ritual of “springing forward” or “falling back.” While the rest of the world debates the merits of this time change, it’s a quirky reminder of how we try to bend time to our will. Whether you love the extra daylight or dread losing an hour of sleep, it’s a moment that makes us rethink our schedules, embrace the changing light, and maybe even enjoy a little extra sunshine in the evenings.",
    "CHRISTIAN": "Christian holidays are a celebration of faith, love, and the life of Jesus Christ. These days, like Christmas and Easter, are filled with spiritual reflection, joy, and a sense of community. It’s a time to celebrate the teachings of Christ, practice gratitude, and engage in the rituals of prayer and worship. Christian holidays bring together people of all walks of life, offering a moment to reconnect with one’s faith, renew hope, and share the message of peace and love.",
    "ORTHODOX": "Orthodox(Christian) holidays carry a rich tradition of spiritual reverence, deep-rooted in the ancient practices of Eastern Christianity. Whether it’s the solemn beauty of Christmas or the triumphant joy of Easter, these holidays are marked by distinctive rituals, prayers, and ceremonies. Orthodox holidays remind us of the enduring strength of faith, where centuries-old customs continue to shape the lives of millions. It’s a time for reflection, reverence, and a renewed connection to both the divine and community.",
    "JEWISH_HOLIDAY": "Jewish holidays are filled with profound spiritual significance, rich rituals, and a deep connection to history. From Rosh Hashanah, the Jewish New Year, to Passover, which commemorates the Exodus, these holidays celebrate resilience, faith, and the survival of a people. They are times for family gatherings, feasts, and reflection, honoring the values and traditions that have been passed down through generations. Each holiday is a sacred moment to pause, reflect, and rejoice in the Jewish heritage that continues to thrive.",
    "MUSLIM": "Muslim holidays are sacred occasions that bring faith, family, and community together. Eid al-Fitr, marking the end of Ramadan, is a jubilant celebration of faith, fasting, and fellowship, while Eid al-Adha honors sacrifice and devotion. These holidays are steeped in deep spiritual meaning, offering Muslims around the world a chance to express gratitude, help those in need, and reinforce their bond with God. They are filled with acts of kindness, prayer, and joy, echoing the enduring strength of faith.",
    "HINDU_HOLIDAY": "Hindu holidays are an explosion of color, music, and spirituality, where mythology, tradition, and joy collide in perfect harmony. From Diwali, the Festival of Lights, to Holi, the Festival of Colors, these holidays are all about celebrating life, love, and the triumph of good over evil. Hindu holidays bring together communities for vibrant celebrations, prayer, feasts, and rituals that honor the divine, foster unity, and connect individuals to their rich cultural heritage. These days radiate positivity, joy, and spiritual renewal.",
    "SPECIAL_THANKS": "Thanks to flaticon and Icon8, for providing high quality symbols, that helped my create icons for the app."
    ]


