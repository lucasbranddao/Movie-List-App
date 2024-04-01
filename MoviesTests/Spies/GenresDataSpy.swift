//
//  GenresDataSpy.swift
//  MoviesTests
//
//  Created by Lucas Brandão on 10/10/23.
//

import Foundation
@testable import Movies

final class GenresDataSpy: GenresDataProtocol {

    var getGenresCalled = false
    var saveGenresCalled = false
    var genres: [String] = []

    func saveGenres(genres: [String]) {
        saveGenresCalled = true
        self.genres = genres
    }

    func getGenres() -> [String] {
        getGenresCalled = true
        return genres
    }
}
