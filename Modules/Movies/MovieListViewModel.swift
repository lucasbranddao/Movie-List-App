//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Lucas Brandão on 06/04/22.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewModel{

    var movies = PublishSubject<[MoviesSearchResponse.Result]>()
    var moviesValues: [MoviesSearchResponse.Result] = []
    var moviesCount = 0
    
    init(movies: [MoviesSearchResponse.Result]) {
        self.moviesCount = movies.count
        self.movies.onNext(movies)
        self.moviesValues = movies
    }
    
    func movieTitle(for index: Int) -> String{
        return moviesValues[index].title ?? ""
    }
    
    func movieImage(for index: Int) -> String{
        return moviesValues[index].imageurl?.first ?? ""
    }
    
    func movieYearLabel(for index: Int) -> String{
        let movie = moviesValues[index]
        return movie.released == nil ? "--" : "\(movie.released ?? 0)"
    }

    func movieGenres(for index: Int) -> [String]{
        return moviesValues[index].genre ?? []
    }
}
