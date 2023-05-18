import Foundation
import XCTest

@testable import ThoughtWeather

final class TemperatureTests: XCTestCase {
    func testShouldWorkWithKelvin() {
        let temperature = Temperature(kelvin: 273.15)
        
        XCTAssertEqual(273.15, temperature.kelvin)
        XCTAssertEqual(0.0, temperature.centigrade)
        XCTAssertEqual(0.0, temperature.celsius)
        XCTAssertEqual(32.0, temperature.fahrenheit)
    }
    
    func testShouldWorkWithCentigrade() {
        let temperature = Temperature(centigrade: 100.0)
        
        XCTAssertEqual(373.15, temperature.kelvin)
        XCTAssertEqual(100.0, temperature.centigrade)
        XCTAssertEqual(100.0, temperature.celsius)
        XCTAssertEqual(212.0, temperature.fahrenheit)
    }
    
    func testShouldWorkWithCelsius() {
        let temperature = Temperature(centigrade: 50.0)
        let otherTemperature = Temperature(celsius: 50.0)
        
        XCTAssertEqual(temperature, otherTemperature)
    }
    
    func testShouldWorkWithFahrenheit() {
        let temperature = Temperature(fahrenheit: 32.0)
        
        XCTAssertEqual(Temperature(celsius: 0.0), temperature)
    }
    
    func testShouldCompare() {
        XCTAssertLessThan(Temperature(celsius: 0.0), Temperature(celsius: 100.0))
        XCTAssertGreaterThan(Temperature(celsius: 20.0), Temperature(celsius: 10.0))
        XCTAssertEqual(Temperature(celsius: 0.0), Temperature(celsius: 0.0))
    }
    
    func testShouldMakeNiceString() {
        let temperatureString: String = Temperature(kelvin: 100.33333333).description
        
        XCTAssertEqual(temperatureString, "100.33°K")
    }
}
