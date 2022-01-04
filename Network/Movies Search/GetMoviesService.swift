//
//  GetMoviesService.swift
//  Movies
//
//  Created by Lucas Brandão on 26/01/21.
//

import Foundation

protocol MoviesSearchServiceProtocol {
    func getMoviesAdvanced(genres: [String]?, completion: @escaping(_ response: MoviesSearchResponse?, _ errorMessage: String?) -> Void)
}

class MoviesSearchService: MoviesSearchServiceProtocol {
    func getMoviesAdvanced(genres: [String]?, completion: @escaping(_ response: MoviesSearchResponse?, _ errorMessage: String?) -> Void) {
        let request = GetMoviesRequest(genres: genres, type: .advanced)
        Remote.makeRequest(request: request, completionHandler: completion)
    }
    
    func getMoviesByTitle(title: String, completion: @escaping(_ response: MoviesSearchResponse?, _ errorMessage: String?) -> Void) {
        let request = GetMoviesRequest(type: .byTitle, title: title)
        Remote.makeRequest(request: request, completionHandler: completion)
    }
}
