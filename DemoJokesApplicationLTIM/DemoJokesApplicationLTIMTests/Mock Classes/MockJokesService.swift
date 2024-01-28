//
//  MockJokesService.swift
//  DemoJokesApplicationLTIMTests
//
//  Created by Jigs Patel on 28/01/24.
//

import XCTest
@testable import DemoJokesApplicationLTIM

final class MockJokesService: JokesServiceProtocol {
    
    func fetchJokes(limit: Int, completionHandler: @escaping resultCompletion) {
        // Create a mock Jokes array for testing
        var mockJokes: Jokes = []
        if limit > 1 {
            mockJokes = [
                Joke(joke: "Mock Joke 1"),
                Joke(joke: "Mock Joke 2"),
                Joke(joke: "Mock Joke 3"),
                Joke(joke: "Mock Joke 4"),
                Joke(joke: "Mock Joke 5")
            ]
            completionHandler(.success(mockJokes))
        } else if limit == 1 {
            completionHandler(.success(mockJokes))
        } else {
            completionHandler(.failure(.invalidResponse))
        }
    }
}
