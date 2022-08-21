//
//  MovieAPI.swift
//  TMDBMovies
//
//  Created by Marko Zivanovic on 3.7.22..
//

import UIKit

class MoviesAPI {
    
    static func getPopularMovies(withSorting sorting: Sorting, fromPage page: Int, completion: @escaping (Movies?) -> Void) async {
        if let url = Endpoint.popularMovies(sortedBy: sorting, page: page) {
            let session = URLSession.shared
            guard let (data, _) = try? await session.data(from: url) else { return }
            let movies = parseMovies(withData: data)
            completion (movies)
        }
    }
    
    static func parseMovies(withData data: Data) -> Movies? {
        let decoder = JSONDecoder()
        if let jsonMovies = try? decoder.decode(Movies.self, from: data) {
            return jsonMovies
        } else {
            return nil
        }
    }
}

enum Sorting: String {
    case popularityDesc = "popularity.desc"
    case popularityAsc = "popularity.asc"
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    let apiKey = URLQueryItem(name: "api_key", value: "236b902a4bf839e9147d95a6171e5a88")
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = path
        components.queryItems = queryItems + [apiKey]
        
        return components.url
    }
    
    static func popularMovies(sortedBy sorting: Sorting, page: Int) -> URL? {
        return Endpoint(
            path: "/3/discover/movie",
            queryItems: [
                URLQueryItem(name: "sort_by", value: sorting.rawValue),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        ).url
    }
}
