//
//  ViewController.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 24/01/24.
//

import UIKit

class JokesViewController: UITableViewController {

    // Private properties
    private var jokesViewModel: JokesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true

        // Initialize viewModel
        jokesViewModel = JokesViewModel(serviceProtocol: JokesService())
        
        renderingData()
    }
    
    func renderingData() {
        jokesViewModel.fetchJokesFromAPI { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success( _):
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                //self.showErrorAlert(error.rawValue)
            }
        }
    }
}

// MARK: UITableViewDataSource functions
extension JokesViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return jokesViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesViewModel.numberOfItemsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? JokesCellView else {
            return UITableViewCell()
        }
        
        guard let objJoke = jokesViewModel.getJokeBy(indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.configureCell(objJoke)
        return cell
    }
}

