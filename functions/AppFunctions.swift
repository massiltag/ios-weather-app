import Foundation


// Get cities from JSON
func getCitiesFromJSON(fileName: String) -> [City] {
  var cities: [City] = []
  if let data = JSONtoData(fileName: fileName) {
    let jsonDecoder = JSONDecoder()
    if let result = try? jsonDecoder.decode([City].self, from: data) {
      cities = result
    }
  }
  return cities
}

// Prompt user for typing a city name
func askForCity() -> String {
  return responseToPrompt("Search for a city : ↓")
}

// Get a city's ID from its name
// TODO support multiple cities + autocompletion
func getIdsFromCityName(_ cityName: String, _ cities: [City]) -> [City] {
  var search: [City] = []
  for city in cities {
    if city.name.lowercased().contains(cityName.lowercased()) {
      search.append(city)
    }
  }
  return search
}

// Get City object from its ID
func getCityFromId(_ id: Int, _ cities: [City]) -> City? {
  for city in cities {
    if city.id == id {
      return city
    }
  }
  return nil
}



/*
*   API CALLS
*/
func getCurrentWeather(_ cityId: Int) -> Void {
  let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?")!;
  let query: [String: String] = [ 
    "id": String(cityId),
    "appid": "ce91a402545433caaf4869ef8a7dcbbf"
  ];
  let queryUrl: URL = baseUrl.withQueries(query)!;

  let completionHandler = { (data: Data?, response: URLResponse?, error: Error?) -> Void in
    let jsonDecoder = JSONDecoder();
    guard let data = data else { return }

    // Decodes APIResponse
    if let apiResponse = try? jsonDecoder.decode(APIResponse.self, from: data) {
      print("Current weather in \(getCityFromId(cityId, main.cities)!.name) :")
      print("\t Weather : \(apiResponse.weather[0].main)")
      print("\t Description : \(apiResponse.weather[0].description)")
      print("\t Temperature : \(toCelsius(apiResponse.main.temp))°C")
      print("\t Feels like : \(toCelsius(apiResponse.main.feels_like))°C")
      print("\t Min/Max : \(toCelsius(apiResponse.main.temp_min))°C/\(toCelsius(apiResponse.main.temp_max))°C")
      print("\t Pressure : \(toCelsius(apiResponse.main.pressure)) hPa")
      print("\t Humidity : \(toCelsius(apiResponse.main.temp)) %\n\n")
    }
  }

  let task = URLSession.shared.dataTask(with: queryUrl, completionHandler: completionHandler) 
  task.resume()
}


func getForecast(_ cityId: Int) -> Void {
  let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast?")!;
  let query: [String: String] = [ 
    "id": String(cityId),
    "appid": "ce91a402545433caaf4869ef8a7dcbbf"
  ];
  let queryUrl: URL = baseUrl.withQueries(query)!;

  let completionHandler = { (data: Data?, response: URLResponse?, error: Error?) -> Void in
    let jsonDecoder = JSONDecoder();
    guard let data = data else { return }

    // Decodes APIResponse & prints weather forecast
    if let forecast = try? jsonDecoder.decode(FiveDaysAPIResponse.self, from: data) {
      print("Weather forecast in \(getCityFromId(cityId, main.cities)!.name) :")
      for apiResponse in forecast.list {
        print("\t [+] DateTime : \(apiResponse.dt_txt)")
        print("\t Weather : \(apiResponse.weather[0].main)")
        print("\t Description : \(apiResponse.weather[0].description)")
        print("\t Temperature : \(toCelsius(apiResponse.main.temp))°C")
        print("\t Feels like : \(toCelsius(apiResponse.main.feels_like))°C")
        print("\t Min/Max : \(toCelsius(apiResponse.main.temp_min))°C/\(toCelsius(apiResponse.main.temp_max))°C")
        print("\t Pressure : \(toCelsius(apiResponse.main.pressure)) hPa")
        print("\t Humidity : \(toCelsius(apiResponse.main.temp)) %\n")
      }
    }
  }

  let task = URLSession.shared.dataTask(with: queryUrl, completionHandler: completionHandler) 
  task.resume()
}