//
//  JokesServiceProtocol.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation

typealias resultCompletion = ((Result<Jokes, NetworkError>) -> Void)

protocol JokesServiceProtocol {
    
    func fetchJokes(limit: Int, completionHandler: @escaping resultCompletion)
}
