//
//  MovieListTableViewCell.swift
//  Movies
//
//  Created by Lucas Brandão on 26/01/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    let grayView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let movieImageView = UIImageView(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    let firstGenreLabel = UILabel(frame: .zero)
    let secondGenreLabel = UILabel(frame: .zero)
    let yearLabel = UILabel(frame: .zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension MovieListTableViewCell: ViewCodeConfig{
    func buildHierarchy() {
        contentView.addSubview(grayView)
        grayView.addSubview(movieImageView)
        grayView.addSubview(titleLabel)
        grayView.addSubview(yearLabel)
        grayView.addSubview(firstGenreLabel)
        grayView.addSubview(secondGenreLabel)
    }
    
    func setupConstraints() {
        //Content View
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220).isActive = true
        
        //Gray View
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0).isActive = true
        grayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0).isActive = true
        grayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0).isActive = true
        grayView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200.0).isActive = true
        
        //Image View
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.leftAnchor.constraint(equalTo: grayView.leftAnchor, constant: 15).isActive = true
        movieImageView.centerYAnchor.constraint(equalTo: grayView.centerYAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true

        //Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 35).isActive = true
        titleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: grayView.rightAnchor, constant: -15).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true

        //Year Label
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        yearLabel.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        yearLabel.rightAnchor.constraint(equalTo: grayView.rightAnchor, constant: -15).isActive = true
        yearLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        //Genre Labels
        firstGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        firstGenreLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        firstGenreLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 8).isActive = true
        firstGenreLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        // --
        secondGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        secondGenreLabel.leftAnchor.constraint(equalTo: firstGenreLabel.rightAnchor, constant: 4.0).isActive = true
        secondGenreLabel.centerYAnchor.constraint(equalTo: firstGenreLabel.centerYAnchor).isActive = true
        secondGenreLabel.rightAnchor.constraint(lessThanOrEqualTo: grayView.rightAnchor, constant: -15).isActive = true
        secondGenreLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
    }
    
    func configureViews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.backgroundColor = .clear
        
        grayView.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
        grayView.layer.cornerRadius = 8.0
        grayView.sizeToFit()
        
        movieImageView.contentMode = .scaleToFill
        movieImageView.layoutIfNeeded()
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.cornerRadius = 8.0
        
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        
        yearLabel.textColor = .white
        
        firstGenreLabel.numberOfLines = 1
        firstGenreLabel.backgroundColor = .orangeCustomColor
        firstGenreLabel.textColor = .white
        firstGenreLabel.layer.cornerRadius = 8.0
        firstGenreLabel.layer.masksToBounds = true
        
        secondGenreLabel.numberOfLines = 1
        secondGenreLabel.backgroundColor = .orangeCustomColor
        secondGenreLabel.textColor = .white
        secondGenreLabel.layer.cornerRadius = 8.0
        secondGenreLabel.layer.masksToBounds = true
    }
}
