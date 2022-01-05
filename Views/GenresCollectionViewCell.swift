//
//  GenresCollectionViewCell.swift
//  Movies
//
//  Created by Lucas Brandão on 25/01/21.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {
    
    lazy var label = PaddingLabel(frame: .zero)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(text: String){
        label.text = text
        applyViewCode()
        self.layoutSubviews()
    }
    
    func clickedOnCell(isSelected: Bool){
        label.textColor = isSelected ? .white : .orangeCustomColor
        label.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.orangeCustomColor.cgColor
        label.layer.backgroundColor = isSelected ? UIColor.orangeCustomColor.cgColor : UIColor.clear.cgColor
    }
}

extension GenresCollectionViewCell: ViewCodeConfig{
    func buildHierarchy() {
        contentView.addSubview(label)
    }
    
    func setupConstraints() {
        self.contentView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.pin(to: contentView)
    }
    
    func configureViews() {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.backgroundColor = .clear
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.orangeCustomColor.cgColor
        
        label.contentMode = .center
        label.textColor = .orangeCustomColor
    }
    
    
}
