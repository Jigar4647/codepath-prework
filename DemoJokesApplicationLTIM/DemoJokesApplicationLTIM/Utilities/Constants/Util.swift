//
//  Util.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation

struct Util {
    
    static func getApiKeyFromKeyConfig() -> String? {
        if let path = Bundle.main.path(forResource: "KeyConfig", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path) as? [String: Any],
           let apiKey = config["API_KEY"] as? String {
            return apiKey
        }
        print("Failed to retrieve API_KEY from plist")
        return nil
    }
}
