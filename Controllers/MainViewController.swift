//
//  ViewController.swift
//  Movies
//
//  Created by Lucas Brandão on 23/01/21.
//

import UIKit
import WidgetKit
import CoreData

class MainViewController: UIViewController{
    
    //MARK: Components
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let contentView = UIView()
    let textField = UITextField()
    let searchButton = UIButton(frame: .zero)
    let genreHeader = HeaderLabel(text: "Genres")
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 5
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    //MARK: Variables
    let textFieldHeight = 50
    let padding: CGFloat = 15.0
    let collectionViewHeight: CGFloat = 200
    var genreSelectedIndexes: [Int] = []
    var genres: [String] = []{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .darkCustomColor
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyViewCode()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        getGenres()
    }
    
    
    func getGenres(){
        let cachedGenres = GenresData().getGenres()
        if !cachedGenres.isEmpty{
            self.genres = cachedGenres
        }
        else{
            GenresService().getGenres(completion: { response, error in
                guard let genres = response else { return }
                self.genres = genres
                GenresData().saveGenres(genres: genres)
            })
        }
    }
    
    @objc func pressed(sender: UIButton!) {
        let selectedGenres = genreSelectedIndexes.map({ genres[$0] })
        
        //Search By Name
        if let title = textField.text, title.trimmingCharacters(in: .whitespaces) > ""{
            MoviesSearchService().getMoviesByTitle(title: title, completion: { response, error in
                guard var movies = response?.results else { return }
                if !selectedGenres.isEmpty{
                    movies = movies.filter({ ($0.genre?.contains(where: selectedGenres.contains) ?? false) })
                }
                self.navigationController?.pushViewController(MovieListViewController(movies: movies), animated: true)
            })
        }
        
        //Search By Genre
        else{
            MoviesSearchService().getMoviesAdvanced(genres: selectedGenres, completion: { response, error in
                guard let movies = response?.results else { return }
                self.navigationController?.pushViewController(MovieListViewController(movies: movies), animated: true)
            })
        }
    }

}

//MARK: Views's setup
extension MainViewController: ViewCodeConfig{
    func buildHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addSubview(textField)
        stackView.addSubview(genreHeader)
        stackView.addSubview(collectionView)
        view.addSubview(searchButton)
    }
    
    func setupConstraints() {
        //ScrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.pin(to: view)

        //contentView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        //To scrolling be possible
        let bottom  = contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        bottom.isActive = true
        bottom.priority = UILayoutPriority(rawValue: 250)
        let centerY = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        centerY.isActive = true
        centerY.priority = UILayoutPriority(rawValue: 250)

        //StackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.pin(to: contentView)
        
        //TextField
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: padding).isActive = true
        textField.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -padding).isActive = true
        textField.topAnchor.constraint(equalTo: stackView.topAnchor, constant: padding).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Genre Header
        genreHeader.translatesAutoresizingMaskIntoConstraints = false
        genreHeader.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: padding).isActive = true
        genreHeader.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -padding).isActive = true
        genreHeader.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: padding).isActive = true
        genreHeader.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //CollectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.pin(to: stackView, sides: [.right, .left])
        collectionView.topAnchor.constraint(equalTo: genreHeader.bottomAnchor, constant: 40).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight).isActive = true
        
        //Search button
        let bottomPadding = 0.09*view.frame.height
        let rightPadding = 0.09*view.frame.width
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightPadding).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomPadding).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 75).isActive = true

    }
    
    func configureViews() {
        //ScrollView
        scrollView.delegate = self
        scrollView.backgroundColor = .clear
        
        //StackView
        stackView.backgroundColor = .clear
        
        //TextField
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: Double(textFieldHeight)-6, width: Double(view.frame.width-(2*padding)), height: 0.5)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.textColor = .white
        textField.layer.addSublayer(bottomLine)
        textField.backgroundColor = .clear
        textField.returnKeyType = .done
        let placeholderText = NSAttributedString(string: "Movies, TV Series...",
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.attributedPlaceholder = placeholderText
            
        //CollectionView
        collectionView.register(GenresCollectionViewCell.self, forCellWithReuseIdentifier: "GenresCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 50)
        
        //searchButton
        searchButton.layer.shadowRadius = 5
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowOpacity = 1
        searchButton.setTitle("Go", for: .normal)
        searchButton.layer.cornerRadius = 37.5
        searchButton.backgroundColor = .orangeCustomColor
        searchButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)

    }
}

//MARK: CollectionView Setup
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let genreCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCollectionViewCell", for: indexPath) as? GenresCollectionViewCell else{ return UICollectionViewCell() }
        let index = indexPath.item
        genreCell.setCell(text: genres[index])
        return genreCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        UserDefaults.group.set(genres[index], forKey: "genre")
        WidgetCenter.shared.reloadAllTimelines()
        
        if genreSelectedIndexes.contains(index) {
            genreSelectedIndexes.removeAll(where: { $0 == index })
        }
        else{
            genreSelectedIndexes.append(index)
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as? GenresCollectionViewCell
        cell?.clickedOnCell(isSelected: genreSelectedIndexes.contains(index))
    }
}

extension MainViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //search
        return true
    }
}

extension MainViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

