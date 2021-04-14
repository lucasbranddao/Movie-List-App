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
    let genresLabel = UILabel(frame: .zero)
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
        grayView.addSubview(genresLabel)
    }
    
    func setupConstraints() {
        //Content View
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 80).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 180).isActive = true
        
        //Gray View
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0).isActive = true
        grayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0).isActive = true
        grayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0).isActive = true
        grayView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60.0).isActive = true
        
        //Image View
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.leftAnchor.constraint(equalTo: grayView.leftAnchor, constant: -65).isActive = true
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true

        
        //Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 35).isActive = true
        titleLabel.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: grayView.rightAnchor, constant: -15).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true

        //Year Label
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        yearLabel.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        yearLabel.rightAnchor.constraint(equalTo: grayView.rightAnchor, constant: -15).isActive = true
        yearLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        yearLabel.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -8).isActive = true

        //Genres Label
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        genresLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 8).isActive = true
        genresLabel.rightAnchor.constraint(equalTo: grayView.rightAnchor, constant: -15).isActive = true
        genresLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
    }
    
    func configureViews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.backgroundColor = .clear
        
        grayView.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
        grayView.layer.cornerRadius = 12.0
        grayView.sizeToFit()
        
        movieImageView.contentMode = .scaleToFill
        movieImageView.layoutIfNeeded()
        movieImageView.layer.masksToBounds = true
        movieImageView.layer.cornerRadius = 8.0
        
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        
        yearLabel.textColor = .white
        
        genresLabel.numberOfLines = 0
        genresLabel.backgroundColor = .orangeCustomColor
        genresLabel.textColor = .white
        genresLabel.layer.cornerRadius = 8.0
        genresLabel.layer.masksToBounds = true
    }
}
