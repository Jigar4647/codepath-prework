//
//  Jokes.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import Foundation

// MARK: - Joke
struct Joke: Decodable {
    let joke: String
}

typealias Jokes = [Joke]
