//
//  Movies.swift
//  TMDBMovies
//
//  Created by Marko Zivanovic on 2.7.22..
//

import Foundation

struct Movies: Codable {
    var page: Int
    var results: [Movie]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
