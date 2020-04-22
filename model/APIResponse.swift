import Foundation

struct APIResponse: Codable {
  let weather:      [Weather]
  let main:         Main
}

struct APIResponseWithDateTime: Codable {
  let weather:      [Weather]
  let main:         Main
  let dt_txt:       String
}

struct FiveDaysAPIResponse: Codable {
  let list:         [APIResponseWithDateTime]
}

struct Weather: Codable {
  let main:         String
  let description:  String
}

struct Main: Codable {
  let temp:         Double
  let feels_like:   Double
  let temp_min:     Double
  let temp_max:     Double
  let pressure:     Double
  let humidity:     Double
}