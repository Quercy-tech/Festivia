import SwiftUI

class HolidayViewModel: ObservableObject {
    @Published var holidays: [Holiday] = []
    
    func fetchHoliday(country: String) {
        let url = URL(string: "https://api.api-ninjas.com/v1/holidays?country=\(country)")!
        var request = URLRequest(url: url)
        request.setValue("qdFDebEdi2Edpvedfffp/w==rPUn89t8KUcu3rdE", forHTTPHeaderField:"X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else {return}
            
            do {
                let decodedHolidays = try JSONDecoder().decode([Holiday].self, from: data)
                DispatchQueue.main.async {
                    self.holidays = decodedHolidays
                    self.holidays.sort {guard let date1 = $0.dateObject, let date2 =  $1.dateObject else { return false }
                        return date1 < date2
                    }
                    self.holidays = self.holidays.reduce(into: [Holiday](), { uniqueHolidays, holiday in
                        if (!uniqueHolidays.contains(where: {$0.name == holiday.name})) {
                            uniqueHolidays.append(holiday)
                        }
                    })
                    
                }
            } catch {
                print("Decoding failed😞 \(error.localizedDescription)")
            }
        }
        task.resume()

    }
}
