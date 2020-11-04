//
//  EmojiCell.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 04/11/20.
//

import UIKit

class EmojiCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet var emojiLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        emojiLabel.layer.cornerRadius = 8
        contentView.backgroundColor = .init(white: 1, alpha: 0.5)
    }

    func render(with emoji: String) {
        emojiLabel.text = emoji
    }
}
