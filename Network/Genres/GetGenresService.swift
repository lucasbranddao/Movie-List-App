//
//  GetGenresService.swift
//  Movies
//
//  Created by Lucas Brandão on 25/01/21.
//

import Foundation

protocol GenresServiceProtocol {
    func getGenres(completion: @escaping(_ response: [String]?, _ errorMessage: String?) -> Void)
}

class GenresService: GenresServiceProtocol {
    func getGenres(completion: @escaping(_ response: [String]?, _ errorMessage: String?) -> Void) {
        let request = GetGenresRequest()
        Remote.makeRequest(request: request, completionHandler: completion)
    }
}
