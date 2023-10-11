//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Lucas Brandão on 09/10/23.
//

import XCTest
import RxSwift
@testable import Movies // Import your app's module here

class MovieListViewModelTests: XCTestCase {

    var viewModel: MovieListViewModelProtocol!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        // Initialize the view model with some mock data
        let mockMovies = [
            MoviesSearchResponse.Result(genre: ["genre 1"], title: "Movie 1", synopsis: nil, type: nil, imdbid: nil, imdbrating: nil, released: 2022, imageurl: ["image1"]),
            MoviesSearchResponse.Result(genre: ["genre 2"], title: "Movie 2", synopsis: nil, type: nil, imdbid: nil, imdbrating: nil, released: nil, imageurl: ["image2"])
        ]
        viewModel = MovieListViewModel(movies: mockMovies)
    }

    override func tearDown() {
        disposeBag = nil
        viewModel = nil
        super.tearDown()
    }

    func testMovieTitle() {
        XCTAssertEqual(viewModel.movieTitle(for: 0), "Movie 1")
        XCTAssertEqual(viewModel.movieTitle(for: 1), "Movie 2")
    }

    func testMovieImage() {
        XCTAssertEqual(viewModel.movieImage(for: 0), "image1")
        XCTAssertEqual(viewModel.movieImage(for: 1), "image2")
    }

    func testMovieYearLabel() {
        XCTAssertEqual(viewModel.movieYearLabel(for: 0), "2022")
        XCTAssertEqual(viewModel.movieYearLabel(for: 1), "--")
    }

    func testMovieGenres() {
        XCTAssertEqual(viewModel.movieGenres(for: 0), ["genre 1"])
        XCTAssertEqual(viewModel.movieGenres(for: 1), ["genre 2"])
    }

    func testMoviesCount() {
        XCTAssertEqual(viewModel.moviesCount, 2)
    }
}
