//
//  VerticalCell.swift
//  Example-iOS
//
//  Created by Suhit Patil on 31/10/20.
//  Copyright © 2020 Ryo Aoyama. All rights reserved.
//

import UIKit
import Nuke

class VerticalCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let url = URL(string: "https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-12-pro-max-1.jpg")!
        Nuke.loadImage(with: url, into: imageView)
    }
    
    func render(with carousel: Carousel) {
        title.text = carousel.title
        contentView.backgroundColor = .random
    }

}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
