//
//  Temperature.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-16.
//

import Foundation

fileprivate let kelvinOffset = 273.15

struct Temperature: Equatable {
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

extension Temperature: Comparable {
    static func < (lhs: Temperature, rhs: Temperature) -> Bool {
        return lhs.kelvinValue < rhs.kelvinValue
    }
}
