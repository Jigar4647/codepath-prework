//
//  Localaization.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation


internal struct Localaization {
    
    struct NetworkErrorMessage {
        
        static var invalidData: String {
            return "invalid_data".getLocalizeString()
        }
        
        static var invalidResponse: String {
            return "invalid_response".getLocalizeString()
        }
        
        static var unableToComplete: String {
            return "unable_to_complete".getLocalizeString()
        }
        
        static var invalidApiID: String {
            return "invalid_api_id".getLocalizeString()
        }
        
        static var notAllowed: String {
            return "access_restricted".getLocalizeString()
        }
        
        static var invalidURL: String {
            return "invalid_url".getLocalizeString()
        }
    }
}
