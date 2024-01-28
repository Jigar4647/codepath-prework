//
//  MockJokesListViewModel.swift
//  DemoJokesApplicationLTIMTests
//
//  Created by Jigs Patel on 28/01/24.
//

import XCTest
@testable import DemoJokesApplicationLTIM

final class MockJokesListViewModel: JokesListViewModel {

    var fetchJokesExpectation: XCTestExpectation?

    override func fetchJokesFromAPI(limit: Int, completionHandler: @escaping (Jokes) -> Void) {
        super.fetchJokesFromAPI(limit: limit) { jokes in
            completionHandler(jokes)
            self.fetchJokesExpectation?.fulfill()
        }
    }
}
