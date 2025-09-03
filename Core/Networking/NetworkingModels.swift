//
//  NetworkingModels.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 18.08.2025.
//

import Foundation

public protocol Endpoint {
    func urlRequest() -> URLRequest
}

public extension Endpoint {
    func url(appendingPath path: String) -> URL {
        URL(string: "https://api.github.com\(path)")!
    }
}
