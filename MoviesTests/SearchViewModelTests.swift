//
//  SearchViewModelTests.swift
//  MoviesTests
//
//  Created by Lucas Brandão on 10/10/23.
//

import XCTest
import RxSwift
@testable import Movies

class SearchViewModelTests: XCTestCase {

    var sut: SearchViewModel!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        let mockGenresService = GenresServiceMock()
        sut = SearchViewModel(genresData: GenresDataSpy())
        disposeBag = DisposeBag()
    }

    // ... Other setup and teardown methods

    func testFetchGenres_Success() {
        // Given
        // Set up the mockGenresService to return genres.

        // When
        sut.fetchGenres()

        // Then
        // Assert that the fetchedData is updated appropriately.
        sut.fetchedData.subscribe(onNext: { success in
            XCTAssertTrue(success, "Fetch genres should be successful.")
        }).disposed(by: disposeBag)
    }

    func testFetchGenres_Failure() {
        // Given
        // Set up the mockGenresService to return an error.

        // When
        sut.fetchGenres()

        // Then
        // Assert that the fetchedData is updated appropriately for the failure case.
        sut.fetchedData.subscribe(onNext: { success in
            XCTAssertFalse(success, "Fetch genres should fail.")
        }).disposed(by: disposeBag)
    }

}
