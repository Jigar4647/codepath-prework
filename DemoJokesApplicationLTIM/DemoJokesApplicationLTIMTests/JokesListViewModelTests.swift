//
//  JokesListViewModelTests.swift
//  DemoJokesApplicationLTIMTests
//
//  Created by Jigs Patel on 28/01/24.
//

import XCTest
@testable import DemoJokesApplicationLTIM

final class JokesListViewModelTests: XCTestCase {

    var viewModel: JokesListViewModel!
    var mockService: MockJokesService!
    
    override func setUpWithError() throws {
        mockService = MockJokesService()
        viewModel = JokesListViewModel(serviceProtocol: mockService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }

    // Test number of sections
    func testNumberOfSections() {
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }
    
    // Test number of items in section
    func testNumberOfItemsInSection() {
        // Initially, jokes array is empty
        XCTAssertEqual(viewModel.numberOfItemsInSection(0), 0)
        
        // Fetch jokes from the mock service
        viewModel.fetchJokesFromAPI(limit: 0) {  _ in }
        
        // Assuming mock service returns 0 jokes
        XCTAssertEqual(viewModel.numberOfItemsInSection(0), 0)
        
        // Fetch jokes from the mock service
        viewModel.fetchJokesFromAPI(limit: 5) { [weak self] newJokes in
            guard let self = self else { return }
            self.viewModel.jokes.append(contentsOf: newJokes)
        }
        
        // Assuming mock service returns 5 jokes
        XCTAssertEqual(viewModel.numberOfItemsInSection(0), 5)
    }
    
    // Test fetching jokes from API
    func testFetchJokesFromAPISuccess() {
        let expectation = XCTestExpectation(description: "Fetching jokes from API")
        
        viewModel.fetchJokesFromAPI(limit: 5) { jokes in
            XCTAssertEqual(jokes.count, 5)
            XCTAssertEqual(jokes[0].joke, "Mock Joke 1")
            XCTAssertEqual(jokes[1].joke, "Mock Joke 2")
            XCTAssertEqual(jokes[2].joke, "Mock Joke 3")
            XCTAssertEqual(jokes[3].joke, "Mock Joke 4")
            XCTAssertEqual(jokes[4].joke, "Mock Joke 5")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchJokesFromAPIFailure() {
        mockService.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetching jokes from API")
        
        viewModel.fetchJokesFromAPI(limit: 5) { jokes in
            XCTAssertEqual(jokes.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // Test jokeAtIndex
    func testJokeAtIndex() {
        let joke = Joke(joke: "Mock Joke 1")
        viewModel.jokes = [joke]
        
        let jokesViewModel = viewModel.jokeAtIndex(0)
        
        XCTAssertEqual(jokesViewModel.jokeDescription, "Mock Joke 1")
    }
}
