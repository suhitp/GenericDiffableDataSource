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
        contentView.backgroundColor = .random
        titleLabel.textColor = .white
    }
    
    func render(with playlist: Playlist) {
        titleLabel.text = playlist.title
        Nuke.loadImage(with: URL(string: playlist.imageUrl)!, into: imageView)
    }
}
