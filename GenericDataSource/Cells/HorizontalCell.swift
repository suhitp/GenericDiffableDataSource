//
//  HorizontalCell.swift
//  Example-iOS
//
//  Created by Suhit Patil on 31/10/20.
//  Copyright © 2020 Ryo Aoyama. All rights reserved.
//

import UIKit
import Nuke

class HorizontalCell: UICollectionViewCell, NibReusable {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let url = URL(string: "https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-12-pro-max-4.jpg")!
        Nuke.loadImage(with: url, into: imageView)
    }
    
    func render(with playlist: Playlist) {
        titleLabel.text = playlist.title
        titleLabel.textColor = .white
    }
}
