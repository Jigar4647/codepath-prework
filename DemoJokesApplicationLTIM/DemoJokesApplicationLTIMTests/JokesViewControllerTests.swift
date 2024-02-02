//
//  JokesViewControllerTests.swift
//  DemoJokesApplicationLTIMTests
//
//  Created by Jigs Patel on 28/01/24.
//

import XCTest
@testable import DemoJokesApplicationLTIM

final class JokesViewControllerTests: XCTestCase {
    
    var viewController: JokesViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "JokesViewController") as? JokesViewController
        viewController.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Test fetchJokesInBatches
    func testFetchJokesInBatches() {
        let mockViewModel = MockJokesListViewModel(serviceProtocol: MockJokesService())
        viewController.jokesListViewModel = mockViewModel
        
        let expectation = XCTestExpectation(description: "Fetching jokes from API")
        
        mockViewModel.fetchJokesExpectation = expectation
        
        viewController.fetchJokesInBatches()
        
        wait(for: [expectation], timeout: 5.0)
        
        XCTAssertFalse(viewController.isLoading)
        XCTAssertEqual(viewController.jokesListViewModel.jokes.count, 5)
    }
    
    func testFetchJokesInBatchesIfNoJokes() {
        let mockViewModel = MockJokesListViewModel(serviceProtocol: MockJokesService())
        viewController.jokesListViewModel = mockViewModel
        viewController.batchLimit = 1
        
        let expectation = XCTestExpectation(description: "Fetching jokes from API")
        
        mockViewModel.fetchJokesExpectation = expectation
        
        viewController.fetchJokesInBatches()
        
        wait(for: [expectation], timeout: 5.0) 
        
        XCTAssertFalse(viewController.isLoading)
        XCTAssertEqual(viewController.jokesListViewModel.jokes.count, 0)
    }
    
    // Test willDisplay
    func testWillDisplay() {
        let mockViewModel = MockJokesListViewModel(serviceProtocol: MockJokesService())
        viewController.jokesListViewModel = mockViewModel
        viewController.isLoading = false
        
        mockViewModel.jokes = [
            Joke(joke: "Mock Joke 1"),
            Joke(joke: "Mock Joke 2"),
            Joke(joke: "Mock Joke 3"),
            Joke(joke: "Mock Joke 4"),
            Joke(joke: "Mock Joke 5")
        ]
        
        let mockTableView = MockTableView()
        viewController.tableView = mockTableView
        
        // Register the cell identifier
        mockTableView.register(JokesCellView.self, forCellReuseIdentifier: "Cell")
        
        let mockIndexPath = IndexPath(row: 4, section: 0)
        viewController.tableView(viewController.tableView, willDisplay: UITableViewCell(), forRowAt: mockIndexPath)
        
        XCTAssertFalse(viewController.isLoading)
    }
}

// Mock UITableView for testing
class MockTableView: UITableView {
    var dequeueReusableCellCalled = false
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCellCalled = true
        return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}

class MockJokesCellView: JokesCellView {
    var configureCellCalled = false
    
    override func configureCell(_ jokeViewModel: JokesViewModel) {
        configureCellCalled = true
        super.configureCell(jokeViewModel)
    }
}
