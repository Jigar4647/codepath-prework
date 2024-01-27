//
//  Extension+String.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation

extension String {
    
    // Retrieving localize string from Localizable file
    func getLocalizeString() -> String {
        let result = "\(NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: "", comment: ""))"
        return result
    }
}

