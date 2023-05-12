//
//  Weather.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-11.
//

extension StubData {
    static let weather = WeatherResponse(
        coord: WeatherResponse.Coord(
            lon: StubData.brooklyn.longitude,
            lat: StubData.brooklyn.latitude
        ),
        weather: [
            WeatherResponse.WeatherElement(
                id: 800,
                main: "Clear",
                description: "clear sky",
                icon: "01n")
        ],
        base: "stations",
        main: WeatherResponse.Main(
            temp: 294.99,
            feelsLike: 294.22,
            tempMin: 289.6,
            tempMax: 297.54,
            pressure: 1017,
            humidity: 38
        ),
        visibility: 10000,
        wind: WeatherResponse.Wind(
            speed: 5.66,
            deg: 240,
            gust: 0.0
        ),
        clouds: WeatherResponse.Clouds(all: 0),
        dt: 1683858025, // TODO this probably should be NOW
        sys: WeatherResponse.Sys(
            type: 2,
            id: 2037026,
            country: "US",
            sunrise: 1683798189,
            sunset: 1683849678
        ),
        timezone: -14400,
        id: 5110302,
        name: "Brooklyn",
        cod: 200
    )
}