//
//  HomeCell.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 04/11/20.
//

import UIKit

class HomeCell: UITableViewCell, NibReusable {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = .random
    }
    
    func render(with component: Component) {
        titleLabel.text = component.title
        subTitleLabel.text = component.subtitle
    }
}
