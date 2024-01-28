//
//  NetworkError.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation

enum NetworkError: String, Error {
    
    case invalidData, invalidResponse, unableToComplete
    case accessRestricted, invalidURL, invalidApiID
   
    var rawValue: String {
        switch self {
        case .invalidData:
            return Localaization.NetworkErrorMessage.invalidData
        case .invalidResponse:
            return Localaization.NetworkErrorMessage.invalidResponse
        case .unableToComplete:
            return Localaization.NetworkErrorMessage.unableToComplete
        case .invalidApiID:
            return Localaization.NetworkErrorMessage.invalidApiID
        case .accessRestricted:
            return Localaization.NetworkErrorMessage.notAllowed
        case .invalidURL:
            return Localaization.NetworkErrorMessage.invalidURL
        }
    }
}

enum HttpMethod: String {
    case get = "GET"
}
