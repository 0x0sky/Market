//
//  Loadable.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import Foundation

func load<T: Decodable>(_ filename: String, in bundle: Bundle? = Bundle.main) -> T {
    guard let json = bundle?.url(forResource: filename, withExtension: "json") else {
        fatalError("Json with the name \(filename) is absent in the app bundle")
    }
    
    let data: Data
    do {
        data = try Data(contentsOf: json)
    } catch {
        fatalError(error.localizedDescription)
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError(error.localizedDescription)
    }
}
