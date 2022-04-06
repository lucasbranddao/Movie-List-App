//
//  MovieListViewController.swift
//  Movies
//
//  Created by Lucas Brandão on 26/01/21.
//

import UIKit
import RxSwift

class MovieListViewController: UIViewController{
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    private var viewModel: MovieListViewModel!
    private lazy var bag = DisposeBag()
    
    init(movies: [MoviesSearchResponse.Result]) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = MovieListViewModel(movies: movies)
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
    
    private func setObservable(){
        viewModel?.movies.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: bag)
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
        return viewModel.moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
        cell.movieImageView.image = UIImage(named: "defaultMovieImage")
        cell.movieImageView.downloaded(from: viewModel.movieImage(for: indexPath.row))
        cell.titleLabel.text = viewModel.movieTitle(for: indexPath.row)
        cell.yearLabel.text = viewModel.movieYearLabel(for: indexPath.row)
        let genres = viewModel.movieGenres(for: indexPath.row)
        if genres.count > 0, let genreString = genres.first{
            cell.firstGenreLabel.text = " " +  genreString + " "
        }
        if genres.count > 1{
            cell.secondGenreLabel.text = " " +  genres[1] + " "
        }
        cell.applyViewCode()
        return cell
    }
    
}
