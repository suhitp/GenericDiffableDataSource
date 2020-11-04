//
//  CustomTextCell.swift
//  Example-iOS
//
//  Created by Suhit Patil on 31/10/20.
//  Copyright © 2020 Ryo Aoyama. All rights reserved.
//

import UIKit
import Nuke

class CustomTextCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .random
    }
    
    func render(with ads: Ads) {
        Nuke.loadImage(with: URL(string: ads.imageUrl)!, into: thumbnailImageView)
    }

}
