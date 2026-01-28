import SwiftUI
import WebKit

/// Checks if a Wikipedia page exists, then opens it. Otherwise, performs a Google search.
func openHolidayPage(_ holidayName: String) {
    let formattedName = holidayName
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .replacingOccurrences(of: " ", with: "_")
    
    let wikiURL = "https://en.wikipedia.org/wiki/\(formattedName)"
    let wikiAPIURL = "https://en.wikipedia.org/w/api.php?action=query&titles=\(formattedName)&format=json"
    
    guard let apiURL = URL(string: wikiAPIURL) else { return }
    
    // Fetch from Wikipedia API
    URLSession.shared.dataTask(with: apiURL) { data, _, _ in
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let query = json["query"] as? [String: Any],
           let pages = query["pages"] as? [String: Any],
           !pages.keys.contains("-1") { // Wikipedia API returns "-1" if the page does not exist
            openURL(wikiURL)
        } else {
            let googleSearchURL = "https://www.google.com/search?q=\(holidayName.replacingOccurrences(of: " ", with: "+"))"
            openURL(googleSearchURL)
        }
    }.resume()
}

/// Opens a given URL in Safari
func openURL(_ urlString: String) {
    guard let url = URL(string: urlString) else { return }
    DispatchQueue.main.async {
        UIApplication.shared.open(url)
    }
}
