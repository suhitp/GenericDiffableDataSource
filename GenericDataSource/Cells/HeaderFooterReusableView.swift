//
//  HeaderFooterReusableView.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 04/11/20.
//

import UIKit

class HeaderFooterReusableView: UICollectionReusableView, NibReusable {

    @IBOutlet var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .lightGray
    }
    
    func render(with header: String) {
        headerLabel.text = header
    }
}
