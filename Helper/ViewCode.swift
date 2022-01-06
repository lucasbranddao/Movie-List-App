//
//  viewCode.swift
//  Movies
//
//  Created by Lucas Brandão on 24/01/21.
//

import UIKit


protocol ViewCodeConfig{
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeConfig{
    func applyViewCode(){
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
