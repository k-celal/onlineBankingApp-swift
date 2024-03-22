//
//  ApiClient.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.03.2024.
//

import Foundation
class ApiClient {
    private static let BASE_URL = "http://127.0.0.1:8070" // API'nin temel URL'si

    private static var sharedSession: URLSession?

    static func getClient() -> URLSession {
        if sharedSession == nil {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30
            sharedSession = URLSession(configuration: configuration)
        }
        return sharedSession!
    }
}
