//
//  UIViewExtensions.swift
//  Movies
//
//  Created by Lucas Brandão on 24/01/21.
//

import UIKit

enum Side{
    case top
    case left
    case right
    case bottom
}

extension UIView{
    func pin(to superView: UIView, sides: [Side] = [.top, .right, .bottom, .left]){
        translatesAutoresizingMaskIntoConstraints = false
        if sides.contains(.top){
            topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        }
        if sides.contains(.right){
            trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        }
        if sides.contains(.bottom){
            bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        }
        if sides.contains(.left){
            leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        }
    }
}

extension Array where Element == String{
    func genresString() -> String{
        var string = " |"
        for genre in self{
            string.append(" \(genre) |")
        }
        return self.isEmpty ? "" : string
    }
}

class HeaderLabel: UILabel{
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()

    }

    init(text: String, withPadding: Bool = false) {
        super.init(frame: .zero)
        commonInit()
        self.text = withPadding ? text : "  " + text
    }
    func commonInit(){
        textColor = .white
        font = UIFont.boldSystemFont(ofSize: 30.0)
    }
}


class PaddingLabel: UILabel {

    var topInset: CGFloat = 5.0
    var bottomInset: CGFloat = 5.0
    var leftInset: CGFloat = 7.0
    var rightInset: CGFloat = 7.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
