import Foundation

// Change to ".assets/cities" for full set
var cities: [City] = getCitiesFromJSON(fileName: ".assets/cities.test")

let cityName = askForCity()

let searchResults = getIdsFromCityName(cityName, cities);
if searchResults.count != 0 {
  var cityId = 0
  if searchResults.count == 1 {
    cityId = searchResults[0].id
  } else {
    print("Please pick a search result :")
    for i in 1...searchResults.count {
      print("[\(i)] \(searchResults[i-1].name) \(searchResults[i-1].country)")
    }
    var pickedIndex = 0
    while (pickedIndex <= 0 || pickedIndex > searchResults.count) {
      let input = responseToPrompt("Your choice ↓")
      pickedIndex = Int(input)!
    }
    cityId = searchResults[pickedIndex-1].id
    print("You have chosen \(searchResults[pickedIndex-1].name) \(searchResults[pickedIndex-1].country)")
  }

  print("[1] Current weather")
  print("[2] Five days forecast")

  var choice = ""
	while !(choice == "1" || choice == "2") {
    choice = responseToPrompt("Your choice ↓")
	}

  while (true) {
    if (choice == "1") {
      getCurrentWeather(cityId)
    } else if (choice == "2") {
      getForecast(cityId)
    } else {
      print("See you soon")
      break
    }
    choice = getln()
  }

} else {
  print("City not found.")
}

RunLoop.main.run()