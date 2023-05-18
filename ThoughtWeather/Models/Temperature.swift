
import Foundation

fileprivate let kelvinOffset = 273.15

// This is just a little temperature model that makes it easy to read and write in any of
// Fahrenheit, Celsius/Centigrade, or Kelvin.
struct Temperature {
    private let kelvinValue: Double
    
    public var kelvin: Double { self.kelvinValue }
    
    public var centigrade: Double {
        self.kelvinValue - kelvinOffset
    }

    public var celsius: Double {
        self.centigrade
    }
    
    public var fahrenheit: Double {
        self.centigrade * 9/5 + 32
    }
    
    public init(kelvin: Double) {
        self.kelvinValue = kelvin
    }

    public init(centigrade: Double) {
        self.init(kelvin: centigrade + kelvinOffset)
    }
    
    public init(celsius: Double) {
        self.init(centigrade: celsius)
    }
    
    public init(fahrenheit: Double) {
        self.init(kelvin: kelvinOffset + (fahrenheit - 32) * 5/9)
    }
}

// Adding Equatable conformance so we can evaluate (temperatureA == temperatureB)
// Because the only stored property of Temperature, kelvinValue, is already Equatable,
//   we don't have to add any code.
extension Temperature: Equatable {}

// Adding conformance to the Comparable protocol enables us to compare two
// Temperature objects using <, >, <=, etc
extension Temperature: Comparable {
    static func < (lhs: Temperature, rhs: Temperature) -> Bool {
        return lhs.kelvinValue < rhs.kelvinValue
    }
}

// CustomStringConvertible conformance lets us decide what the default string
// representation of a Temperature object should look like, for instance inside of
// a print() statement.
extension Temperature: CustomStringConvertible {
    var description: String {
        return String(format: "%.2f°K", self.kelvinValue)
    }
}
