//
//  NetworkError.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation

enum NetworkError: String, Error {
    
    case invalidData, invalidResponse, unableToComplete
    case invalidAppID, invalidBase, resourceNotFound
    case rateLimit, accessRestricted
    case invalidURL
   
    var rawValue: String {
        switch self {
        case .invalidData:
            return Localaization.NetworkErrorMessage.invalidData
        case .invalidResponse:
            return Localaization.NetworkErrorMessage.invalidResponse
        case .unableToComplete:
            return Localaization.NetworkErrorMessage.unableToComplete
        case .invalidAppID:
            return Localaization.NetworkErrorMessage.invalidAppID
        case .invalidBase:
            return Localaization.NetworkErrorMessage.invalidBase
        case .accessRestricted:
            return Localaization.NetworkErrorMessage.notAllowed
        case .rateLimit:
            return Localaization.NetworkErrorMessage.rateLimit
        case .resourceNotFound:
            return Localaization.NetworkErrorMessage.resourceNotFound
        case .invalidURL:
            return Localaization.NetworkErrorMessage.invalidURL
        }
    }
}

enum HttpMethod: String {
    case get = "GET"
}
