//
//  JokesCellView.swift
//  DemoJokesApplicationLTIM
//
//  Created by Jigs Patel on 27/01/24.
//

import UIKit

class JokesCellView: UITableViewCell {

    @IBOutlet weak var lblJoke: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ objJoke: Joke) {
        lblJoke.text = objJoke.joke
    }
}
