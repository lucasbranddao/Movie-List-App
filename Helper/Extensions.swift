//
//  Extensions.swift
//  Movies
//
//  Created by Lucas Brandão on 23/03/22.
//

import Foundation
import UIKit

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

fileprivate var spinner: UIActivityIndicatorView?

extension UIViewController{
    
    func startLoading(){
        let size: CGFloat = 80
        spinner = UIActivityIndicatorView(frame: CGRect(x: view.frame.midX - (size/2), y: view.frame.midY - (size/2), width: size, height: size))
        guard let spinner = spinner else {
            return
        }
        spinner.color = .white
        spinner.backgroundColor = .black.withAlphaComponent(0.7)
        spinner.layer.cornerRadius = 8.0
        spinner.style = .medium
        spinner.startAnimating()
        view.addSubview(spinner)
    }
    
    func stopLoading(){
        guard let spinner = spinner else {
            return
        }
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
}
