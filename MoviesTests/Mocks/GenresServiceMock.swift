//
//  GenresServiceMock.swift
//  MoviesTests
//
//  Created by Lucas Brandão on 10/10/23.
//

import XCTest
@testable import Movies

final class GenresServiceMock: GenresServiceProtocol {

    var getGenresCalled = false

    func getGenres(completion: @escaping ([String]?, String?) -> Void) {
        getGenresCalled = true

        completion(["genre 1", "genre 2"], nil)
    }
}
