//
//  MovieDetailViewController.swift
//  TMDBMovies
//
//  Created by Marko Zivanovic on 3.7.22..
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    @IBOutlet var posterImage: UIImageView!
    
    @IBOutlet var overviewLabel: UILabel!
    
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedMovie?.originalTitle ?? "missing title"
        overviewLabel.text = selectedMovie?.overview
        navigationItem.largeTitleDisplayMode = .never 
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(selectedMovie?.posterPath ?? "")") {
            posterImage.kf.setImage(with: url)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

	
}
