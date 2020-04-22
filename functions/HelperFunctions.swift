import Foundation

// URL Class extension, for adding params to query
extension URL {
  func withQueries(_ queries: [String: String]) -> URL? {
    var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
    components?.queryItems = queries.map {
        URLQueryItem(name: $0.0, value: $0.1)
    }
    return components?.url
  }
}

// Get user input
func getln() -> String {
  let stdin = FileHandle.standardInput
  var input = NSString(data: stdin.availableData, encoding: String.Encoding.utf8.rawValue)
  input = input!.trimmingCharacters(in: CharacterSet.newlines) as NSString?
  return input! as String
}

// Prompt user with custom message
func responseToPrompt(_ prompt: String) -> String {
	print(prompt)
	return getln()
}

// Read Data from JSON
func JSONtoData(fileName: String) -> Data? {
  var jsonData = Data()
  if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
  	do {
  		let fileUrl = URL(fileURLWithPath: path)
      let jsonString = try String(contentsOf: fileUrl, encoding: .utf8)
  		jsonData = Data(jsonString.utf8)
	  }
	  catch {
	  	print("ERROR")
	  }
	}
  return jsonData
}

// Kelvin to Celsius
func toCelsius(_ k: Double) -> Double {
  return Double(Int((k - 273.15)*10)) / 10
}