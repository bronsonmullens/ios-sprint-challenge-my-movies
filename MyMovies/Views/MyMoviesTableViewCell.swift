//
//  MyMoviesTableViewCell.swift
//  MyMovies
//
//  Created by Bronson Mullens on 6/12/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MyMoviesTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "MyMovieCell"
    var movieController = MovieController()
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var hasWatchedButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func hasWatchedButtonTapped(_ sender: UIButton) {
        guard let movie = movie else { return }
        
        movie.hasWatched.toggle()
        
        sender.setImage(movie.hasWatched ? UIImage(systemName: "film.fill") : UIImage(systemName: "film"), for: .normal)
        
        movieController.sendMovieToServer(movie: movie)
        
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    // MARK: - Private
    
    private func updateViews() {
        guard let movie = movie else { return }
        movieTitleLabel.text = movie.title
        hasWatchedButton.setImage(movie.hasWatched ? UIImage(systemName: "film.fill") : UIImage(systemName: "film"), for: .normal)
    }
    
}
