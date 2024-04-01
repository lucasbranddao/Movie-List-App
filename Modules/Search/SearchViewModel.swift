//
//  SearchViewModel.swift
//  Movies
//
//  Created by Lucas Brandão on 23/03/22.
//

import UIKit
import RxSwift
import RxCocoa
import WidgetKit

protocol SearchViewModelProtocol {
    func fetchGenres()
    func search()
    func genreClicked(index: Int)
    func isSelected(index: Int) -> Bool
}

final class SearchViewModel: SearchViewModelProtocol {
    
    var fetchedData = PublishSubject<Bool>()
    var genres: [String] = []
    var selectedGenres: [String] = []
    var title = BehaviorRelay<String>(value: "")
    var searching = PublishSubject<[MoviesSearchResponse.Result]>()
    let genresData: GenresDataProtocol

    init(genresData: GenresDataProtocol = GenresData()) {
        self.genresData = genresData
    }
    
    func fetchGenres(){
        let cachedGenres = genresData.getGenres()
        if !cachedGenres.isEmpty{
            handleResponse(genres: cachedGenres)
        }
        else{
            GenresService().getGenres(completion: { [weak self] response, error in
                self?.handleResponse(genres: response)
            })
        }
    }
    
    func search(){
        //Search By Name
        if title.value.trimmingCharacters(in: .whitespaces) > ""{
            MoviesSearchService().getMoviesByTitle(title: title.value, completion: { [weak self] response, error in
                guard var movies = response?.results else { return }
                guard let selectedGenres = self?.selectedGenres else { return }
                if !selectedGenres.isEmpty{
                    movies = movies.filter({ ($0.genre?.contains(where: selectedGenres.contains) ?? false) })
                }
                self?.searching.onNext(movies)
            })
        }
        
        //Search By Genre
        else{
            MoviesSearchService().getMoviesAdvanced(genres: selectedGenres, completion: { [weak self] response, error in
                guard let movies = response?.results else { return }
                self?.searching.onNext(movies)
            })
        }
    }
    
    func genreClicked(index: Int){
        if let genre = genres[safe: index]{
            if selectedGenres.contains(genre){
                selectedGenres.removeAll(where: { $0 == genre })
            }
            else{
                selectedGenres.append(genre)
                UpdateWidget(genre: genre)
            }
        }
    }
    
    func isSelected(index: Int) -> Bool{
        return selectedGenres.contains(where: { $0 == genres[safe: index] })
    }
    
    private func handleResponse(genres: [String]?){
        guard let genres = genres else {
            self.fetchedData.onNext(false)
            return
        }
        self.genres = genres
        fetchedData.onNext(true)
        fetchedData.onCompleted()
        genresData.saveGenres(genres: genres)
    }
    
    private func UpdateWidget(genre: String){
        //Widget info
        UserDefaults.group.set(genre, forKey: "genre")
        WidgetCenter.shared.reloadAllTimelines()
    }

}
