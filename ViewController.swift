//
//  ViewController.swift
//  TMDBMovies
//
//  Created by Marko Zivanovic on 2.7.22..
//

import UIKit

class ViewController: UITableViewController {
    
    var movies: Movies?
    var currentPage: Int = 1
    var sorting: Sorting = .popularityDesc
    var isFetching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TMDB Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        fetcPopularMovies()
        
    }
    
    func fetcPopularMovies() {
        isFetching = true
        Task {
            await MoviesAPI.getPopularMovies(withSorting: sorting, fromPage: currentPage) { [weak self] fetchedMovies in
                guard let self = self else { return }
                
                if self.movies == nil {
                    self.movies = fetchedMovies
                } else if let fetchedMovies = fetchedMovies {
                    self.movies?.results += fetchedMovies.results
                }
                self.isFetching = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieNameCell", for: indexPath)
        
        guard let fetchedMovies = movies?.results else { return UITableViewCell() }
        let movie = fetchedMovies[indexPath.row]
        
        cell.textLabel?.text = movie.originalTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetail") as? MovieDetailViewController,
           let selectedMovie = movies?.results[indexPath.row] {
            vc.selectedMovie = selectedMovie
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}



extension ViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        if pos > tableView.contentSize.height - 50 - scrollView.frame.size.height {
            guard !isFetching else {
                return
            }
            if let maxPage = movies?.totalPages, currentPage < maxPage {
                currentPage += 1
                fetcPopularMovies()
            }
        }
    }
}





