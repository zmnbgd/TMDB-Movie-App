//
//  Movie.swift
//  TMDBMovies
//
//  Created by Marko Zivanovic on 2.7.22..
//

import Foundation

struct Movie: Codable {
    
    var originalTitle: String
    var overview: String
    var posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case overview
        case posterPath = "backdrop_path"
    }
    
}
