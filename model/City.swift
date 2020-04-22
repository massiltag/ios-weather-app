import Foundation

struct City: Codable, Equatable {
  let id:       Int
  let name:     String
  let state:    String
  let country:  String

  static func ==(lhs: City, rhs: City) -> Bool {
    return lhs.id == rhs.id
  }
}