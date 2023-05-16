//
//  StubData.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-11.
//
import Foundation

struct StubData {
    static func loadJson<T: Decodable>(fileName: String) -> T? {
        try! {
            guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
                throw NSError(domain: "com.thoughtworks", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])
            }
            
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            
            return jsonData
        }()
    }
}
