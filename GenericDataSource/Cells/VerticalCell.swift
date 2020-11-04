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
    }
    
    func render(with carousel: Carousel) {
        title.text = carousel.title
        contentView.backgroundColor = .random
        Nuke.loadImage(with: URL(string: carousel.imageUrl)!, into: imageView)
    }

}
