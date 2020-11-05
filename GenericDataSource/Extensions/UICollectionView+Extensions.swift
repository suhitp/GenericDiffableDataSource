//
//  UICollectionView+Extensions.swift
//  GenericDataSource
//
//  Created by Suhit Patil on 05/11/20.
//

import UIKit

public extension UICollectionView {
    
    enum SectionHeaderFooterElementKind: Equatable {
        case header
        case footer
        
        public var rawValue: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }
}


public extension UITableView {
    
    enum SectionHeaderFooterElementKind: Equatable {
        case header
        case footer
    }
}
