//
//  MovieListViewController.swift
//  Movies
//
//  Created by Lucas Brandão on 26/01/21.
//

import UIKit

class MovieListViewController: UIViewController{
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    var movies: [MoviesSearchResponse.Result] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    init(movies: [MoviesSearchResponse.Result]) {
        super.init(nibName: nil, bundle: nil)
        self.movies = movies
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .darkCustomColor
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.topViewController?.title = "Movies"
        applyViewCode()
    }
}

extension MovieListViewController: ViewCodeConfig{
    func buildHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.pin(to: view)
    }
    
    func configureViews() {
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: "MovieListTableViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
//        let genres = movie.genre?.genresString()
        cell.movieImageView.downloaded(from: movie.imageurl?.first ?? "")
        cell.titleLabel.text = movie.title
        cell.yearLabel.text = movie.released == nil ? "--" : "\(movie.released ?? 0)"
        
        if movie.genre?.count ?? 0 > 0, let genreString = movie.genre?.first{
            cell.firstGenreLabel.text = " " +  genreString + " "
        }
        if movie.genre?.count ?? 0 > 1, let genreString = movie.genre?[1]{
            cell.secondGenreLabel.text = " " +  genreString + " "
        }
        cell.applyViewCode()
        return cell
    }
    
}
