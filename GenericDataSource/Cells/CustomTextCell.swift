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
        // Initialization code
        
        let url = URL(string: "https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-12-pro-max-3.jpg")!
        Nuke.loadImage(with: url, into: thumbnailImageView)
        
        contentView.backgroundColor = .random
    }

}
