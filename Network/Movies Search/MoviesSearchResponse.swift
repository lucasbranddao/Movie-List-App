//
//  MoviesSearchResponse.swift
//  Movies
//
//  Created by Lucas Brandão on 26/01/21.
//

import Foundation

struct MoviesSearchResponse: Decodable {
    let page: Int?
    let results: [Result]?
    
    struct Result: Decodable {
        let genre: [String]?
        let title: String?
        let synopsis: String?
        let type: String?
        let imdbid: String?
        let imdbrating: Double?
        let released: Int?
        let imageurl: [String]?
    }
}
